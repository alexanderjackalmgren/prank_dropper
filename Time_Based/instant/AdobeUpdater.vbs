On Error Resume Next
Set oPlayer = CreateObject("WMPlayer.OCX")

' Link to the MP3 in the temp folder
oPlayer.URL = "C:\temp\file.mp3"
oPlayer.controls.play

' The script stays alive in RAM until the music finishes
While oPlayer.playState <> 1
    WScript.Sleep 1000
Wend