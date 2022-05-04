using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PostEffectMotionBlur : MonoBehaviour
{
    public Shader shader;
    private Material mat;

    [Range(0.0f, 0.9f)]
	public float blurAmount = 0.5f;

    private RenderTexture accumulationTexture;

	void OnDisable() {
		DestroyImmediate(accumulationTexture);
	}

    void Start(){
        mat = new Material(shader);
    }

    private void OnRenderImage(RenderTexture src, RenderTexture dest) {
        if(mat != null){
            if (accumulationTexture == null || accumulationTexture.width != src.width || accumulationTexture.height != src.height) {
				DestroyImmediate(accumulationTexture);
				accumulationTexture = new RenderTexture(src.width, src.height, 0);
				accumulationTexture.hideFlags = HideFlags.HideAndDontSave;
				Graphics.Blit(src, accumulationTexture);
			}
            accumulationTexture.MarkRestoreExpected();

			mat.SetFloat("_BlurAmount", 1.0f - blurAmount);

			Graphics.Blit (src, accumulationTexture, mat);
			Graphics.Blit (accumulationTexture, dest);
        }
        else{
            Graphics.Blit(src, dest);
        }
    }
}
