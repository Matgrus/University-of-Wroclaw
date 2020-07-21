using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Floor_movement : MonoBehaviour
{
    private Rigidbody floor_rigidbody;

    void Start()
    {
        floor_rigidbody = GetComponent<Rigidbody>();
        floor_rigidbody.velocity = Vector3.back * Floor.vel;
    }

}
