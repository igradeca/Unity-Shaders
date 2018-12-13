using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SnowPhysicsSimulator : MonoBehaviour {

    public ComputeShader shader;
    public Texture cameraInput;

    private int textureIndex;
    public RenderTexture[] texture;

    public float recoveryTime;

    public Texture SnowTexture {
        get { return texture[textureIndex]; }
    }

    public Texture SnowBuffer {
        get { return texture[(textureIndex + 1) % 2]; }
    }

    private int physicsSimulationId;

    public Material snowMaterial;

	// Use this for initialization
	void Start () {

        physicsSimulationId = shader.FindKernel("SnowPhysicsUpdate");
        int overwrite = shader.FindKernel("SnowFlashInput");
        
        for (int i = 0; i < texture.Length; i++) {
            texture[i] = new RenderTexture(cameraInput.width, cameraInput.height, 24);
            texture[i].format = RenderTextureFormat.RFloat;
            texture[i].wrapMode = TextureWrapMode.Repeat;
            texture[i].filterMode = FilterMode.Point;
            texture[i].enableRandomWrite = true;
            texture[i].Create();
        }

        shader.SetTexture(overwrite, "Input", cameraInput);
        shader.SetTexture(overwrite, "PreviousState", SnowTexture);
        shader.SetTexture(overwrite, "Result", SnowBuffer);
        shader.Dispatch(overwrite, SnowTexture.width / 8, SnowTexture.height / 8, 1);

        shader.SetFloat("Width", SnowTexture.width);
        shader.SetFloat("Height", SnowTexture.height);
        shader.SetTexture(physicsSimulationId, "Input", cameraInput);        
    }

    // Update is called once per frame
    void FixedUpdate () {
        
        shader.SetFloat("ElapsedTime", Time.fixedDeltaTime);
        shader.SetFloat("RecoveryTime", recoveryTime);
        shader.SetTexture(physicsSimulationId, "PreviousState", SnowBuffer);
        shader.SetTexture(physicsSimulationId, "Result", SnowTexture);
        shader.Dispatch(physicsSimulationId, SnowTexture.width / 8, SnowTexture.height / 8, 1);

        snowMaterial.SetTexture("_DispTex", SnowTexture);
        textureIndex = (textureIndex + 1) % 2;
    }
}
