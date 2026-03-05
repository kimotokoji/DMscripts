number kVLamNM(number KV)
{
number LAM		//	wavelength in nm
number RelVol   // relativistic V 
number Voltage	//  V 
Voltage = kV * 1000 
RelVol = voltage*(1+0.000000978502*voltage)
LAM = 1.2263/sqrt(RelVol)	// in nm
return LAM
}

image img				  
number scaleX, scaleY	// original scale
number newScaleX, newScaleY	// converted scale
string unitstring	// unitstring, e.g., "1/nm" and "mrad"
number V		
number kV		
number lamNM	// wavelength in nm

img := getfrontimage()
  getscale(img, scaleX, scaleY)
if(!getnumbernote(img,"Microscope Info:Voltage" ,V)) getnumber("Input acc. voltage [V]", V, V)
  kV = V / 1000
  lamNM = kVLamNM(KV)

GetUnitString(img, unitstring)
  if(unitstring!="1/nm") 
  {
  OkDialog("Scale unit should be (1/nm)")
  exit(0)
  }

NewScaleX = 1000 * ScaleX * lamNM	
SetName(img, getname(img)+"_mrad")
SetUnitString(img, "mrad")
SetScale(img,NewScaleX, newScaleX) 
