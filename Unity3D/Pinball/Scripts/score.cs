using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class score : MonoBehaviour
{
    public static int score_res = 0;
    private GUIStyle style = new GUIStyle();
    

    private void OnGUI()
    {
        style.fontSize = 40;
        GUILayout.Label("Score: " + score_res.ToString(), style);
    }

}
