// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unlit/HologramShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Color ("Color", Color) = (1, 1, 1, 1)
		_Bias ("Bias", float) = 1
		_ScanningFrequency ("Scanning Frequency", float) = 400
		_ScanningSpeed ("Scanning Speed", float) = 10
	}
	SubShader
	{
		Tags { "Queue"="Transparent" "RenderType"="Transparent"}
		LOD 100
		ZWrite Off
		Blend SrcAlpha One
		Cull Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(2)
				float4 vertex : SV_POSITION;
				float4 objVertex : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed4 _Color;
			float _Bias;
			float _ScanningFrequency;
			float _ScanningSpeed;			
			
			v2f vert (appdata v)
			{
				v2f o;
				//o.objVertex = v.vertex;
				o.objVertex = mul(unity_ObjectToWorld, v.vertex);
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				//fixed4 col = tex2D(_MainTex, i.uv);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				
				
				fixed4 col = _Color * cos(i.vertex.x * _ScanningFrequency) + _Bias;
				col *= _Color * max(0, cos(i.objVertex.y * _ScanningFrequency + (_Time[1] * _ScanningSpeed)) + _Bias);
				
				col *= _Color * cos(i.objVertex.y * 29 + (_Time[1] * 0.7));
				
				return col;
			}
			ENDCG
		}
	}
}
