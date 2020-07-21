using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Enemies : MonoBehaviour
{
    private Transform enemies;
    private float changer = -1.0f;
    
    private float fire = 0.95f;
    public GameObject shot;

    public Text win_txt;
    private AudioSource sound;

    void Start()
    {
        win_txt.enabled = false;
        sound = GetComponent<AudioSource>();
        enemies = GetComponent<Transform>();
        InvokeRepeating("Pos_change", 0.1f, 0.4f);
    }

    void Pos_change()
    {
        foreach (Transform enemy in enemies)
        {
            enemies.position = new Vector3(enemies.position[0], enemies.position[1], enemies.position[2] + changer / enemies.childCount);

            if (enemy.position.z < -19 || enemy.position.z > 20)
            {
                enemies.position = new Vector3(enemies.position[0] + 2.2f, enemies.position[1], enemies.position[2] - (enemy.position[2] - Mathf.Floor(Mathf.Abs(enemy.position[2])) * changer));
                changer *= -1;
            }

            if(Random.value > fire)
            {
                Instantiate(shot, new Vector3(enemy.position[0], 1.0f, enemy.position[2]), enemy.rotation);
            }

            if(enemy.position.x > 1)
            {
                Lost.game_over = true;
            }

        }

        if (enemies.childCount < 6)
        {
            if (enemies.childCount == 1)
            {
                CancelInvoke();
                InvokeRepeating("Pos_change", 0.03f, 0.1f);
            }
            else if(enemies.childCount == 0)
            {
                sound.Play();
                win_txt.enabled = true;
                CancelInvoke();
            }
            else
            {
                CancelInvoke();
                InvokeRepeating("Pos_change", 0.05f, 0.1f);
            }
        }
        
    }
}
