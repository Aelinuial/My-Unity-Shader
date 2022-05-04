using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PostEffectBlood : MonoBehaviour
{
    public Shader shader;
    private Material mat;
    public Texture2D bloodTexture;
    [Range(0, 5)]
    public float bloodStatus = 0;
    public bool isFlash = true;
    [Range(0, 3)]
    public float flashSpeed = 0;
    
    void Start()
    {
        bloodStatus = 0;
        mat         = new Material(shader);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination) {
        if(mat != null){
            mat.SetTexture("_BloodTex", bloodTexture);
            mat.SetFloat("_BloodStatus", bloodStatus);
            mat.SetInt("_Flash", isFlash? 1 : 0);
            mat.SetFloat("_FlashSpeed", flashSpeed);
            Graphics.Blit(source, destination, mat);
        }
        else{
            Graphics.Blit(source, destination);
        }
    }
}
