using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Movement : MonoBehaviour
{
    public static Transform player;

    public GameObject shot;
    public Transform spawn;
    private float next_shot;
    private AudioSource sound;
    float smooth = 40.0f;
    float tiltAngle = 20.0f;

    void Start(){
        player = GetComponent<Transform>();
        sound = GetComponent<AudioSource>();
    }

    void FixedUpdate(){
        if (Enemies.current_time_start == -10)
        {
            float h = Input.GetAxis("Horizontal");
            if (player.position.z < -19 && h < 0)
            {
                h = 0;
            }
            else if (player.position.z > 20 && h > 0)
            {
                h = 0;
            }
            else
            {
                float tiltAroundZ = -h * tiltAngle;
                Quaternion target = Quaternion.Euler(0, -90, tiltAroundZ);
                player.position += Vector3.forward * h * 0.3f;
                player.rotation = Quaternion.Slerp(player.rotation, target, Time.deltaTime * smooth);
            }
            if (Input.GetKey(KeyCode.Space) && Time.time > next_shot)
            {
                Instantiate(shot, spawn.position, shot.transform.rotation);
                next_shot = Time.time + 0.5f;
                sound.Play();
            }
        }
    }

    

}
