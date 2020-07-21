using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cam : MonoBehaviour
{

    public float power = 0.7f;
    public float duration = 1.0f;
    public Transform camera;
    public float slow_down_amount = 1.0f;
    public static bool should_shake = false;

    Vector3 start_pos;
    float initial_duration;

    void Start()
    {
        camera = UnityEngine.Camera.main.transform;
        start_pos = camera.localPosition;
        initial_duration = duration;
    }

    void Update()
    {
        if (should_shake)
        {
            if(duration > 0)
            {
                camera.localPosition = start_pos + Random.insideUnitSphere * power;
                duration -= Time.deltaTime * slow_down_amount;
            }
            else
            {
                should_shake = false;
                duration = initial_duration;
                camera.localPosition = start_pos;
            }
        }
    }
}
