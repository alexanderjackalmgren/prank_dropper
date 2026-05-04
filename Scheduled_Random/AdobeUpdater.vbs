On Error Resume Next
Set oPlayer = CreateObject("WMPlayer.OCX")

' Set the path to your MP3
oPlayer.URL = "C:\temp\file.mp3"
oPlayer.controls.play

' Wait until the music finishes before closing the process
While oPlayer.playState <> 1
    WScript.Sleep 1000
Wend