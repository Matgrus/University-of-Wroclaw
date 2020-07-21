using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class Main_menu : MonoBehaviour
{
    public Text Highscore_txt;
    private bool new_game = false;
    public GameObject cam;

    private Vector3 lerp_start_pos;
    private Vector3 lerp_end_pos;
    public static float current_lerp_time = 0f;
    private float final_lerp_time = 1.0f;
    private float lerp_start_rot;
    private float lerp_end_rot;

    public GameObject btn_play;
    public GameObject btn_exit;
    public GameObject player;

    private Animator anim;

    public GameObject smoke;
    private bool smoke_exists = false;

    public GameObject floor;

    void Start()
    {
        lerp_start_pos = new Vector3(-0.5f, 1, -10);
        //lerp_end_pos = new Vector3(2, 1.5f, -10);
        lerp_end_pos = new Vector3(2.5f, 2.8f, -10);
        lerp_start_rot = 0;
        lerp_end_rot = 14.15f;
        Time.timeScale = 1;
        Highscore_txt.text = "Highscore: " + ((int)PlayerPrefs.GetFloat("Highscore")).ToString();
        anim = player.GetComponent<Animator>();
        
    }

    private void Update()
    {
        if (new_game)
        {
            if (!smoke_exists)
            {
                Instantiate(smoke, new Vector3(2.5f, -0.5f, -6), Quaternion.identity);
                //Instantiate(smoke, new Vector3(-0.5f, 1, -9), Quaternion.identity);
                smoke_exists = true;
            }
            Floor.vel = 10;
            player.transform.rotation = Quaternion.Euler(0, 0, 0);
            anim.Play("BasicMotions@Sprint01");
            Highscore_txt.enabled = false;
            btn_play.SetActive(false);
            btn_exit.SetActive(false);

            foreach (Floor_movement child in floor.GetComponentsInChildren<Floor_movement>()){
                child.enabled = true;
            }

            if (current_lerp_time < final_lerp_time)
            {
                cam.transform.position = Vector3.Lerp(lerp_start_pos, lerp_end_pos, current_lerp_time / final_lerp_time);
                lerp_start_rot = current_lerp_time / final_lerp_time * lerp_end_rot;
                cam.transform.rotation = Quaternion.Euler(lerp_start_rot, 0, 0);
                current_lerp_time += Time.deltaTime;
            }
            else
            {
                cam.transform.position = Vector3.Lerp(lerp_start_pos, lerp_end_pos, 1);
                cam.transform.rotation = Quaternion.Euler(lerp_end_rot, 0, 0);
                current_lerp_time = 0;
                new_game = false;
                SceneManager.LoadScene("game");
                Score.score = 0;
            }
            
        }
    }

    public void Start_game()
    {
        new_game = true;
    }

    public void Exit_game()
    {
        Application.Quit();
    }

}
