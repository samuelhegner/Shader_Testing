Shader "Unlit/Hologram"
{
    Properties
    {
        _MainTex ("Albedo Texture", 2D) = "white" {}
        _TintColor("Tint Color", Color) = (1,1,1,1)
        _Transparency("Transparency", Range(0.0, 0.5)) = 0.25
        _CutoutThresh("Cutout Threshold", Range(0.0, 1.0)) = 0.2
        _Distance ("Distance", float) = 1
        _Amplitude("Amplitude", float) = 1
        _Speed("Speed", float) = 1
        _Amount("Amount", Range(0.0, 1.0)) = 1
        
        _RandomVal ("Random Value", float) = 0
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType"="Transparent" }
        LOD 100
        
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha
        
        
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
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _TintColor;
            float _Transparency;
            float _CutoutThresh;
            float _Distance;
            float _Amplitude;
            float _Amount;
            float _Speed;
            
            float _RandomVal;
            
            float random (float2 uv)
            {
                return frac(sin(dot(uv,float2(12.9898,78.233)))*43758.5453123);
            }
            

            v2f vert (appdata v)
            {
                v2f o;
                
                float k = random(v.uv);
                
                v.vertex.z += sin(_Time.y * _Speed + v.vertex.x  * _Amplitude) * _Distance * _Amount;
                v.vertex.x += (k * _RandomVal);
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv) + _TintColor;
                col.a = _Transparency;
                clip(col.b - _CutoutThresh);
                return col;
            }
            ENDCG
        }
    }
}
