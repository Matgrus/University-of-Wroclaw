using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Lost : MonoBehaviour
{
    public static bool game_over = false;
    private Text game_over_txt;
    public Text restart_txt;

    public AudioClip clip;
    AudioSource sound;
    private bool played = false;

    public GameObject cam;
    private AudioSource cam_sound;

    void Start()
    {
        game_over_txt = GetComponent<Text>();
        game_over_txt.enabled = false;
        sound = GetComponent<AudioSource>();
        restart_txt.enabled = false;
        cam_sound = cam.GetComponent<AudioSource>();
    }

    void FixedUpdate()
    {

        if (game_over)
        {
            if (!played)
            {
                Cam.should_shake = true;
                StartCoroutine(ExecuteAfterTime(1));
                sound.PlayOneShot(clip);
                played = true;
            }
            Time.timeScale = 0;
            game_over_txt.enabled = true;
            restart_txt.enabled = true;
            cam_sound.enabled = false;
        }
    }

    IEnumerator ExecuteAfterTime(float time)
    {
        yield return new WaitForSecondsRealtime(time);

        Cam.should_shake = false;
    }

}
