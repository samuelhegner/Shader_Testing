Shader "Unlit/AppearingObject"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _NewAlpha ("New Alpha", float) = 0
        
        _YVal ("New Y Value", float) = 0
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
            
            float _NewAlpha;
            float _YVal;

            v2f vert (appdata v)
            {
                v2f o;
                
                v.vertex.y += _YVal;
                
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                
                fixed4 col = tex2D(_MainTex, i.uv);
                 
                col.a = _NewAlpha;
                                 
                return col;
            }
            ENDCG
        }
    }
}
