Shader "myShader/passFur"
{
    Properties
    {
        _furTex("Fur Texture", 2D) = "white" {}
        _noiseTex ("Noise Texture", 2D) = "white" {}
        _furLength("Fur Length", float) = 0.5
        _uvOffset("UV Offset", vector) = (0, 0, 0.2, 0.2)
    }

    category{

        Tags{
            "LightMode" = "ForwardBase"
            "RenderType" = "Transparent"
            "IgnoreProjector" = "True"
            "Queue" = "Transparent"
        }
        Blend SrcAlpha OneMinusSrcAlpha

        SubShader
        {
            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.05
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG       
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.1
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG  
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.15
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.2
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.25
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.3
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.35
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.4
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.45
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.5
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.55
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.6
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }
        }
    }
}
