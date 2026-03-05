image OffCentRotAve1D(image img)
{
number sizeX,sizeY
GetSize(img, sizeX,sizeY)
number oriX, oriY
GetOrigin(img, oriX, oriY)
	if(oriX==0 && oriY==0){
	oriX = sizeX/2; oriY = sizeY/2; 
    result("\nOrigins X,Y are set to the center of the front image.")
	}
number newsizeX = 2 * min(sizeX-oriX, oriX)
number newsizeY = 2 * min(sizeY-oriY, oriY)
number newsizeXY = min(newsizex, newsizeY)
number halfminor = newsizeXY/2
number centerX   = newsizeX/2
number centerY   = newsizeY/2
number sampling = halfminor*8	// Why 8? Note aliasing of Nyquist frequency in case of low sampling
image band
Band := CreateFloatImage( "map", halfMinor, sampling )
number k = 2 * pi() / sampling
Band = warp(img, icol*sin(irow*k) + OriX, icol*cos(irow*k) + OriY ) // bug fix
image proj := CreateFloatImage( "line projection", halfMinor, 1 )
proj =0
proj[icol,0] += band
proj /= sampling
return proj
}

// main
image img:=getfrontimage()
image img1D
img1D := OffCentRotAve1D(img)
showimage(img1D)