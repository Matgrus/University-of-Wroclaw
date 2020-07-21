using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Enemies : MonoBehaviour
{
    private Transform enemies;
    
    private float fire = 0.95f;
    public GameObject shot;

    public Text win_txt;
    private AudioSource sound;

    private Vector3 startpos;
    private Vector3 endpos;
    public static float current_time_start = 0f;
    private float lerp_time_start = 1f;

    private Rigidbody rb;
    private float speed = -3f;
    private float speed2 = -10f;
    private float speed3 = -20f;

    public static float current_time_down = 0f;
    private float lerp_time_down = 1f;
    private bool down = false;
    private Vector3 startpos_down;
    private Vector3 endpos_down;

    public GameObject effect;

    public GameObject cam;
    private AudioSource cam_sound;


    void Start()
    {
        win_txt.enabled = false;
        sound = GetComponent<AudioSource>();
        enemies = GetComponent<Transform>();

        endpos = enemies.position;
        startpos = endpos + Vector3.left * 3;

        rb = GetComponent<Rigidbody>();

        cam_sound = cam.GetComponent<AudioSource>();
    }

    private void FixedUpdate()
    {

        if (current_time_start < lerp_time_start && current_time_start > -1)
        {
            enemies.position = Berp(startpos, endpos, current_time_start / lerp_time_start);
            current_time_start += Time.deltaTime;
        }
        else if (current_time_start >= lerp_time_start)
        {
            enemies.position = Berp(startpos, endpos, 1);
            current_time_start = -10;
            InvokeRepeating("Fire_fun", 0.1f, 0.4f);
        }
        else if(!down)
        {

            rb.velocity = new Vector3(0, 0, speed);
            foreach (Transform enemy in enemies)
            {
                if(enemy.position.z < -18)
                {
                    enemies.position = new Vector3(enemies.position[0], enemies.position[1], enemies.position[2] + 1f);
                    speed *= -1;
                    speed2 *= -1;
                    speed3 *= -1;
                    down = true;
                    startpos_down = enemies.position;
                    endpos_down = enemies.position + Vector3.right * 2;
                }
                else if(enemy.position.z > 18.2)
                {
                    enemies.position = new Vector3(enemies.position[0], enemies.position[1], enemies.position[2] - 1f);
                    speed *= -1;
                    speed2 *= -1;
                    speed3 *= -1;
                    down = true;
                    startpos_down = enemies.position;
                    endpos_down = enemies.position + Vector3.right * 2;
                }
            }
        }
        else
        {
            if (current_time_down < lerp_time_down)
            {
                enemies.position = Vector3.Lerp(startpos_down, endpos_down, current_time_down / lerp_time_down);
                current_time_down += Time.deltaTime;
            }
            else
            {
                down = false;
                enemies.position = Vector3.Lerp(startpos_down, endpos_down, 1);
                current_time_down = 0;
            }
        }

    }

    void Fire_fun()
    {

        if (enemies.childCount < 6)
        {
            if (enemies.childCount == 1)
            {
                lerp_time_down = 0.3f;
                speed = speed3;
                CancelInvoke();
                InvokeRepeating("Fire_fun", 0.03f, 0.1f);
            }
            else if (enemies.childCount == 0)
            {
                sound.Play();
                win_txt.enabled = true;
                cam_sound.enabled = false;
                CancelInvoke();
                Instantiate(effect, new Vector3(-10, 1, -5), Quaternion.identity);
                Instantiate(effect, new Vector3(-10, 1, 0), Quaternion.identity);
                Instantiate(effect, new Vector3(-10, 1, 5), Quaternion.identity);
                Instantiate(effect, new Vector3(-10, 1, -10), Quaternion.identity);
                Instantiate(effect, new Vector3(-10, 1, 10), Quaternion.identity);
            }
            else
            {
                lerp_time_down = 0.6f;
                speed = speed2;
                CancelInvoke();
                InvokeRepeating("Fire_fun", 0.05f, 0.1f);
            }
        }

        foreach (Transform enemy in enemies)
        {
            if (Random.value > fire)
            {
                Instantiate(shot, new Vector3(enemy.position[0], 1.0f, enemy.position[2]), new Quaternion(0, 90, 0, 0));
            }

            if(enemy.position.x > 8)
            {
                Lost.game_over = true;
            }

        }
        
    }

    public static float Berp(float start, float end, float value)
    {
        value = Mathf.Clamp01(value);
        value = (Mathf.Sin(value * Mathf.PI * (0.2f + 2.5f * value * value * value)) * Mathf.Pow(1f - value, 2.2f) + value) * (1f + (1.2f * (1f - value)));
        return start + (end - start) * value;
    }

    public static Vector3 Berp(Vector3 start, Vector3 end, float value)
    {
        return new Vector3(Berp(start.x, end.x, value), Berp(start.y, end.y, value), Berp(start.z, end.z, value));
    }
     

}
