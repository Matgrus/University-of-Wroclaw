using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class start2 : MonoBehaviour
{
    private Vector3 pos1;
    private Vector3 pos2;
    private Vector3 pos1_down;
    private Vector3 pos2_down;

    public Transform wall1;
    public Transform wall2;

    private Rigidbody ball_rb;

    public static bool ready1;
    public static bool ready2;

    void Start()
    {
        ball_rb = GetComponent<Rigidbody>();
        pos1 = wall1.transform.position;
        pos2 = wall2.transform.position;
        pos1_down = pos1 + Vector3.right * 20.0f;
        pos2_down = pos2 + Vector3.right * 20.0f;
        wall2.transform.position = pos2_down;
        ready1 = false;
        ready2 = false;

    }

    void Update()
    {

        if (this.transform.position.x > 5.2  
            && ball_rb.velocity.z > 0)
        {
            ready1 = true;
        }

        if (this.transform.position.z > -3.5 && this.transform.position.z < 5.8 && this.transform.position.x > 5.2 && ball_rb.velocity.z < 0)
        {
            ready2 = true;
        }

        if(ready1 && ready2)
        {
            wall1.transform.position = pos1_down;
            wall2.transform.position = pos2;
        }

        if(this.transform.position.x > 4.76 && this.transform.position.x < 5.1 && this.transform.position.z > -5.0 && this.transform.position.z < -1.0)
        {
            Invoke("Change_ready", 2.0f);
        }
    }

    private void Change_ready()
    {
        ready1 = false;
        ready2 = false;
        wall1.transform.position = pos1;
        wall2.transform.position = pos2_down;
    }
}
