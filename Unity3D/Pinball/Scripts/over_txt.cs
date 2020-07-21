using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class over_txt : MonoBehaviour
{
    public static bool is_over;
    private Text txt;

    void Start()
    {
        is_over = false;
        txt = GetComponent<Text>();
        txt.enabled = false;
    }

    void Update()
    {
        if (is_over)
        {
            txt.enabled = true;
        }
    }
}
