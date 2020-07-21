using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class start_ball : MonoBehaviour
{
    float power;
    public float max_power = 100f;
    public Slider powerSlider;
    List<Rigidbody> ball_list;
    bool ball_ready;

    void Start()
    {
        powerSlider.minValue = 0f;
        powerSlider.maxValue = max_power;
        ball_list = new List<Rigidbody>();
    }

    void Update()
    {
        if (ball_ready)
        {
            powerSlider.gameObject.SetActive(true);
        }
        else
        {
            powerSlider.gameObject.SetActive(false);
        }

        powerSlider.value = power;
        if(ball_list.Count > 0)
        {
            ball_ready = true;
            if (Input.GetKey(KeyCode.Space))
            {
                if(power <= max_power)
                {
                    power += 100 * Time.deltaTime;
                }
            }

            if (Input.GetKeyUp(KeyCode.Space))
            {
                foreach(Rigidbody x in ball_list)
                {
                    x.AddForce(power * Vector3.forward);
                }
            }
        }
        else
        {
            ball_ready = false;
            power = 0f;
        }

    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Ball"))
        {
            ball_list.Add(other.gameObject.GetComponent<Rigidbody>());
        }
    }
    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.CompareTag("Ball"))
        {
            ball_list.Remove(other.gameObject.GetComponent<Rigidbody>());
            power = 0f;
        }
    }
}
