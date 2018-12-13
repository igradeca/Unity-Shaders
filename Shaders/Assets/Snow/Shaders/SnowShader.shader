Shader "Custom/SnowTessShader" {
	Properties {
		_SnowColor ("Snow Color", Color) = (1,1,1,1)
		_GroundColor ("Ground Color", Color) = (1,1,1,1)
		_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
		_Glossines ("Glossines", Range (0.03, 1)) = 0.078125
		_Shininess ("Shininess", Range (0.03, 1)) = 0.078125
		_Displacement ("Height", Range (0.0, 1.0)) = 0.5
		_MainTex ("Snow Texture", 2D) = "white" {}
		_GroundTex ("Ground Texture", 2D) = "white" {}
		_DispTex ("Displacement Texture", 2D) = "black" {} // Displacement texture
		_BumpMap ("Normal Map", 2D) = "bump" {}

		_EdgeLength ("Edge length", Range(3,50)) = 10
	}
	SubShader { 
		Tags { "RenderType"="Opaque" }
		LOD 800 // 800 Level Of Detail
	
		CGPROGRAM
		#pragma surface surf BlinnPhong addshadow vertex:disp tessellate:tessEdge
		#include "Tessellation.cginc"

		struct appdata {
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float2 texcoord : TEXCOORD0;
			float2 texcoord1 : TEXCOORD1;
			float2 texcoord2 : TEXCOORD2;
		};

		float _EdgeLength;
		float _Displacement;

		float4 tessEdge (appdata v0, appdata v1, appdata v2)
		{
			return UnityEdgeLengthBasedTessCull (v0.vertex, v1.vertex, v2.vertex, _EdgeLength, _Displacement * 1.5f);
		}

		sampler2D _DispTex;

		void disp (inout appdata v)
		{
			float d = tex2Dlod(_DispTex, float4(v.texcoord.x, v.texcoord.y, 0, 0)).r;
			//v.vertex.xyz += v.normal * d;
			v.vertex.xyz += v.normal * (1 - d) * _Displacement;
		}

		sampler2D _MainTex;
		sampler2D _GroundTex;
		sampler2D _BumpMap;
		fixed4 _SnowColor;
		fixed4 _GroundColor;
		half _Shininess;
		half _Glossines;

		struct Input {
			float2 uv_MainTex;
			float2 uv_GroundTex;
			float2 uv_DispTex;
			float2 uv_BumpMap;
		};

		void surf (Input IN, inout SurfaceOutput o) {

			
			half amount = tex2Dlod(_DispTex, float4(IN.uv_DispTex.xy, 0, 0)).r;
			fixed4 c = lerp(tex2D(_MainTex, IN.uv_MainTex) * _SnowColor, tex2D(_MainTex, IN.uv_MainTex) * _GroundColor, amount);
			//fixed4 c = tex2D(_MainTex, IN.uv_MainTex);

			o.Albedo = c.rgb;//c.rgb; // c.rgb; fixed4(1, 0, 0, 1);

			o.Gloss = _Glossines; // c.a;
			o.Specular = _Shininess;
			o.Alpha = c.a * _SnowColor.a;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
		}
		ENDCG
	}

	FallBack "Bumped Specular"
	}
