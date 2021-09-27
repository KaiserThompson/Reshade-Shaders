//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//UIDetectMulti header file
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
Description:

UIPixelCoord[PIXELNUMBER]       //the UI pixels screen space coordinates (top left is 0,0) and UI number
{
    float3(x1,y1,UI1),
    float3(x2,y2,UI1),
    float3(x3,y3,UI1),
    float3(x4,y4,UI2),
    float3(x5,y5,UI3),
    ...
}
UIPixelRGB[PIXELNUMBER]         //the UI pixels RGB values and UI number
{
    float3(Red1,Green1,Blue1,UI1),
    float3(Red2,Green2,Blue2,UI2),
    ...
}
*/

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


//Game:
//Resolution:

#ifndef UIDM_MASK_COUNT
    #define UIDM_MASK_COUNT	  	1		// [1-5] Enable More masks
#endif

#ifndef UIDM_INVERT
    #define UIDM_INVERT	        	0		// [0 or 1] Enable Inverted Mode (only show effects where 
#endif							// UI is visible)

#ifndef UIDM_DIAGNOSTICS
	#define UIDM_DIAGNOSTICS	0		// [0 or 1] 1 turns on the crosshair and color measurements on screen
#endif							// 0 turns off the effects

#ifndef UIDM_ANTIBLOOM
	#define UIDM_ANTIBLOOM		0		// [0 or 1] 0 allows for 3x better performance of UIDetectMulti_before
#endif							// 1 makes the screen behind the masks black to prevent bloom bleed

#define PIXELNUMBER 			1		// [The number of entries in the list below]

static const float3 UIPixelCoord_UINr[PIXELNUMBER]=
{
	float3(0,0,1),
};

static const float4 UIPixelRGB[PIXELNUMBER]=
{
	float4(0,0,0,0),
};
