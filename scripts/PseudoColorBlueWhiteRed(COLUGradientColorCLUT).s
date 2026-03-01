/* Pseudo color map from -1(blue) - 0(white) - 1(red) */
/*
Display a specified intensity range using blue-white-red pseudo-colors.
Precise configuration method using COLUGradientColorCLUT().  
2026.2.28 Kimoto  
*/
// 1. Get the front-most image
    image img := GetFrontImage() 
    if ( !img.ImageIsValid() ) Throw( "No image displayed." ) 
// 2. Get the ImageDisplay object
    imageDisplay disp = img.ImageGetImageDisplay( 0 ) 
// 3. Define custom colors using TagGroups
// Each color point needs an "Index" (0-255) and an "RGB" value.
// Point 1: Blue at Index 0
    TagGroup col1 = NewTagGroup() 
    col1.TagGroupSetTagAsLong( "Index", 0 ) 
    col1.TagGroupSetTagAsRGBUInt16( "RGB", 0, 0, 255 )
// Point 2: White at Index 127
    TagGroup col2 = NewTagGroup()
    col2.TagGroupSetTagAsLong( "Index", 127 )
    col2.TagGroupSetTagAsRGBUInt16( "RGB", 255, 255, 255 )
// Point 3: Red at Index 255
    TagGroup col3 = NewTagGroup()
    col3.TagGroupSetTagAsLong( "Index", 255 )
    col3.TagGroupSetTagAsRGBUInt16( "RGB", 255, 0, 0 )
// 4. Combine color points into a TagList
    TagGroup colList = NewTagList() 
    colList.TagGroupInsertTagAsTagGroup( Infinity(), col1 ) 
    colList.TagGroupInsertTagAsTagGroup( Infinity(), col2 )
    colList.TagGroupInsertTagAsTagGroup( Infinity(), col3 )
// 5. Create the CLUT image from the gradient tags
    image customCLUT = COLUGradientColorCLUT( colList ) 
// 6. Apply the custom CLUT to the image display
    ImageDisplaySetDoAutoSurvey( disp, 0 )
    number lowlimit  = -1 
    number highlimit = 1
    disp.ImageDisplaySetContrastLimits( lowLimit, highLimit )
    disp.ImageDisplaySetInputColorTable( customCLUT )  
// 7. Force display update
    img.UpdateImage() 