/* SyncRectOn2Img.s           
  Synchronize Rectangle ROIs 
  Set the synchronized ROIs (rectangle) on the frontmost two images.
  - Use the ROI on the top image as a reference to place 
    and synchronize the ROI on the second image. 
  - It might be useful when you want to crop the same area.
  2026.02.27 Kimoto
*/

// 1. Get the front-most image (img1)
    image img1
    if ( !GetFrontImage( img1 ) ) Throw( "No image displayed." ) 
// 2. Get the second front-most image (img2)
    image img2 := FindNextImage( img1 )
    if ( !img2.ImageIsValid() ) Throw( "Second image not found." ) 
// 3. Get the ImageDisplay object for each image
    imageDisplay disp1 = img1.ImageGetImageDisplay( 0 ) 
    imageDisplay disp2 = img2.ImageGetImageDisplay( 0 )
// 4. Look for a rectangle ROI on img1
    ROI theROI
    number nROI = disp1.ImageDisplayCountROIs() 
    number found = 0
    for ( number i = 0; i < nROI; i++ )
    {
        ROI tempROI = disp1.ImageDisplayGetROI( i ) 
        if ( tempROI.ROIIsRectangle() ) 
        {
         theROI = tempROI
         found = 1
         break
        }
    }
// 5. If no ROI on the frontmost
    if(found==0) 
    {
    result("\nNo rectangle ROI on the frontmost image")
    OkDialog("No rectangle ROI \n on the frontmost image")
    exit(0)
    }
// 6. Add the same ROI object to the second image display
    disp2.ImageDisplayAddROI( theROI )
// 7. Set the ROI to the selected state on both displays
    disp1.ImageDisplaySetROISelected( theROI, 1 ) 
    disp2.ImageDisplaySetROISelected( theROI, 1 ) 