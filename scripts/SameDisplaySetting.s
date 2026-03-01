/* SameDisplaySetting.s           
Display the second image using the same display conditions
(display intensity range and color table) as the top image.  
2026.02.28 Kimoto
*/
// 1. Select source and target images
    image imgFrom, imgTo
    if ( !GetTwoLabeledImagesWithPrompt( "Select 'Source' and 'Target' images", \
    "Copy Display Settings", "Source", imgFrom, "Target", imgTo ) ) exit(0) 
    selectimage(imgFrom)
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
    selectimage(imgFrom)