//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// 
// UIDetectMulti By Kaiser
// v. 1.6.0
// License: CC By 4.0
// Based on work from Brussels1
//
// UIDetectMulti is configured via the file UIDetectMulti.fxh. Please look
// there for a full description and usage of this shader.
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//Requirements
#include "ReShadeUI.fxh"
#include "ReShade.fxh"
#include "UIDetectMulti.fxh"
#include "DrawText.fxh"

//Reshade.fxh version independence
#undef BUFFER_PIXEL_SIZE
#define BUFFER_PIXEL_SIZE float2(BUFFER_RCP_WIDTH, BUFFER_RCP_HEIGHT)
texture texBackBuffer : COLOR;
sampler BackBuffer { Texture = texBackBuffer; };

//Sliders
uniform float3 tolerance1 < __UNIFORM_SLIDER_FLOAT3
	ui_label = "RGB tolerance";
	ui_category = "Mask 1 Tolerances";
	ui_category_closed = true;
	ui_min = 0; ui_max = 255;
	ui_step = 1;
> = 1;

uniform float FA1 < __UNIFORM_SLIDER_FLOAT1
	ui_label = "Frames to activate";
	ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
	ui_category = "Mask 1 Tolerances";
	ui_category_closed = true;
	ui_min = 1; ui_max = 60;
	ui_step = 1;
> = 1;

uniform float FD1 < __UNIFORM_SLIDER_FLOAT1
	ui_label = "Frames to deactivate";
	ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
	ui_category = "Mask 1 Tolerances";
	ui_category_closed = true;
	ui_min = 1; ui_max = 60;
	ui_step = 1;
> = 1;

uniform float3 tolerance2 < __UNIFORM_SLIDER_FLOAT3
	ui_label = "RGB tolerance";
	ui_category = "Mask 2 Tolerances";
	ui_category_closed = true;
	ui_min = 0; ui_max = 255;
	ui_step = 1;
> = 1;

uniform float FA2 < __UNIFORM_SLIDER_FLOAT1
	ui_label = "Frames to activate";
	ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
	ui_category = "Mask 2 Tolerances";
	ui_category_closed = true;
	ui_min = 1; ui_max = 60;
	ui_step = 1;
> = 1;

uniform float FD2 < __UNIFORM_SLIDER_FLOAT1
	ui_label = "Frames to deactivate";
	ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
	ui_category = "Mask 2 Tolerances";
	ui_category_closed = true;
	ui_min = 1; ui_max = 60;
	ui_step = 1;
> = 1;

uniform float3 tolerance3 < __UNIFORM_SLIDER_FLOAT3
	ui_label = "RGB tolerance";
	ui_category = "Mask 3 Tolerances";
	ui_category_closed = true;
	ui_min = 0; ui_max = 255;
	ui_step = 1;
> = 1;

uniform float FA3 < __UNIFORM_SLIDER_FLOAT1
	ui_label = "Frames to activate";
	ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
	ui_category = "Mask 3 Tolerances";
	ui_category_closed = true;
	ui_min = 1; ui_max = 60;
	ui_step = 1;
> = 1;

uniform float FD3 < __UNIFORM_SLIDER_FLOAT1
	ui_label = "Frames to deactivate";
	ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
	ui_category = "Mask 3 Tolerances";
	ui_category_closed = true;
	ui_min = 1; ui_max = 60;
	ui_step = 1;
> = 1;

#if (UIDM_MASK_COUNT > 1)
	uniform float3 tolerance4 < __UNIFORM_SLIDER_FLOAT3
		ui_label = "RGB tolerance";
		ui_category = "Mask 4 Tolerances";
		ui_category_closed = true;
		ui_min = 0; ui_max = 255;
		ui_step = 1;
	> = 1;
	
	uniform float FA4 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to activate";
		ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
		ui_category = "Mask 4 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float FD4 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to deactivate";
		ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
		ui_category = "Mask 4 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float3 tolerance5 < __UNIFORM_SLIDER_FLOAT3
		ui_label = "RGB tolerance";
		ui_category = "Mask 5 Tolerances";
		ui_category_closed = true;
		ui_min = 0; ui_max = 255;
		ui_step = 1;
	> = 1;
	
	uniform float FA5 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to activate";
		ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
		ui_category = "Mask 5 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float FD5 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to deactivate";
		ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
		ui_category = "Mask 5 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float3 tolerance6 < __UNIFORM_SLIDER_FLOAT3
		ui_label = "RGB tolerance";
		ui_category = "Mask 6 Tolerances";
		ui_category_closed = true;
		ui_min = 0; ui_max = 255;
		ui_step = 1;
	> = 1;
	
	uniform float FA6 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to activate";
		ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
		ui_category = "Mask 6 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float FD6 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to deactivate";
		ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
		ui_category = "Mask 6 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
#endif

#if (UIDM_MASK_COUNT > 2)
	uniform float3 tolerance7 < __UNIFORM_SLIDER_FLOAT3
		ui_label = "RGB tolerance";
		ui_category = "Mask 7 Tolerances";
		ui_category_closed = true;
		ui_min = 0; ui_max = 255;
		ui_step = 1;
	> = 1;
	
	uniform float FA7 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to activate";
		ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
		ui_category = "Mask 7 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float FD7 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to deactivate";
		ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
		ui_category = "Mask 7 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float3 tolerance8 < __UNIFORM_SLIDER_FLOAT3
		ui_label = "RGB tolerance";
		ui_category = "Mask 8 Tolerances";
		ui_category_closed = true;
		ui_min = 0; ui_max = 255;
		ui_step = 1;
	> = 1;
	
	uniform float FA8 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to activate";
		ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
		ui_category = "Mask 8 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float FD8 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to deactivate";
		ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
		ui_category = "Mask 8 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;

	uniform float3 tolerance9 < __UNIFORM_SLIDER_FLOAT3
		ui_label = "RGB tolerance";
		ui_category = "Mask 9 Tolerances";
		ui_category_closed = true;
		ui_min = 0; ui_max = 255;
		ui_step = 1;
	> = 1;
	
	uniform float FA9 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to activate";
		ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
		ui_category = "Mask 9 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float FD9 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to deactivate";
		ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
		ui_category = "Mask 9 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
#endif

#if (UIDM_MASK_COUNT > 3)
	uniform float3 tolerance10 < __UNIFORM_SLIDER_FLOAT3
		ui_label = "RGB tolerance";
		ui_category = "Mask 10 Tolerances";
		ui_category_closed = true;
		ui_min = 0; ui_max = 255;
		ui_step = 1;
	> = 1;
	
	uniform float FA10 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to activate";
		ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
		ui_category = "Mask 10 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float FD10 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to deactivate";
		ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
		ui_category = "Mask 10 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float3 tolerance11 < __UNIFORM_SLIDER_FLOAT3
		ui_label = "RGB tolerance";
		ui_category = "Mask 11 Tolerances";
		ui_category_closed = true;
		ui_min = 0; ui_max = 255;
		ui_step = 1;
	> = 1;
	
	uniform float FA11 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to activate";
		ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
		ui_category = "Mask 11 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float FD11 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to deactivate";
		ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
		ui_category = "Mask 11 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float3 tolerance12 < __UNIFORM_SLIDER_FLOAT3
		ui_label = "RGB tolerance";
		ui_category = "Mask 12 Tolerances";
		ui_category_closed = true;
		ui_min = 0; ui_max = 255;
		ui_step = 1;
	> = 1;
	
	uniform float FA12 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to activate";
		ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
		ui_category = "Mask 12 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float FD12 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to deactivate";
		ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
		ui_category = "Mask 12 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
#endif

#if (UIDM_MASK_COUNT > 3)
	uniform float3 tolerance13 < __UNIFORM_SLIDER_FLOAT3
		ui_label = "RGB tolerance";
		ui_category = "Mask 13 Tolerances";
		ui_category_closed = true;
		ui_min = 0; ui_max = 255;
		ui_step = 1;
	> = 1;
	
	uniform float FA13 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to activate";
		ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
		ui_category = "Mask 13 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float FD13 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to deactivate";
		ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
		ui_category = "Mask 13 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float3 tolerance14 < __UNIFORM_SLIDER_FLOAT3
		ui_label = "RGB tolerance";
		ui_category = "Mask 14 Tolerances";
		ui_category_closed = true;
		ui_min = 0; ui_max = 255;
		ui_step = 1;
	> = 1;
	
	uniform float FA14 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to activate";
		ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
		ui_category = "Mask 14 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float FD14 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to deactivate";
		ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
		ui_category = "Mask 14 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float3 tolerance15 < __UNIFORM_SLIDER_FLOAT3
		ui_label = "RGB tolerance";
		ui_category = "Mask 15 Tolerances";
		ui_category_closed = true;
		ui_min = 0; ui_max = 255;
		ui_step = 1;
	> = 1;
	
	uniform float FA15 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to activate";
		ui_tooltip = "How many frames a UI element has to be on screen to activate the mask";
		ui_category = "Mask 15 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
	
	uniform float FD15 < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Frames to deactivate";
		ui_tooltip = "How many frames a UI element has to be off screen to de-activate the mask";
		ui_category = "Mask 15 Tolerances";
		ui_category_closed = true;
		ui_min = 1; ui_max = 60;
		ui_step = 1;
	> = 1;
#endif

#if (UIDM_DIAGNOSTICS == 1)
	uniform float fPixelPosX < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Pixel X-Position";
		ui_category = "Pixel Selection";
		ui_category_closed = true;
		ui_min = 0; ui_max = BUFFER_WIDTH;
		ui_step = 1;
	> = 100;

	uniform float fPixelPosY < __UNIFORM_SLIDER_FLOAT1
		ui_label = "Pixel Y-Position";
		ui_category = "Pixel Selection";
		ui_category_closed = true;
		ui_min = 0; ui_max = BUFFER_HEIGHT;
		ui_step = 1;
	> = 100;
	
	uniform float3 CrossColor < __UNIFORM_COLOR_FLOAT3
		ui_label = "Crosshair Color";
		ui_category = "Pixel Selection";
		ui_category_closed = true;
		ui_min = 0; ui_max = 255;
		ui_step = 1;
	> = 1;

	uniform bool BlackFont <
		ui_label = "Font color";
		ui_tooltip = "Check for Black font, Uncheck for White font";
		ui_category = "Pixel Selection";
		ui_category_closed = true;
	> = true;
#endif

//textures and samplers
texture texColorBeforeMulti { Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; };
sampler ColorBeforeMulti { Texture = texColorBeforeMulti; };
texture texUIDetectMaskMulti <source="UIDETECTMASKRGBMULTI.png";> { Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; Format=RGBA8; };
sampler UIDetectMaskMulti { Texture = texUIDetectMaskMulti; };
texture texUIDetectMulti { Width = 1; Height = 1; Format = RGBA8; };
sampler UIDetectMulti { Texture = texUIDetectMulti; };
texture texUIDetectTimer { Width = 1; Height = 1; Format = RGBA8; };
sampler UIDetectTimer { Texture = texUIDetectTimer; };

#if (UIDM_DIAGNOSTICS == 1)
	texture textextcolor { Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; };
	sampler textcolor { Texture = textextcolor; };
	texture textextcolor2 { Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; };
	sampler textcolor2 { Texture = textextcolor2; };
	texture texColorOrigMulti { Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; };
	sampler ColorOrigMulti { Texture = texColorOrigMulti; };
#endif

#if (UIDM_MASK_COUNT > 1)
	texture texUIDetectMaskMulti2 <source="UIDETECTMASKRGBMULTI2.png";>{ Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; Format=RGBA8; };
	sampler UIDetectMaskMulti2 { Texture = texUIDetectMaskMulti2; };
	texture texUIDetectMulti2 { Width = 1; Height = 1; Format = RGBA8; };
	sampler UIDetectMulti2 { Texture = texUIDetectMulti2; };
	texture texUIDetectTimer2 { Width = 1; Height = 1; Format = RGBA8; };
	sampler UIDetectTimer2 { Texture = texUIDetectTimer2; };
#endif

#if (UIDM_MASK_COUNT > 2)
	texture texUIDetectMaskMulti3 <source="UIDETECTMASKRGBMULTI3.png";>{ Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; Format=RGBA8; };
	sampler UIDetectMaskMulti3 { Texture = texUIDetectMaskMulti3; };
	texture texUIDetectMulti3 { Width = 1; Height = 1; Format = RGBA8; };
	sampler UIDetectMulti3 { Texture = texUIDetectMulti3; };
	texture texUIDetectTimer3 { Width = 1; Height = 1; Format = RGBA8; };
	sampler UIDetectTimer3 { Texture = texUIDetectTimer3; };
#endif

#if (UIDM_MASK_COUNT > 3)
	texture texUIDetectMaskMulti4 <source="UIDETECTMASKRGBMULTI4.png";>{ Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; Format=RGBA8; };
	sampler UIDetectMaskMulti4 { Texture = texUIDetectMaskMulti4; };
	texture texUIDetectMulti4 { Width = 1; Height = 1; Format = RGBA8; };
	sampler UIDetectMulti4 { Texture = texUIDetectMulti4; };
	texture texUIDetectTimer4 { Width = 1; Height = 1; Format = RGBA8; };
	sampler UIDetectTimer4 { Texture = texUIDetectTimer4; };
#endif

#if (UIDM_MASK_COUNT > 4)
	texture texUIDetectMaskMulti5 <source="UIDETECTMASKRGBMULTI5.png";>{ Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; Format=RGBA8; };
	sampler UIDetectMaskMulti5 { Texture = texUIDetectMaskMulti5; };
	texture texUIDetectMulti5 { Width = 1; Height = 1; Format = RGBA8; };
	sampler UIDetectMulti5 { Texture = texUIDetectMulti5; };
	texture texUIDetectTimer5 { Width = 1; Height = 1; Format = RGBA8; };
	sampler UIDetectTimer5 { Texture = texUIDetectTimer5; };
#endif

//pixel shaders
//UIDetectMulti
#if (UIDM_DIAGNOSTICS == 1)
	float4 State_Pixel_Color(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
	{
		float res;
		
		float2 pixelCoord = float2(fPixelPosX, fPixelPosY) * BUFFER_PIXEL_SIZE;
		float3 pixelColor = round(tex2D(BackBuffer, pixelCoord).rgb * 255);
	
		uint Red = trunc(pixelColor.x);
		uint Green = trunc(pixelColor.y);
		uint Blue = trunc(pixelColor.z);
	
		int Red3 = (Red - (Red % 100)) / 100;
		int Red2 = ((Red % 100) - (Red % 10)) / 10;
		int Red1 = Red % 10;
		int Green3 = (Green - (Green % 100)) / 100;
		int Green2 = ((Green % 100) - (Green % 10)) / 10;
		int Green1 = Green % 10;
		int Blue3 = (Blue - (Blue % 100)) / 100;
		int Blue2 = ((Blue % 100) - (Blue % 10)) / 10;
		int Blue1 = Blue % 10;
		
		int line0[10]  = { __R, __E, __D, __Colon, __Space, __Space, __Space, Red3 + 16, Red2 + 16, Red1 + 16 }; //Red
		int line1[10]  = { __G, __R, __E, __E, __N, __Colon, __Space, Green3 + 16, Green2 + 16, Green1 + 16 }; //Green
		int line2[10]  = { __B, __L, __U, __E, __Colon, __Space, __Space, Blue3 + 16, Blue2 + 16, Blue1 + 16 }; //Blue
		DrawText_String(float2(800.0 , 100.0), 50, 1, texcoord,  line0, 10, res);
		DrawText_String(float2(800.0 , 134.0), 50, 1, texcoord,  line1, 10, res);
		DrawText_String(float2(800.0 , 168.0), 50, 1, texcoord,  line2, 10, res);
		return res;
	}
	
	float4 Fontinvert(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
	{
		float3 colors = tex2D(textcolor, texcoord).rgb;
		return float4(1.0 - colors, 1.0);
	}
	
	float3 Crosshair(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
	{
		float3 color = 0;
		float3 crosshair = CrossColor;
		float3 colorOrig = tex2D(BackBuffer, texcoord).rgb;
		float2 pixelCoord = float2(fPixelPosX, fPixelPosY) * BUFFER_PIXEL_SIZE;
		float mask;
		int Xtest = 0;
		int Ytest = 0;
		if (abs((texcoord.x / BUFFER_PIXEL_SIZE.x) - (pixelCoord.x / BUFFER_PIXEL_SIZE.x)) < 0.5) Xtest = 1;
		if (abs((texcoord.y / BUFFER_PIXEL_SIZE.y) - (pixelCoord.y / BUFFER_PIXEL_SIZE.y)) < 0.5) Ytest = 1;
		if (Xtest == 1 && Ytest == 1){ Xtest = 0; Ytest = 0;}
		color = lerp(color, crosshair, Xtest);
		color = lerp(color, crosshair, Ytest);
		if(CrossColor.x >= CrossColor.y && CrossColor.x >= CrossColor.z) mask = color.x;
		if(CrossColor.y >= CrossColor.x && CrossColor.y >= CrossColor.z) mask = color.y;
		if(CrossColor.z >= CrossColor.x && CrossColor.z >= CrossColor.y) mask = color.z;
		if(CrossColor.x >= CrossColor.y && CrossColor.x <= CrossColor.z) mask = color.z;
		if(CrossColor.y >= CrossColor.x && CrossColor.y <= CrossColor.z) mask = color.z;
		if(CrossColor.z >= CrossColor.x && CrossColor.z <= CrossColor.y) mask = color.y;
		color = lerp(colorOrig, color, mask);
		return color;
	}
	
	float4 FontTransparancy(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
	{
		float3 color;
		float3 colorOrig = tex2D(BackBuffer, texcoord).rgb;
		float mask;
		
		if (BlackFont == true){
			color = tex2D(textcolor, texcoord).rgb;
			mask = saturate(tex2D(textcolor, texcoord).r);
		}
		if (BlackFont == false){
			color = tex2D(textcolor2, texcoord).rgb;
			mask = saturate(1.0 - tex2D(textcolor2, texcoord).r);
		}
		
		color = lerp(colorOrig, color, mask);
		return float4(color, 1.0);
	}
	
	float4 PS_ShowOrigColor(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
	{
		float4 colorOrig = tex2D(ColorOrigMulti, texcoord);
		return colorOrig;
	}
#endif

float4 PS_UIDetect(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
	float3 pixelColor, uiPixelColor, diff;
	float2 pixelCoord;
	int uinumber;
	float FTA1 = 1 / (FD1 + FA1);
	float FTA2 = 1 / (FD2 + FA2);
	float FTA3 = 1 / (FD3 + FA3);
	
	#if (UIDM_EVERYPIXEL == 0)
		float3 uiDetected2 = 1;
		float3 uicolors = tex2D(UIDetectTimer, float2(0,0)).rgb;
		float3 uiDetected = 0;
	#else
		float3 uiDetected2 = 1;
		float3 uicolors = tex2D(UIDetectTimer, float2(0,0)).rgb;
		float3 uiDetected = 1;
	#endif

	for (int i=0; i < PIXELNUMBER; i++){
		if (i == PIXELNUMBER){break;}
		if (UIPixelCoord_UINr[i].z == 1){uinumber = i; break;}
	}

	for (int i=0; i < 3; i++){
		pixelCoord = UIPixelCoord_UINr[uinumber].xy * BUFFER_PIXEL_SIZE;
		pixelColor = round(tex2D(BackBuffer, float2(pixelCoord)).rgb * 255);
		uiPixelColor = UIPixelRGB[uinumber].rgb;
		diff = abs(pixelColor - uiPixelColor);
		#if (UIDM_EVERYPIXEL == 0)
			if (diff.r < tolerance1.r && diff.g < tolerance1.g && diff.b < tolerance1.b && UIPixelCoord_UINr[uinumber].z == 1) uiDetected.x = 1;
			if (diff.r < tolerance2.r && diff.g < tolerance2.g && diff.b < tolerance2.b && UIPixelCoord_UINr[uinumber].z == 2) uiDetected.y = 1;	
			if (diff.r < tolerance3.r && diff.g < tolerance3.g && diff.b < tolerance3.b && UIPixelCoord_UINr[uinumber].z == 3) uiDetected.z = 1;
		#else                                                                        
			if (diff.r > tolerance1.r && diff.g > tolerance1.g && diff.b > tolerance1.b && UIPixelCoord_UINr[uinumber].z == 1) uiDetected.x = 0;
			if (diff.r > tolerance2.r && diff.g > tolerance2.g && diff.b > tolerance2.b && UIPixelCoord_UINr[uinumber].z == 2) uiDetected.y = 0;
			if (diff.r > tolerance3.r && diff.g > tolerance3.g && diff.b > tolerance3.b && UIPixelCoord_UINr[uinumber].z == 3) uiDetected.z = 0;
		#endif
		if (uinumber == PIXELNUMBER){break;}
		if (uinumber < PIXELNUMBER - 1){
			if (UIPixelCoord_UINr[uinumber].z == UIPixelCoord_UINr[uinumber + 1].z){i -= 1;};
		}
		uinumber += 1;
	}
	
	#if (UIDM_EVERYPIXEL == 0)
		if (uiDetected.x == 1){uicolors.r -= FTA1;}else{uicolors.r += FTA1;}
		if (uiDetected.y == 1){uicolors.g -= FTA2;}else{uicolors.g += FTA2;}
		if (uiDetected.z == 1){uicolors.b -= FTA3;}else{uicolors.b += FTA3;}
	#else
		if (uiDetected.x == 0){uicolors.r += FTA1;}else{uicolors.r -= FTA1;}
		if (uiDetected.y == 0){uicolors.g += FTA2;}else{uicolors.g -= FTA2;}
		if (uiDetected.z == 0){uicolors.b += FTA3;}else{uicolors.b -= FTA3;}
	#endif
	
	return float4(uicolors, 1);
}

float4 PS_UIDetectTimerSetup(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
	#if (UIDM_EVERYPIXEL == 0)
		float3 colorOrig = 1;
	#else
		float3 colorOrig = 0;
	#endif
	return float4(colorOrig, 1);
}

float4 PS_UIDetectTimer(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
	float3 uicolors = tex2D(UIDetectMulti, float2(0,0)).rgb;
	return float4(uicolors, 1);
}

#if (UIDM_MASK_COUNT > 1)
	float4 PS_UIDetect2() : SV_Target
	{
		float3 pixelColor, uiPixelColor, diff;
		float2 pixelCoord;
		int uinumber;
		float FTA1 = 1 / (FD4 + FA4);
		float FTA2 = 1 / (FD5 + FA5);
		float FTA3 = 1 / (FD6 + FA6);
		
		#if (UIDM_EVERYPIXEL == 0)
			float3 uiDetected2 = 0;
			float3 uicolors = tex2D(UIDetectTimer2, float2(0,0)).rgb;
			float3 uiDetected = 0;
		#else
			float3 uiDetected2 = 1;
			float3 uicolors = tex2D(UIDetectTimer2, float2(0,0)).rgb;
			float3 uiDetected = 1;
		#endif
		
		for (int i=0; i < PIXELNUMBER; i++){
			if (i == PIXELNUMBER){break;}
			if (UIPixelCoord_UINr[i].z == 4){uinumber = i; break;}
		}  
	
		for (int i=0; i < 3; i++){
			pixelCoord = UIPixelCoord_UINr[uinumber].xy * BUFFER_PIXEL_SIZE;
			pixelColor = round(tex2D(BackBuffer, float2(pixelCoord)).rgb * 255);
			uiPixelColor = UIPixelRGB[uinumber].rgb;
			diff = abs(pixelColor - uiPixelColor);
			#if (UIDM_EVERYPIXEL == 0)
				if (diff.r < tolerance4.r && diff.g < tolerance4.g && diff.b < tolerance4.b && UIPixelCoord_UINr[uinumber].z == 4) uiDetected.x = 1;
				if (diff.r < tolerance5.r && diff.g < tolerance5.g && diff.b < tolerance5.b && UIPixelCoord_UINr[uinumber].z == 5) uiDetected.y = 1;	
				if (diff.r < tolerance6.r && diff.g < tolerance6.g && diff.b < tolerance6.b && UIPixelCoord_UINr[uinumber].z == 6) uiDetected.z = 1;
			#else                                                                       
				if (diff.r > tolerance4.r && diff.g > tolerance4.g && diff.b > tolerance4.b && UIPixelCoord_UINr[uinumber].z == 4) uiDetected.x = 0;
				if (diff.r > tolerance5.r && diff.g > tolerance5.g && diff.b > tolerance5.b && UIPixelCoord_UINr[uinumber].z == 5) uiDetected.y = 0;
				if (diff.r > tolerance6.r && diff.g > tolerance6.g && diff.b > tolerance6.b && UIPixelCoord_UINr[uinumber].z == 6) uiDetected.z = 0;
			#endif
			if (uinumber == PIXELNUMBER){break;}
			if (uinumber < PIXELNUMBER - 1){
				if (UIPixelCoord_UINr[uinumber].z == UIPixelCoord_UINr[uinumber + 1].z){i -= 1;};
			}
			uinumber += 1;
		}
	
		#if (UIDM_EVERYPIXEL == 0)
			if (uiDetected.x == 1){uicolors.r -= FTA1;}else{uicolors.r += FTA1;}
			if (uiDetected.y == 1){uicolors.g -= FTA2;}else{uicolors.g += FTA2;}
			if (uiDetected.z == 1){uicolors.b -= FTA3;}else{uicolors.b += FTA3;}
		#else
			if (uiDetected.x == 0){uicolors.r += FTA1;}else{uicolors.r -= FTA1;}
			if (uiDetected.y == 0){uicolors.g += FTA2;}else{uicolors.g -= FTA2;}
			if (uiDetected.z == 0){uicolors.b += FTA3;}else{uicolors.b -= FTA3;}
		#endif

		return float4(uicolors, 1);
	}
	
	float4 PS_UIDetectTimer2(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
	{
		float3 uicolors = tex2D(UIDetectMulti2, float2(0,0)).rgb;
		return float4(uicolors, 1);
	}
#endif

#if (UIDM_MASK_COUNT > 2)
	float4 PS_UIDetect3() : SV_Target
	{
		float3 pixelColor, uiPixelColor, diff;
		float2 pixelCoord;
		int uinumber;
		float FTA1 = 1 / (FD7 + FA7);
		float FTA2 = 1 / (FD8 + FA8);
		float FTA3 = 1 / (FD9 + FA9);
		
		#if (UIDM_EVERYPIXEL == 0)
			float3 uiDetected2 = 0;
			float3 uicolors = tex2D(UIDetectTimer3, float2(0,0)).rgb;
			float3 uiDetected = 0;
		#else
			float3 uiDetected2 = 1;
			float3 uicolors = tex2D(UIDetectTimer3, float2(0,0)).rgb;
			float3 uiDetected = 1;
		#endif
	
		for (int i=0; i < PIXELNUMBER; i++){
			if (i == PIXELNUMBER){break;}
			if (UIPixelCoord_UINr[i].z == 7){uinumber = i; break;}
		}
	
		for (int i=0; i < 3; i++){
			pixelCoord = UIPixelCoord_UINr[uinumber].xy * BUFFER_PIXEL_SIZE;
			pixelColor = round(tex2D(BackBuffer, float2(pixelCoord)).rgb * 255);
			uiPixelColor = UIPixelRGB[uinumber].rgb;
			diff = abs(pixelColor - uiPixelColor);
			#if (UIDM_EVERYPIXEL == 0)
				if (diff.r < tolerance7.r && diff.g < tolerance7.g && diff.b < tolerance7.b && UIPixelCoord_UINr[uinumber].z == 7) uiDetected.x = 1;
				if (diff.r < tolerance8.r && diff.g < tolerance8.g && diff.b < tolerance8.b && UIPixelCoord_UINr[uinumber].z == 8) uiDetected.y = 1;	
				if (diff.r < tolerance9.r && diff.g < tolerance9.g && diff.b < tolerance9.b && UIPixelCoord_UINr[uinumber].z == 9) uiDetected.z = 1;
			#else
				if (diff.r > tolerance7.r && diff.g > tolerance7.g && diff.b > tolerance7.b && UIPixelCoord_UINr[uinumber].z == 7) uiDetected.x = 0;
				if (diff.r > tolerance8.r && diff.g > tolerance8.g && diff.b > tolerance8.b && UIPixelCoord_UINr[uinumber].z == 8) uiDetected.y = 0;
				if (diff.r > tolerance9.r && diff.g > tolerance9.g && diff.b > tolerance9.b && UIPixelCoord_UINr[uinumber].z == 9) uiDetected.z = 0;
			#endif
			if (uinumber == PIXELNUMBER){break;}
			if (uinumber < PIXELNUMBER - 1){
				if (UIPixelCoord_UINr[uinumber].z == UIPixelCoord_UINr[uinumber + 1].z){i -= 1;};
			}
			uinumber += 1;
		}
	
		#if (UIDM_EVERYPIXEL == 0)
			if (uiDetected.x == 1){uicolors.r -= FTA1;}else{uicolors.r += FTA1;}
			if (uiDetected.y == 1){uicolors.g -= FTA2;}else{uicolors.g += FTA2;}
			if (uiDetected.z == 1){uicolors.b -= FTA3;}else{uicolors.b += FTA3;}
		#else
			if (uiDetected.x == 0){uicolors.r += FTA1;}else{uicolors.r -= FTA1;}
			if (uiDetected.y == 0){uicolors.g += FTA2;}else{uicolors.g -= FTA2;}
			if (uiDetected.z == 0){uicolors.b += FTA3;}else{uicolors.b -= FTA3;}
		#endif

		return float4(uicolors, 1);
	}
	
	float4 PS_UIDetectTimer3(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
	{
		float3 uicolors = tex2D(UIDetectMulti3, float2(0,0)).rgb;
		return float4(uicolors, 1);
	}
#endif

#if (UIDM_MASK_COUNT > 3)
	float4 PS_UIDetect4() : SV_Target
	{
		float3 pixelColor, uiPixelColor, diff;
		float2 pixelCoord;
		int uinumber;
		float FTA1 = 1 / (FD10 + FA10);
		float FTA2 = 1 / (FD11 + FA11);
		float FTA3 = 1 / (FD12 + FA12);
		
		#if (UIDM_EVERYPIXEL == 0)
			float3 uiDetected2 = 0;
			float3 uicolors = tex2D(UIDetectTimer4, float2(0,0)).rgb;
			float3 uiDetected = 0;
		#else
			float3 uiDetected2 = 1;
			float3 uicolors = tex2D(UIDetectTimer4, float2(0,0)).rgb;
			float3 uiDetected = 1;
		#endif
	
		for (int i=0; i < PIXELNUMBER; i++){
			if (i == PIXELNUMBER){break;}
			if (UIPixelCoord_UINr[i].z == 10){uinumber = i; break;}
		}
	
		for (int i=0; i < 4; i++){
			pixelCoord = UIPixelCoord_UINr[uinumber].xy * BUFFER_PIXEL_SIZE;
			pixelColor = round(tex2Dlod(BackBuffer, float4(pixelCoord, 0, 0)).rgb * 255);
			uiPixelColor = UIPixelRGB[uinumber].rgb;
			diff = abs(pixelColor - uiPixelColor);
			#if (UIDM_EVERYPIXEL == 0)
				if (diff.r < tolerance10.r && diff.g < tolerance10.g && diff.b < tolerance10.b && UIPixelCoord_UINr[uinumber].z == 10) uiDetected.x = 1;
				if (diff.r < tolerance11.r && diff.g < tolerance11.g && diff.b < tolerance11.b && UIPixelCoord_UINr[uinumber].z == 11) uiDetected.y = 1;	
				if (diff.r < tolerance12.r && diff.g < tolerance12.g && diff.b < tolerance12.b && UIPixelCoord_UINr[uinumber].z == 12) uiDetected.z = 1;
			#else
				if (diff.r > tolerance10.r && diff.g > tolerance10.g && diff.b > tolerance10.b && UIPixelCoord_UINr[uinumber].z == 10) uiDetected.x = 0;
				if (diff.r > tolerance11.r && diff.g > tolerance11.g && diff.b > tolerance11.b && UIPixelCoord_UINr[uinumber].z == 11) uiDetected.y = 0;
				if (diff.r > tolerance12.r && diff.g > tolerance12.g && diff.b > tolerance12.b && UIPixelCoord_UINr[uinumber].z == 12) uiDetected.z = 0;
			#endif
			if (uinumber == PIXELNUMBER){break;}
			if (uinumber < PIXELNUMBER - 1){
				if (UIPixelCoord_UINr[uinumber].z == UIPixelCoord_UINr[uinumber + 1].z){i -= 1;};
			}
			uinumber += 1;
		}
	
		#if (UIDM_EVERYPIXEL == 0)
			if (uiDetected.x == 1){uicolors.r -= FTA1;}else{uicolors.r += FTA1;}
			if (uiDetected.y == 1){uicolors.g -= FTA2;}else{uicolors.g += FTA2;}
			if (uiDetected.z == 1){uicolors.b -= FTA3;}else{uicolors.b += FTA3;}
		#else
			if (uiDetected.x == 0){uicolors.r += FTA1;}else{uicolors.r -= FTA1;}
			if (uiDetected.y == 0){uicolors.g += FTA2;}else{uicolors.g -= FTA2;}
			if (uiDetected.z == 0){uicolors.b += FTA3;}else{uicolors.b -= FTA3;}
		#endif

		return float4(uicolors, 1);
	}
	
	float4 PS_UIDetectTimer4(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
	{
		float3 uicolors = tex2D(UIDetectMulti4, float2(0,0)).rgb;
		return float4(uicolors, 1);
	}
#endif

#if (UIDM_MASK_COUNT > 4)
	float4 PS_UIDetect5() : SV_Target
	{
		float3 pixelColor, uiPixelColor, diff;
		float2 pixelCoord;
		int uinumber;
		float FTA1 = 1 / (FD13 + FA13);
		float FTA2 = 1 / (FD14 + FA14);
		float FTA3 = 1 / (FD15 + FA15);
		
		#if (UIDM_EVERYPIXEL == 0)
			float3 uiDetected2 = 0;
			float3 uicolors = tex2D(UIDetectTimer5, float2(0,0)).rgb;
			float3 uiDetected = 0;
		#else
			float3 uiDetected2 = 1;
			float3 uicolors = tex2D(UIDetectTimer5, float2(0,0)).rgb;
			float3 uiDetected = 1;
		#endif
		
		for (int i=0; i < PIXELNUMBER; i++){
			if (i == PIXELNUMBER){break;}
			if (UIPixelCoord_UINr[i].z == 13){uinumber = i; break;}
		}
	
		for (int i=0; i < 4; i++){
			pixelCoord = UIPixelCoord_UINr[uinumber].xy * BUFFER_PIXEL_SIZE;
			pixelColor = round(tex2Dlod(BackBuffer, float4(pixelCoord, 0, 0)).rgb * 255);
			uiPixelColor = UIPixelRGB[uinumber].rgb;
			diff = abs(pixelColor - uiPixelColor);
			#if (UIDM_EVERYPIXEL == 0)
				if (diff.r < tolerance13.r && diff.g < tolerance13.g && diff.b < tolerance13.b && UIPixelCoord_UINr[uinumber].z == 13) uiDetected.x = 1;
				if (diff.r < tolerance14.r && diff.g < tolerance14.g && diff.b < tolerance14.b && UIPixelCoord_UINr[uinumber].z == 14) uiDetected.y = 1;	
				if (diff.r < tolerance15.r && diff.g < tolerance15.g && diff.b < tolerance15.b && UIPixelCoord_UINr[uinumber].z == 15) uiDetected.z = 1;
			#else
				if (diff.r > tolerance13.r && diff.g > tolerance13.g && diff.b > tolerance13.b && UIPixelCoord_UINr[uinumber].z == 13) uiDetected.x = 0;
				if (diff.r > tolerance14.r && diff.g > tolerance14.g && diff.b > tolerance14.b && UIPixelCoord_UINr[uinumber].z == 14) uiDetected.y = 0;
				if (diff.r > tolerance15.r && diff.g > tolerance15.g && diff.b > tolerance15.b && UIPixelCoord_UINr[uinumber].z == 15) uiDetected.z = 0;
			#endif
			if (uinumber == PIXELNUMBER){break;}
			if (uinumber < PIXELNUMBER - 1){
				if (UIPixelCoord_UINr[uinumber].z == UIPixelCoord_UINr[uinumber + 1].z){i -= 1;};
			}
			uinumber += 1;
		}
	
		#if (UIDM_EVERYPIXEL == 0)
			if (uiDetected.x == 1){uicolors.r -= FTA1;}else{uicolors.r += FTA1;}
			if (uiDetected.y == 1){uicolors.g -= FTA2;}else{uicolors.g += FTA2;}
			if (uiDetected.z == 1){uicolors.b -= FTA3;}else{uicolors.b += FTA3;}
		#else
			if (uiDetected.x == 0){uicolors.r += FTA1;}else{uicolors.r -= FTA1;}
			if (uiDetected.y == 0){uicolors.g += FTA2;}else{uicolors.g -= FTA2;}
			if (uiDetected.z == 0){uicolors.b += FTA3;}else{uicolors.b -= FTA3;}
		#endif

		return float4(uicolors, 1);
	}
	
	float4 PS_UIDetectTimer5(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
	{
		float3 uicolors = tex2D(UIDetectMulti5, float2(0,0)).rgb;
		return float4(uicolors, 1);
	}
#endif
//end of UIDetectMulti Pixel shader

//UIDetectMulti_Before
#if (UIDM_ANTIBLOOM == 1)
	float4 PS_Antibloom(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
	{
		float FTD1 = 1 / ((FD1 + FA1) / FD1);
		float FTD2 = 1 / ((FD2 + FA2) / FD2);
		float FTD3 = 1 / ((FD3 + FA3) / FD3);
		#if (UIDM_MASK_COUNT > 1)
			float FTD4 = 1 / ((FD4 + FA4) / FD4);
			float FTD5 = 1 / ((FD5 + FA5) / FD5);
			float FTD6 = 1 / ((FD6 + FA6) / FD6);
		#endif
		#if (UIDM_MASK_COUNT > 2)		
			float FTD7 = 1 / ((FD7 + FA7) / FD7);
			float FTD8 = 1 / ((FD8 + FA8) / FD8);
			float FTD9 = 1 / ((FD9 + FA9) / FD9);
		#endif
		#if (UIDM_MASK_COUNT > 3)		
			float FTD10 = 1 / ((FD10 + FA10) / FD10);
			float FTD11 = 1 / ((FD11 + FA11) / FD11);
			float FTD12 = 1 / ((FD12 + FA12) / FD12);
		#endif
		#if (UIDM_MASK_COUNT > 4)		
			float FTD13 = 1 / ((FD13 + FA13) / FD13);
			float FTD14 = 1 / ((FD14 + FA14) / FD14);
			float FTD15 = 1 / ((FD15 + FA15) / FD15);
		#endif
		float3 colorOrig = 0;
		float3 color = tex2D(BackBuffer, texcoord).rgb;
		float3 uiMask = tex2D(UIDetectMaskMulti, texcoord).rgb;
		float3 mask;
		float3 ui = tex2D(UIDetectMulti, float2(0,0)).rgb;
		if (ui.r < FTD1)	{mask = uiMask.r;	color = lerp(colorOrig, color, mask);} //UINr 1
		if (ui.g < FTD2)	{mask = uiMask.g;	color = lerp(colorOrig, color, mask);} //UINr 2
		if (ui.b < FTD3)	{mask = uiMask.b;	color = lerp(colorOrig, color, mask);} //UINr 3
		#if (UIDM_MASK_COUNT > 1)
			float3 uiMask2 = tex2D(UIDetectMaskMulti2, texcoord).rgb;
			float3 mask2;
			float3 ui2 = tex2D(UIDetectMulti2, float2(0,0)).rgb;
			if (ui2.r < FTD4){mask2 = uiMask2.r;	color = lerp(colorOrig, color, mask2);} //UINr 4
			if (ui2.g < FTD5){mask2 = uiMask2.g;	color = lerp(colorOrig, color, mask2);} //UINr 5
			if (ui2.b < FTD6){mask2 = uiMask2.b;	color = lerp(colorOrig, color, mask2);} //UINr 6
		#endif
		#if (UIDM_MASK_COUNT > 2)
			float3 uiMask3 = tex2D(UIDetectMaskMulti3, texcoord).rgb;
			float3 mask3;
			float3 ui3 = tex2D(UIDetectMulti3, float2(0,0)).rgb;
			if (ui3.r < FTD7){mask3 = uiMask3.r;	color = lerp(colorOrig, color, mask3);} //UINr 7
			if (ui3.g < FTD8){mask3 = uiMask3.g;	color = lerp(colorOrig, color, mask3);} //UINr 8
			if (ui3.b < FTD9){mask3 = uiMask3.b;	color = lerp(colorOrig, color, mask3);} //UINr 9
		#endif
		#if (UIDM_MASK_COUNT > 3)
			float3 uiMask4 = tex2D(UIDetectMaskMulti4, texcoord).rgb;
			float3 mask4;
			float3 ui4 = tex2D(UIDetectMulti4, float2(0,0)).rgb;
			if (ui4.r < FTD10){mask4 = uiMask4.r;	color = lerp(colorOrig, color, mask4);} //UINr 10
			if (ui4.g < FTD11){mask4 = uiMask4.g;	color = lerp(colorOrig, color, mask4);} //UINr 11
			if (ui4.b < FTD12){mask4 = uiMask4.b;	color = lerp(colorOrig, color, mask4);} //UINr 12
		#endif
		#if (UIDM_MASK_COUNT > 4)
			float3 uiMask5 = tex2D(UIDetectMaskMulti5, texcoord).rgb;
			float3 mask5;
			float3 ui5 = tex2D(UIDetectMulti5, float2(0,0)).rgb;
			if (ui5.r < FTD13){mask5 = uiMask5.r;	color = lerp(colorOrig, color, mask5);} //UINr 13
			if (ui5.g < FTD14){mask5 = uiMask5.g;	color = lerp(colorOrig, color, mask5);} //UINr 14
			if (ui5.b < FTD15){mask5 = uiMask5.b;	color = lerp(colorOrig, color, mask5);} //UINr 15
		#endif
		
		return float4(color, 1.0);
	}
#endif

float4 PS_StoreColor(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
	return tex2D(BackBuffer, texcoord);
}

//end of UIDetectMulti_Before Pixel shader

//UIDetectMulti_After
float4 PS_RestoreColor(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
	float FTD1 = 1 / ((FD1 + FA1) / FD1);
	float FTD2 = 1 / ((FD2 + FA2) / FD2);
	float FTD3 = 1 / ((FD3 + FA3) / FD3);
	#if (UIDM_MASK_COUNT > 1)
		float FTD4 = 1 / ((FD4 + FA4) / FD4);
		float FTD5 = 1 / ((FD5 + FA5) / FD5);
		float FTD6 = 1 / ((FD6 + FA6) / FD6);
	#endif
	#if (UIDM_MASK_COUNT > 2)		
		float FTD7 = 1 / ((FD7 + FA7) / FD7);
		float FTD8 = 1 / ((FD8 + FA8) / FD8);
		float FTD9 = 1 / ((FD9 + FA9) / FD9);
	#endif
	#if (UIDM_MASK_COUNT > 3)		
		float FTD10 = 1 / ((FD10 + FA10) / FD10);
		float FTD11 = 1 / ((FD11 + FA11) / FD11);
		float FTD12 = 1 / ((FD12 + FA12) / FD12);
	#endif
	#if (UIDM_MASK_COUNT > 4)		
		float FTD13 = 1 / ((FD13 + FA13) / FD13);
		float FTD14 = 1 / ((FD14 + FA14) / FD14);
		float FTD15 = 1 / ((FD15 + FA15) / FD15);
	#endif
	#if (UIDM_INVERT == 0)
		float3 colorOrig = tex2D(ColorBeforeMulti, texcoord).rgb;
		float3 color = tex2D(BackBuffer, texcoord).rgb;
	#else
		float3 color = tex2D(ColorBeforeMulti, texcoord).rgb;
		float3 colorOrig = tex2D(BackBuffer, texcoord).rgb;
	#endif
	float3 uiMask = tex2D(UIDetectMaskMulti, texcoord).rgb;
	float3 mask;
	float3 ui = tex2D(UIDetectMulti, float2(0,0)).rgb;
	if (ui.r < FTD1)	{mask = uiMask.r;	color = lerp(colorOrig, color, mask);} //UINr 1
	if (ui.g < FTD2)	{mask = uiMask.g;	color = lerp(colorOrig, color, mask);} //UINr 2
	if (ui.b < FTD3)	{mask = uiMask.b;	color = lerp(colorOrig, color, mask);} //UINr 3
	#if (UIDM_MASK_COUNT > 1)
		float3 uiMask2 = tex2D(UIDetectMaskMulti2, texcoord).rgb;
		float3 mask2;
		float3 ui2 = tex2D(UIDetectMulti2, float2(0,0)).rgb;
		if (ui2.r < FTD4){mask2 = uiMask2.r;	color = lerp(colorOrig, color, mask2);} //UINr 4
		if (ui2.g < FTD5){mask2 = uiMask2.g;	color = lerp(colorOrig, color, mask2);} //UINr 5
		if (ui2.b < FTD6){mask2 = uiMask2.b;	color = lerp(colorOrig, color, mask2);} //UINr 6
	#endif
	#if (UIDM_MASK_COUNT > 2)
		float3 uiMask3 = tex2D(UIDetectMaskMulti3, texcoord).rgb;
		float3 mask3;
		float3 ui3 = tex2D(UIDetectMulti3, float2(0,0)).rgb;
		if (ui3.r < FTD7){mask3 = uiMask3.r;	color = lerp(colorOrig, color, mask3);} //UINr 7
		if (ui3.g < FTD8){mask3 = uiMask3.g;	color = lerp(colorOrig, color, mask3);} //UINr 8
		if (ui3.b < FTD9){mask3 = uiMask3.b;	color = lerp(colorOrig, color, mask3);} //UINr 9
	#endif
	#if (UIDM_MASK_COUNT > 3)
		float3 uiMask4 = tex2D(UIDetectMaskMulti4, texcoord).rgb;
		float3 mask4;
		float3 ui4 = tex2D(UIDetectMulti4, float2(0,0)).rgb;
		if (ui4.r < FTD10){mask4 = uiMask4.r;	color = lerp(colorOrig, color, mask4);} //UINr 10
		if (ui4.g < FTD11){mask4 = uiMask4.g;	color = lerp(colorOrig, color, mask4);} //UINr 11
		if (ui4.b < FTD12){mask4 = uiMask4.b;	color = lerp(colorOrig, color, mask4);} //UINr 12
	#endif
	#if (UIDM_MASK_COUNT > 4)
		float3 uiMask5 = tex2D(UIDetectMaskMulti5, texcoord).rgb;
		float3 mask5;
		float3 ui5 = tex2D(UIDetectMulti5, float2(0,0)).rgb;
		if (ui5.r < FTD13){mask5 = uiMask5.r;	color = lerp(colorOrig, color, mask5);} //UINr 13
		if (ui5.g < FTD14){mask5 = uiMask5.g;	color = lerp(colorOrig, color, mask5);} //UINr 14
		if (ui5.b < FTD15){mask5 = uiMask5.b;	color = lerp(colorOrig, color, mask5);} //UINr 15
	#endif
	return float4(color, 1.0);
}
//End of UIDetectMulti_After Pixel shader

//techniques
technique UIDetectSetup < enabled = true; timeout = 1; hidden = true; >
{
	pass {
		VertexShader = PostProcessVS;
		PixelShader = PS_UIDetectTimerSetup;
		RenderTarget = texUIDetectTimer;
	}
	
	#if (UIDM_MASK_COUNT > 1)
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_UIDetectTimerSetup;
			RenderTarget = texUIDetectTimer2;
		}
	#endif
	
	#if (UIDM_MASK_COUNT > 2)
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_UIDetectTimerSetup;
			RenderTarget = texUIDetectTimer3;
		}
	#endif
	
	#if (UIDM_MASK_COUNT > 3)
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_UIDetectTimerSetup;
			RenderTarget = texUIDetectTimer4;
		}
	#endif
	
	#if (UIDM_MASK_COUNT > 4)
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_UIDetectTimerSetup;
			RenderTarget = texUIDetectTimer5;
		}
	#endif
}

technique UIDetectMulti
{	
	pass {
		VertexShader = PostProcessVS;
		PixelShader = PS_UIDetect;
		RenderTarget = texUIDetectMulti;
	}
	
	pass {
		VertexShader = PostProcessVS;
		PixelShader = PS_UIDetectTimer;
		RenderTarget = texUIDetectTimer;
	}
	
	#if (UIDM_MASK_COUNT > 1)
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_UIDetect2;
			RenderTarget = texUIDetectMulti2;
		}
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_UIDetectTimer2;
			RenderTarget = texUIDetectTimer2;
		}
	#endif
	
	#if (UIDM_MASK_COUNT > 2)
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_UIDetect3;
			RenderTarget = texUIDetectMulti3;
		}
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_UIDetectTimer3;
			RenderTarget = texUIDetectTimer3;
		}
	#endif
	
	#if (UIDM_MASK_COUNT > 3)
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_UIDetect4;
			RenderTarget = texUIDetectMulti4;
		}
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_UIDetectTimer4;
			RenderTarget = texUIDetectTimer4;
		}
	#endif
	
	#if (UIDM_MASK_COUNT > 4)
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_UIDetect4;
			RenderTarget = texUIDetectMulti4;
		}
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_UIDetectTimer5;
			RenderTarget = texUIDetectTimer5;
		}
	#endif
	
	#if (UIDM_DIAGNOSTICS == 1)
		pass {
			VertexShader = PostProcessVS;
			PixelShader = State_Pixel_Color;
			RenderTarget = textextcolor;
		}
		pass {
			VertexShader = PostProcessVS;
			PixelShader = Fontinvert;
			RenderTarget = textextcolor2;
		}
		pass {
			VertexShader = PostProcessVS;
			PixelShader = FontTransparancy;
		}
		pass {
			VertexShader = PostProcessVS;
			PixelShader = Crosshair;
		}
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_StoreColor;
			RenderTarget = texColorOrigMulti;
		}
	#endif
}

technique UIDetectMulti_Before {
    pass {
        VertexShader = PostProcessVS;
        PixelShader = PS_StoreColor;
        RenderTarget = texColorBeforeMulti;
    }
	#if (UIDM_ANTIBLOOM == 1)
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_Antibloom;
		}
	#endif
}

technique UIDetectMulti_After
{
	pass {
		VertexShader = PostProcessVS;
		PixelShader = PS_RestoreColor;
	}
	#if (UIDM_DIAGNOSTICS == 1)
		pass {
			VertexShader = PostProcessVS;
			PixelShader = PS_ShowOrigColor;
		}
	#endif
}
