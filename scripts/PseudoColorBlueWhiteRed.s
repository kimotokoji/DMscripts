/* PseudoColorBlueWhiteRed.s           
Display 3D images vertically or horizontally as a 2D film roll.
For cases where you want to view them side by side or observe them using the same LUT.
Pseudo color map from -1(blue) - 0(white) - 1(red) 
2026.02.27 Kimoto
*/

void SetCustomLUT(image img)
{
 imageDisplay disp = img.ImageGetImageDisplay( 0 )
 ImageDisplaySetDoAutoSurvey( disp, 0 )
 // Contrast limit (display range)
    number low  =  min(img)
    number high =  max(img)
    disp.ImageDisplaySetContrastLimits( low, high )
 // Brightness and contrast
    number bright   = 0.5			// 0.5 (= 50%) is standard.
    number contrast = 0.5			// 
    disp.ImageDisplaySetContrastParameters( bright, contrast )
 // Apply ad-hoc myLUT
    image myLUT:=  RGBimage("LUT Blue-White-Red", 4, 256, 1)
    myLUT[0,  0,  1, 128] = RGB((255)*((icol)/128), (255)*((icol)/128), 255)
    myLUT[0,128,  1, 256] = RGB(255, (255)-255*((icol)/128),(255)-255*((icol)/128) )
    disp.ImageDisplaySetInputColorTable( myLUT ) 
 showimage(myLUT)
}

image img:=getfrontimage()
setCustomLUT(img)