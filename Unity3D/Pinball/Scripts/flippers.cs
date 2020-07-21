using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class flippers : MonoBehaviour
{

    private AudioSource sound;
    public float rest_pos = 0f;
    public float pressed_pos = 45f;
    public float hit_str = 10000f;
    public float flipper_damper = 150f;

    public string input_name;

    HingeJoint hinge;

    void Start()
    {
        hinge = GetComponent<HingeJoint>();
        hinge.useSpring = true;
        sound = GetComponent<AudioSource>();
    }

    void Update()
    {
        JointSpring spring = new JointSpring();
        spring.spring = hit_str;
        spring.damper = flipper_damper;
        if(Input.GetAxis(input_name) == 1)
        {
            spring.targetPosition = pressed_pos;
            sound.Play();
        }
        else
        {
            spring.targetPosition = rest_pos;
        }

        hinge.spring = spring;
        hinge.useLimits = true;
        
    }
}
