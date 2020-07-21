using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class torus_speedup : MonoBehaviour
{
    private Rigidbody ball_rb;

    void Start()
    {
        ball_rb = GetComponent<Rigidbody>();
    }

        void Update()
    {
        if(ball_rb.velocity.z > 0 && this.transform.position.x > -2.89 && this.transform.position.x < -2.44 && this.transform.position.z > 1.44 && this.transform.position.z < 1.8)
        {
            this.transform.position = new Vector3(-2.69f, this.transform.position.y, this.transform.position.z);
            ball_rb.velocity = new Vector3(0f, 0f, 20f);
        }
    }
}
