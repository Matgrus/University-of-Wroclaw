using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class lock_ret : MonoBehaviour
{
    public Transform ball;
    private Vector3 pos;
    public Transform wall;
    void Start()
    {
        pos = this.transform.position;
        this.transform.position += Vector3.down * 1.0f;
    }

    private void Update()
    {
        if ((ball.position.x > -4.0 && ball.position.x < 3.0 && ball.position.z > 6.5 && ball.position.z < 10.0) || wall.transform.position.x < 7.0)
        {
            Invoke("Enable_wall", 0.2f);
        }
    }

    private void Enable_wall()
    {
        this.transform.position = pos;
    }
}
