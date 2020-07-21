using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Restart : MonoBehaviour
{

    void Update()
    {
        if (Input.GetKey(KeyCode.R))
        {
            Cam.should_shake = false;
            Lost.game_over = false;
            Enemies.current_time_start = 0;
            Time.timeScale = 1;
            SceneManager.LoadScene("SampleScene");
        }
    }
}
