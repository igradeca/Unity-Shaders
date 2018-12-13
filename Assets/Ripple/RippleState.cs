using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RippleState : MonoBehaviour {

    public float speed;
    public Material material;

    private Vector4 rippleOrigin = Vector4.zero;
    public Vector3 RippleOrigin { set { rippleOrigin = new Vector4(value.x, 0.0f, value.z, 0.0f); } }

    // Use this for initialization
    void Start() {

        
    }

    // Update is called once per frame
    void Update() {

        rippleOrigin.w = Mathf.Clamp(rippleOrigin.w + (Time.deltaTime * speed), 0.0f, 1.0f);
        material.SetVector("_RippleOrigin", rippleOrigin);        
    }
}
