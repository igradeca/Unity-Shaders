using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RippleRepeater : MonoBehaviour {

    public float maxValue;
    public float speed;
    public Material material;

    private float distance;

	// Use this for initialization
	void Start () {

        distance = 0.0f;
	}
	
	// Update is called once per frame
	void Update () {
        
        distance = (Time.time * speed) % maxValue;
        material.SetFloat("_RippelDistance", distance);
	}
}
