using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SphereMovement : MonoBehaviour {

    public float circleSize;
    public float circleSpeed;
    public float circleHeightSpeed;
    public float height;
    public float circleHeightMod;
	
	// Update is called once per frame
	void Update () {

        this.transform.position = new Vector3(
            Mathf.Cos(Time.time * circleSpeed) * circleSize,
            height + Mathf.Sin(Time.time * circleHeightSpeed) * circleHeightMod,
            Mathf.Sin(Time.time * circleSpeed) * circleSize);

	}
}
