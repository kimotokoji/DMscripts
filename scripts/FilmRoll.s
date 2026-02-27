/* FilmRoll.s           
Display 3D-slices as film roll
2026.02.27 Kimoto
Display 3D images vertically or horizontally as a 2D film roll.
For cases where you want to view them side by side or observe them using the same LUT.
*/

// 1. Define the number of gap pixels (equivalent to an argument)
number gap = 1 // 
Getnumber("Gap in pixel", gap, gap)

// 2. Get the front-most 3D image
image src := GetFrontImage() 
if ( src.ImageGetNumDimensions() != 3 ) Throw( "The front image is not a 3D stack." ) 

number sx, sy, sz
src.Get3DSize( sx, sy, sz ) 

// --- A. Create Horizontal Montage ---
// Create a new image with total width including the gap for each slice
image montageH := RealImage( "Horizontal Montage (Gap: " + gap + ")", 4, (sx + gap) * sz, sy ) 
montageH = 0 // Initialize background with black

for( number i = 0 ; i < sz ; i++ )
{
    // Offset the destination X position by multiples of (sx + gap)
    montageH.Slice2( i * (sx + gap), 0, 0, 0, sx, 1, 1, sy, 1 ) = src.Slice2( 0, 0, i, 0, sx, 1, 1, sy, 1 ) 
}
montageH.ShowImage() 

// --- B. Create Vertical Montage ---
// Create a new image with total height including the gap for each slice
image montageV := RealImage( "Vertical Montage (Gap: " + gap + ")", 4, sx, (sy + gap) * sz ) 
montageV = 0 // Initialize background with black

for( number i = 0 ; i < sz ; i++ )
{
    // Offset the destination Y position by multiples of (sy + gap)
    montageV.Slice2( 0, i * (sy + gap), 0, 0, sx, 1, 1, sy, 1 ) = src.Slice2( 0, 0, i, 0, sx, 1, 1, sy, 1 ) 
}
montageV.ShowImage() 
