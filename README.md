# DigitalMicrograph scripts  

- [DigitalMicrograph scripts](#digitalmicrograph-scripts)
  - [Display tools](#display-tools)
    - [ROI (rect) synchronized on two images](#roi-rect-synchronized-on-two-images)
    - [Display aligned windows](#display-aligned-windows)
    - [Display 3D-slices as film roll](#display-3d-slices-as-film-roll)
    - [Display in pseudo color](#display-in-pseudo-color)
    - [Display two images with same LUT](#display-two-images-with-same-lut)
  - [Calibration tools](#calibration-tools)
    - [Diffraction centering](#diffraction-centering)
  - [Experimantal tools](#experimantal-tools)
    - [EELS ZLP tracker](#eels-zlp-tracker)
    - [Current tracker](#current-tracker)
    - [Drift tracker](#drift-tracker)
    - [Multiple STEM imaging](#multiple-stem-imaging)
    - [Multiple TEM imaging](#multiple-tem-imaging)
  - [Analysis tools](#analysis-tools)
    - [R-Phi transformation](#r-phi-transformation)
    - [Masking 4D](#masking-4d)
    - [Unfolding (4D-\>2D) and refolding (2D-\>4D)](#unfolding-4d-2d-and-refolding-2d-4d)
    - [Heatmap 3D](#heatmap-3d)
    - [NMF using Scikit-Learn on DM](#nmf-using-scikit-learn-on-dm)
  - [将来的に作る・公開するもの](#将来的に作る公開するもの)
    - [Clustering](#clustering)
    - [Higtogram](#higtogram)
  - [Example Scripts Categories](#example-scripts-categories)




## Display tools  

### ROI (rect) synchronized on two images    
[SyncRectOn2Img.s](scripts/SyncRectOn2Img.s)    
２つの画像に同じROI(Rectangle)を同期するように設定。1番上の画像のROIを参照にして2番目の画像にROIを配置・同期。同じ場所を切り出したい場合などに使用。  
Set the synchronized ROIs (rectangle) on the frontmost two images. Use the ROI on the top image as a reference to place and synchronize the ROI on the second image. It might be useful when you want to crop the same area.  

### Display aligned windows  
[AlignWindowHorV.s](scripts/AlignWindowHorV.s)    
２つのWindowを縦あるいは横に並べて表示。  
Display two windows side by side vertically or horizontally.  

<img alt="Aligh and synchronize rect ROI" src="img/AlignWinSyncRect.png" width="400px">

### Display 3D-slices as film roll  
[FilmRoll.s](scripts/FilmRoll.s)  
3Dスタック画像を、縦あるいは横につなげて２次元表示。並べて観察したい場合、同じLUTで観察したい場合に。  
Display 3D images vertically or horizontally as a 2D film roll. For cases where you want to view them side by side or observe them using the same LUT.  
<img alt="Holizontal film roll example" src="img/filmRollH.png" width="700px">

### Display in pseudo color  
[PseudoColorBlueWhiteRed.s](scripts/PseudoColorBlueWhiteRed.s)  
決まった強度範囲を青－白－赤の疑似カラーで表示。COLUGradientColorCLUT()を使った精密な設定方法。  
Display a specified intensity range using blue-white-red pseudo-colors. Precise configuration method using COLUGradientColorCLUT().  
<img alt="Pseudo color Blue-White-Red" src="img/SetPseudoColor.png" width="400px">


### Display two images with same LUT
一番上の画像と同じ表示条件(表示強度範囲やカラーテーブル)で、２番目の画像を表示。  
Display the second image using the same display conditions (display intensity range and color table) as the top image.  
``` C++  
// 1. Select source and target images
    image imgFrom, imgTo
    if ( !GetTwoLabeledImagesWithPrompt( "Select 'Source' and 'Target' images", "Copy Display Settings", "Source", imgFrom, "Target", imgTo ) ) exit(0) 
// 2. Get ImageDisplay objects
    ImageDisplay dspFrom = imgFrom.ImageGetImageDisplay( 0 ) 
    ImageDisplay dspTo   = imgTo.ImageGetImageDisplay( 0 ) 
// 3. Get display information from source image
    number low, high, bright, contrast, gamma
    dspFrom.ImageDisplayGetContrastLimits( low, high ) 
    dspFrom.ImageDisplayGetContrastParameters( bright, contrast ) 
    gamma = dspFrom.ImageDisplayGetGammaCorrection() 
// 4. Get the Input Color Table (CLUT) image from source
// Important: Use := to assign the image reference
    image colorTableIN := dspFrom.ImageDisplayGetInputColorTable() 
// 5. Apply settings to target image
// Disable AutoSurvey to prevent the image from automatically resetting limits
    dspTo.ImageDisplaySetDoAutoSurvey( 0 ) 
    dspTo.ImageDisplaySetContrastLimits( low, high ) 
    dspTo.ImageDisplaySetContrastParameters( bright, contrast ) 
    dspTo.ImageDisplaySetGammaCorrection( gamma ) 
// 6. Apply the source Color Table to target
    dspTo.ImageDisplaySetInputColorTable( colorTableIN ) 
// 7. Force the image to update with new display settings
    imgTo.UpdateImage() 
```


  
## Calibration tools

### Diffraction centering  
下記のscriptを使うと、ROIで回折図形の中心にpoint(+)をおいたり、あるいは同じ面間隔の回折スポットを通るようにoval(〇)を描き、原点を決めることができます。    

Using the script below, you can place a point (+) at the center of the diffraction pattern within the ROI, or draw an oval (○) passing through diffraction spots with the same plane spacing to define the origin.  
``` C++
// Origin calibration using oval/rectangle/line/point ROI
image 			img :=getfrontimage()
imageDisplay	imgDsp = img.ImageGetImageDisplay( 0 )
ImageDisplaySetCaptionOn( imgDsp, 1 )   // Enable captions to make the origin visible.
// Ensure there is exactly one ROI.
      number n_ROI = imgDsp.ImageDisplayCountROIS() 
        if(n_ROI ==0) {OkDialog("Put oval/point/rectangle/line ROI\nCalibration is aborted."); exit(0)
                }
        if(n_ROI !=1) {OkDialog("Put only one ROI.\nCalibration is aborted."); exit(0)
                }
// Variables
  number centerX, centerY	
  number top,left, bottom, right		// oval, rectangle
  number startX, startY, endX, endY	// line
  number pointX, pointY				      // point
  string unit
  number originalX, originalY 
  number scaleX, scaleY
// Retrieve current calibration settings.
  ImageGetDimensionCalibration(img, 0, originalX, scaleX, unit, 1 )
  ImageGetDimensionCalibration(img, 1, originalY, scaleY, unit, 1 )
// Read the ROI coordinates
  result("\n\nROI coordinates:")
    ROI crrROI = ImgDsp.ImageDisplayGetROI( 0 )
if (ROIisPoint(crrROI)){ 	        ROIGetPoint(crrROI, pointX, pointY) ; result("\tPoint")
         centerX = pointX			; centerY = pointY
         result("\n\t(pointX,pointY):("+pointX+" ,"+pointY+")")
         }
  else if (ROIisOval(crrROI)){		ROIGetOval(crrROI, top, left, bottom, right) ; result("\tOval")	
         centerX = (right  + left)/2; centerY = (bottom + top )/2
         result("\n\t(top,left,bottom,right):("+top+" ,"+left+" ,"+bottom+" ,"+right+")")
         }
  else if (ROIisRectangle(crrROI)){ ROIGetRectangle(crrROI,top,left,bottom,right);result("\tRectangle")
         centerX = (right  + left)/2; centerY = (bottom + top )/2
         result("\n\t(top,left,bottom,right):("+top+" ,"+left+" ,"+bottom+" ,"+right+")")
         }
  else if (ROIisLine(crrROI)){ 	    ROIGetline(crrROI, startX, startY, endX, endY) ; result("\tLine")
    centerX = (startX + endX)/2; centerY = (startY + endY)/2
         result("\n\t(startX,Y,endX,Y):(" + startX +" ," + startY +" ," +endX+" ,"+ endY + ")")
         }
  else {
    OkDialog("Loop/Curve ROI cannot be used.\nPut oval/point/rectangle/line ROI.\nCalibration is aborted.")
    exit(0)
    }
result("\n\t(centerX, centerY)     :(" + centerX +" ," + centerY +" )")
if(centerX==0 || centerY==0){
    if(!OkCancelDialog("Origin is set to (" + centerX + ", "+ centerY + " ). ")) exit(0)
    }
// Apply Calibration
ImageSetDimensionCalibration(img, 0, centerX , scaleX, unit, 1 )	// Set x-axis origin here.
ImageSetDimensionCalibration(img, 1, centerY , scaleY, unit, 1 )  // Set y-axis origin here.
result("\nOriginal  origin (x,y): " + originalX + " , " + OriginalY )  
result("\nCorrected origin (x,y): " + centerX + " , " + centerY )

```

Originを少しずつ動かして確認。数字の4(左)、6(右)、8(上)、2(下)で、動くステップは+(2倍)、-(半分)、/で元のステップ値に戻し、スペースバーで決定。例えば、ROIのBand Pass tool(ドーナッツのようなマーク)をおいておくと、原点を中心とする円を描きますのでそれを見ながらスポット位置の調整が可能。  
Gradually move the origin to verify. For the numbers 4 (left), 6 (right), 8 (up), and 2 (down), the movement step is +(doubled), -(halved), or / to return to the original step value; press the spacebar to confirm. For example, if you place the ROI Band Pass tool (the doughnut-like icon), it draws a circle centered on the origin, allowing you to adjust the spot position while viewing it.     
``` C++
image img:=getfrontimage()
string unit
number originalX, originalY, scaleX, scaleY
ImageGetDimensionCalibration(img, 0, originalX, scaleX, unit, 1 )
ImageGetDimensionCalibration(img, 1, originalY, scaleY, unit, 1 )
result("\nOriginal  origin (x,Y): " + originalX + " , " + originalY )
number preX = originalX
number preY = originalY
number OriginalStrength =1
number strength = OriginalStrength
number key
OpenAndSetProgressWindow("Aligh Origin","( "+ preX +" , "+preY + " )  step: " + strength ,"Space to abort")
while(key!=32){ // Continue until Space bar (key=32) is pressed.
    key=GetKey()
    if(key ==56) preY -= strength            // up      8  
    if(key ==50) preY += strength            // down    2  
    if(key ==52) preX -= strength            // left    4  
    if(key ==54) preX += strength            // right   6  
    if(key ==47){                            // Back to original origin(x,y) 5
        preX = originalX
        preY = originalY
    }
    if(key ==43) strength *= 2               //  +
    if(key ==45) strength /= 2               //  -
    if(key ==42) strength = OriginalStrength //  *
    OpenAndSetProgressWindow("Aligh Origin","( "+preX+" , "+preY+" )  step: "+strength,"Space to abort")  
    ImageSetDimensionCalibration(img, 0, preX , scaleX, unit, 1 )  
    ImageSetDimensionCalibration(img, 1, preY , scaleY, unit, 1 )  
    UpdateImage(img)  
}
result("\nCorrected origin (x,y): " + preX + " , " + preY )
CloseProgressWindow()
```


## Experimantal tools  

### EELS ZLP tracker  
### Current tracker  
### Drift tracker  
### Multiple STEM imaging  
### Multiple TEM imaging



## Analysis tools  

### R-Phi transformation
U-V to R-Phi (2D)  
    U-V to R-Phi (4D)  
R-Phi to U-V (2D)  
    R-Phi to U-V (4D)    

### Masking 4D  
4Dデータに2Dデータでマスクをかける
    img4Dmasked(img4D, img2D)  
 
### Unfolding (4D->2D) and refolding (2D->4D)  
 Matrix計算するときにまずは4D/3Dデータをmatrixにする必要があるため使用する。
    img4Dto2D  
    img2Dto4D

### Heatmap 3D  
３Dデータの各画像間の相互相関等をheatmap化
Cosine similarity, Correlation coefficient, Maximum of cross correlationなどを表示

### NMF using Scikit-Learn on DM  






------------------------------  
## 将来的に作る・公開するもの  
------------------------------  

### Clustering  

### Higtogram  
ヒストグラムを、所望の範囲とステップで作成。  

## Example Scripts Categories  
- Simple Image Computation
- Data Display
- Tags, TagGroups and TagLists
- ROIs
- Strings
- Annotations and Components
- Files
- Dialogs
- Objects and Interfaces
- Application Examples
- Further Examples

