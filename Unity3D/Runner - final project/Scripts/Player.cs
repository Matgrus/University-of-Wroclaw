using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Player : MonoBehaviour
{
    
    private Transform player_transform;
    private int pos_current;
    private Vector3[] positions = new Vector3[3];

    private Vector3 lerp_start_pos;
    private Vector3 lerp_end_pos;
    public static float current_lerp_time = 0f;
    private float final_lerp_time = 0.25f;
    private float final_jump_time = 0.3f;
    private bool moving;
    private bool jumping;
    private bool falling_down;

    private Animator anim;

    private AudioSource sound;

    void Start()
    {
        moving = false;
        jumping = false;
        falling_down = false;
        player_transform = GetComponent<Transform>();
        positions[0] = player_transform.position + Vector3.left * 3;
        positions[1] = player_transform.position;
        positions[2] = player_transform.position + Vector3.right * 3;
        pos_current = 1;

        anim = GetComponent<Animator>();

        sound = GetComponent<AudioSource>();
    }

    void Update()
    {

        if (!moving)
        {
            if (Input.GetKeyDown(KeyCode.A) || Input.GetKeyDown(KeyCode.LeftArrow))
            {
                if (pos_current > 0)
                {
                    this.transform.rotation = Quaternion.Euler(0, -45, 0);
                    moving = true;
                    lerp_start_pos = this.transform.position;
                    pos_current -= 1;
                    lerp_end_pos = positions[pos_current];
                }
            }
            else if (Input.GetKeyDown(KeyCode.D) || Input.GetKeyDown(KeyCode.RightArrow))
            {
                if (pos_current < 2)
                {
                    this.transform.rotation = Quaternion.Euler(0, 45, 0);
                    moving = true;
                    lerp_start_pos = this.transform.position;
                    pos_current += 1;
                    lerp_end_pos = positions[pos_current];
                }
            }
            else if (Input.GetKeyDown(KeyCode.Space))
            {
                sound.Play();
                anim.Play("BasicMotions@Jump01 0");
                moving = true;
                jumping = true;
                lerp_start_pos = this.transform.position;
                lerp_end_pos = this.transform.position + Vector3.up * 2.5f;
            }
            else
            {
                this.transform.rotation = Quaternion.Euler(0, 0, 0);
            }
        }
        else
        {
            if (jumping)
            {
                if (!falling_down)
                {
                    if (current_lerp_time < final_jump_time)
                    {
                        this.transform.position = Vector3.Lerp(lerp_start_pos, lerp_end_pos, current_lerp_time / final_lerp_time);
                        current_lerp_time += Time.deltaTime;
                    }
                    else
                    {
                        this.transform.position = Vector3.Lerp(lerp_start_pos, lerp_end_pos, 1);
                        current_lerp_time = 0;
                        falling_down = true;
                    }
                }
                else
                {
                    if (current_lerp_time < final_jump_time)
                    {
                        this.transform.position = Vector3.Lerp(lerp_end_pos, lerp_start_pos, current_lerp_time / final_lerp_time);
                        current_lerp_time += Time.deltaTime;
                    }
                    else
                    {
                        this.transform.position = Vector3.Lerp(lerp_end_pos, lerp_start_pos, 1);
                        current_lerp_time = 0;
                        falling_down = false;
                        moving = false;
                        jumping = false;
                    }
                }
            }
            else
            {
                if (current_lerp_time < final_lerp_time)
                {
                    this.transform.position = Vector3.Lerp(lerp_start_pos, lerp_end_pos, current_lerp_time / final_lerp_time);
                    current_lerp_time += Time.deltaTime;
                }
                else
                {
                    moving = false;
                    this.transform.position = Vector3.Lerp(lerp_start_pos, lerp_end_pos, 1);
                    current_lerp_time = 0;
                }
            }
        }

    }

}
