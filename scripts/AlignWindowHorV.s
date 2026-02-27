/*
AlignWinHorV.s
Align SecondImg based on FirstImg's position and size
w   ALT: Vertical   direction = 0
w/o ALT: horizontal direction = 1
*/

void AlignWindow( image FirstImg, image SecondImg, number direction )
{
    // Get the DocumentWindow objects associated with the images
    DocumentWindow win1 = FirstImg.ImageGetOrCreateImageDocument().ImageDocumentGetWindow() 
    DocumentWindow win2 = SecondImg.ImageGetOrCreateImageDocument().ImageDocumentGetWindow() 
    // Get the current frame boundaries of the first window 
    number t, l, b, r
    win1.WindowGetFrameBounds( t, l, b, r ) 
    // Calculate dimensions of the first window
    number w = r - l
    number h = b - t
    if ( direction == 0 )
    {
        // direction = 0: Position win2 aligned to the right of win1
        win2.WindowSetFrameBounds( t, r, b, r + w ) 
    }
    else if ( direction == 1 )
    {
        // direction = 1: Position win2 aligned below win1
        win2.WindowSetFrameBounds( b, l, b + h, r ) 
    }
    // Bring the win1 to frontmost
    win1.WindowSelect() 
}

// Main script logic to get front-most images and execute alignment
    image img1, img2
    if ( !GetFrontImage( img1 ) ) Throw( "No image displayed." ) 
    img2 := FindNextImage( img1 ) 
    if ( !img2.ImageIsValid() ) Throw( "Second image not found behind the front image." ) 

// Determine direction: 1 if ALT key is held, otherwise 0 (Horizontal)
    number dir = OptionDown() ? 1 : 0
     
// Call the defined function
    AlignWindow( img1, img2, dir )