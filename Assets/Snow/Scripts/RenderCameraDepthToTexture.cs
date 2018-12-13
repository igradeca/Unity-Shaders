using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RenderCameraDepthToTexture : MonoBehaviour {

    public Camera cameraDepth;

	// Use this for initialization
	void Start () {

        cameraDepth.depthTextureMode = DepthTextureMode.Depth;
	}
}
