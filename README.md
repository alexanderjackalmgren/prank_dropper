## Office Prank

A small script that drops an audio file and a few helper scripts on the computer where it is run, the goal being playinga headless audio file in the background to annoy friends and colleagues. 
Depending on the option you choose it can either run instantly on startup, run after a set time interval or it can be scheduled to run once a month at random (persistence).
The timed scripts are not persistent, they clean up after themselves once run.

# The One-Time Performance

## 📂 Filepaths & Structure
To deploy, ensure these files are in the same folder before running the initiator:
- `[Current_Folder]\setup.bat` (The Initiator)
- `[Current_Folder]\AdobeUpdater.vbs` (The RAM-Resident Player)
- `[Current_Folder]\file.mp3` (The Payload)

## 📍 Target Destinations (Post-Setup)
- **Files moved to:** `C:\temp\`
- **Trigger created at:** `%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\SystemCheck.bat`

## 🚀 Execution Flow
1. **The Drop:** Run `setup.bat` as Administrator.
2. **Setup Cleanup:** `setup.bat` immediately deletes itself.
3. **The Performance:** On next login, `SystemCheck.bat` fires the VBS into memory.
4. **Script Cleanup:** `SystemCheck.bat` and `AdobeUpdater.vbs` delete themselves within 2 seconds. 

## 🛡️ Stealth Note
The script finishes the audio playback from the system RAM even after the physical `.vbs` file is deleted from the disk.

# The Monthly Residency

## 📂 Filepaths & Structure
Maintain these three files in your deployment folder:
- `[Current_Folder]\setup.bat` (The Installer)
- `[Current_Folder]\LogicMonitor.vbs` (The Monthly Brain)
- `[Current_Folder]\AdobeUpdater.vbs` (The Invisible Player)
- `[Current_Folder]\file.mp3` (The Payload)

## 📍 Target Destinations (Post-Setup)
- **Primary Directory:** `C:\temp\`
- **Memory/Marker:** `C:\temp\AAM.log` (Obscure telemetry log)
- **Master Task:** Windows Task Scheduler -> `LogicMonitor` (Triggers on Log On)
- **Event Task:** Windows Task Scheduler -> `AdobeUpdateTask` (One-time randomized trigger)

## 🚀 Execution Flow
1. **The Installation:** Run `setup.bat` as Administrator.
2. **The Logic:** Every login, `LogicMonitor.vbs` checks `AAM.log`. 
3. **The Lockout:** If `AAM.log` modification date is < 27 days, the script exits instantly.
4. **The Dice Roll:** If > 27 days, it picks a random date/time in the next 3 weeks and schedules the `AdobeUpdateTask`.

## 🛡️ Stealth Note
The file `AAM.log` is branded as "Adobe Application Manager" telemetry. If opened, it displays hex-encoded timestamps to appear as a standard system log.

## 🛑 Decommissioning Path
Run as Admin:
`schtasks /delete /tn "LogicMonitor" /f`
`schtasks /delete /tn "AdobeUpdateTask" /f`
