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