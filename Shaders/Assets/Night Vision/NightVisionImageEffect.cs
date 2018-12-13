using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ImageEffectAllowedInSceneView]
[ExecuteInEditMode]
public class NightVisionImageEffect : MonoBehaviour {

    public Material effectMaterial;

	// Use this for initialization
	void OnEnable () {

        this.GetComponent<Camera>().depthTextureMode = DepthTextureMode.Depth;
	}
	
    [ImageEffectOpaque]
    void OnRenderImage(RenderTexture source, RenderTexture destination) {

        Graphics.Blit(source, destination, effectMaterial);
    }


}
