/*
DiffOriginByROI.s
Gradually move the origin to verify.
For the numbers 4 (left), 6 (right), 8 (up), and 2 (down),
the movement step is +(doubled), -(halved), 
or / to return to the original step value;
 press the spacebar to confirm. For example,
if you place the ROI Band Pass tool (the doughnut-like icon), 
it draws a circle centered on the origin, 
allowing you to adjust the spot position while viewing it.
2026.2.28 Kimoto
*/

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
