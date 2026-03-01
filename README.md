# DigitalMicrograph scripts  

- [DigitalMicrograph scripts](#digitalmicrograph-scripts)
  - [Display tools](#display-tools)
    - [Display aligned windows: AlignWindowHorV.s](#display-aligned-windows-alignwindowhorvs)
    - [ROI (rect) synchronized on two images: SyncRectOn2Img.s](#roi-rect-synchronized-on-two-images-syncrecton2imgs)
    - [Display 3D-slices as film roll: FilmRoll.s](#display-3d-slices-as-film-roll-filmrolls)
    - [Display in pseudo color: PseudoColorBlueWhiteRed.s](#display-in-pseudo-color-pseudocolorbluewhitereds)
    - [Display two images with same LUT: SameDisplaySetting.s](#display-two-images-with-same-lut-samedisplaysettings)
  - [Calibration tools](#calibration-tools)
    - [Diffraction centering using ROI: DiffOriginByROI.s](#diffraction-centering-using-roi-difforiginbyrois)
    - [Diffraction centering using Numpad: DiffOriginByNumpad.s](#diffraction-centering-using-numpad-difforiginbynumpads)
  - [Experimantal tools](#experimantal-tools)
    - [EELS ZLP tracker (in prep)](#eels-zlp-tracker-in-prep)
    - [Current tracker (in prep)](#current-tracker-in-prep)
    - [Drift tracker (in prep)](#drift-tracker-in-prep)
    - [Multiple STEM imaging (in prep)](#multiple-stem-imaging-in-prep)
    - [Drift correction by ROI tracking (in prep)](#drift-correction-by-roi-tracking-in-prep)
    - [Multiple TEM imaging (in prep)](#multiple-tem-imaging-in-prep)
  - [Analysis tools](#analysis-tools)
    - [R-Phi U-V transformation (in prep)](#r-phi-u-v-transformation-in-prep)
    - [Masking 4D (in prep)](#masking-4d-in-prep)
    - [Unfolding and refolding (4D\<-\>2D) (in prep)](#unfolding-and-refolding-4d-2d-in-prep)
  - [Analysis tools](#analysis-tools-1)
    - [Heatmap 3D  (in prep)](#heatmap-3d--in-prep)
    - [NMF using Scikit-Learn on DM  (in prep)](#nmf-using-scikit-learn-on-dm--in-prep)
    - [Histogram (in prep)](#histogram-in-prep)




## Display tools  

### Display aligned windows: [AlignWindowHorV.s](scripts/AlignWindowHorV.s)    
２つのWindowを縦あるいは横に並べて表示。  
Display two windows side by side vertically or horizontally.  

### ROI (rect) synchronized on two images: [SyncRectOn2Img.s](scripts/SyncRectOn2Img.s)    
２つの画像に同じROI(Rectangle)を同期するように設定。1番上の画像のROIを参照にして2番目の画像にROIを配置・同期。同じ場所を切り出したい場合などに使用。  
Set the synchronized ROIs (rectangle) on the frontmost two images. Use the ROI on the top image as a reference to place and synchronize the ROI on the second image. It might be useful when you want to crop the same area.  

<img alt="Aligh and synchronize rect ROI" src="img/AlignWinSyncRect.png" width="400px">

### Display 3D-slices as film roll: [FilmRoll.s](scripts/FilmRoll.s)  
3Dスタック画像を、縦あるいは横につなげて２次元表示。並べて観察したい場合、同じLUTで観察したい場合に。  
Display 3D images vertically or horizontally as a 2D film roll. For cases where you want to view them side by side or observe them using the same LUT.  
<img alt="Holizontal film roll example" src="img/filmRollH.png" width="700px">

### Display in pseudo color: [PseudoColorBlueWhiteRed.s](scripts/PseudoColorBlueWhiteRed.s)  
決まった強度範囲を青－白－赤の疑似カラーで表示。  
Display a specified intensity range using blue-white-red pseudo-colors.  
<img alt="Pseudo color Blue-White-Red" src="img/SetPseudoColor.png" width="400px">

### Display two images with same LUT: [SameDisplaySetting.s](scripts/SameDisplaySetting.s)  
一番上の画像と同じ表示条件(表示強度範囲やカラーテーブル)で、２番目の画像を表示。  
Display the second image using the same display conditions (display intensity range and color table) as the top image.  



  
## Calibration tools

### Diffraction centering using ROI: [DiffOriginByROI.s](scripts/DiffOriginByROI.s)  
下記のscriptを使うと、ROIで回折図形の中心にpoint(+)をおいたり、あるいは同じ面間隔の回折スポットを通るようにoval(〇)を描き、原点を決めることができます。  
Using the script below, you can place a point (+) at the center of the diffraction pattern within the ROI, or draw an oval (○) passing through diffraction spots with the same plane spacing to define the origin.  

### Diffraction centering using Numpad: [DiffOriginByNumpad.s](scripts/DiffOriginByNumpad.s)  

Originを少しずつ動かして確認。数字の4(左)、6(右)、8(上)、2(下)で、動くステップは+(2倍)、-(半分)、/で元のステップ値に戻し、スペースバーで決定。例えば、ROIのBand Pass tool(ドーナッツのようなマーク)をおいておくと、原点を中心とする円を描きますのでそれを見ながらスポット位置の調整が可能。  
Gradually move the origin to verify. For the numbers 4 (left), 6 (right), 8 (up), and 2 (down), the movement step is +(doubled), -(halved), or / to return to the original step value; press the spacebar to confirm. For example, if you place the ROI Band Pass tool (the doughnut-like icon), it draws a circle centered on the origin, allowing you to adjust the spot position while viewing it.     


## Experimantal tools  

### EELS ZLP tracker (in prep)  
### Current tracker (in prep)    
### Drift tracker (in prep)   
### Multiple STEM imaging (in prep)   
### Drift correction by ROI tracking (in prep)
### Multiple TEM imaging (in prep)  

## Analysis tools  

### R-Phi U-V transformation (in prep)  
U-V to R-Phi (2D),  U-V to R-Phi (4D)  
R-Phi to U-V (2D),  R-Phi to U-V (4D)    

### Masking 4D (in prep)  
4Dデータに2Dデータでマスクをかける
    img4Dmasked(img4D, img2D)  
 
### Unfolding and refolding (4D<->2D) (in prep)    
 Matrix計算するためのunfoldingとrefolding。  
    img4Dto2D, img2Dto4D  
       

  

## Analysis tools  

### Heatmap 3D  (in prep)
３Dデータの各画像間の相互相関等をheatmap化
Cosine similarity, Correlation coefficient, Maximum of cross correlationなどを表示

### NMF using Scikit-Learn on DM  (in prep)
Primitive NMF using Scikit-learn


### Histogram (in prep)  
ヒストグラムを、所望の範囲とステップで作成。  

<!-- コメント
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
-->

