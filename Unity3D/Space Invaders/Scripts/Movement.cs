using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Movement : MonoBehaviour
{
    private Transform player;

    public GameObject shot;
    public Transform spawn;
    private float next_shot;
    private AudioSource sound;
    void Start(){
        player = GetComponent<Transform>();
        sound = GetComponent<AudioSource>();
    }

    void FixedUpdate(){
        float h = Input.GetAxis("Horizontal");
        if(player.position.z < -19 && h < 0){
            h = 0;
        }else if(player.position.z > 20 && h > 0){
            h = 0;
        }
        else{
            player.position += Vector3.forward * h * 0.3f;
        }
        if (Input.GetKey(KeyCode.Space) && Time.time > next_shot)
        {
            Instantiate(shot, spawn.position, spawn.rotation);
            next_shot = Time.time + 0.5f;
            sound.Play();
        }
    }
}
