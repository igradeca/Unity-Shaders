using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class PostEffectScript : MonoBehaviour {

    public Material mat;

    void OnRenderImage(RenderTexture source, RenderTexture destination) {
        // We are taking fully rendered scene (source) and intercepting it here
        // so we can do a bit more work and then returning it (destination).     

        Graphics.Blit(source, destination, mat);
    }
}
