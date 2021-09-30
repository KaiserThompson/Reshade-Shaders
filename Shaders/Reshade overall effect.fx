#include "ReShadeUI.fxh"
#include "ReShade.fxh"

uniform float effects < __UNIFORM_SLIDER_FLOAT3
	ui_label = "Intensity";
	ui_min = 0; ui_max = 1;
	ui_step = 0.01;
> = 1;

texture texColorOrig { Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; };
sampler ColorOrig { Texture = texColorOrig; };

float4 PS_Before(float4 pos : SV_POSITION,float2 uv : TEXCOORD) : SV_Target
{
	return tex2D(ReShade::BackBuffer, uv);
}

float4 PS_After(float4 pos : SV_POSITION,float2 uv : TEXCOORD) : SV_Target
{
	float4 original = tex2D(ColorOrig, uv);
	float4 effected = tex2D(ReShade::BackBuffer, uv);
	return lerp(original, effected, effects);
}

technique Before
{
    pass {
        VertexShader = PostProcessVS;
        PixelShader = PS_Before;
        RenderTarget = texColorOrig;
    }
}

technique After
{
    pass {
        VertexShader = PostProcessVS;
        PixelShader = PS_After;
    }
}