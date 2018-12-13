Shader "Custom/Night Vision Shader"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Texture", 2D) = "white" {}
		_Range ("Range", float) = 0.1
		_ColorMultiplier ("Color Multiplier" , float) = 1.0
		_ColorMask ("Color Mask", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float2 uv_depth : TEXCOORD1; 
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				o.uv_depth = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			sampler2D _ColorMask;
			sampler2D_float _CameraDepthTexture;
			float _ColorMultiplier;
			float _Range;
			fixed4 _Color;

			fixed lum(fixed3 colorValue){

				return (0.299 * colorValue.r) + (0.587 * colorValue.g) + (0.114 * colorValue.b);
			}

			fixed4 frag (v2f i) : SV_Target
			{
				float depth = DecodeFloatRG(tex2D(_CameraDepthTexture, i.uv));
				float linearDepth = Linear01Depth(depth);
				linearDepth = max(0, (_Range - linearDepth) / _Range);

				fixed4 mask = tex2D(_ColorMask, i.uv);				
				fixed4 col = tex2D(_MainTex, i.uv);				
				fixed colorStrength = (lum(col) * _ColorMultiplier) + linearDepth;
				
				return colorStrength * _Color * mask;
			}
			ENDCG
		}
	}
}
