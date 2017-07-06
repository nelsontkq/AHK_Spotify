#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance force ; disables warning when refreshing script.
#Include ./Functions.ahk
#Include ./GlobalVariables.ahk
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetControlDelay -1

;;;;; Script specifics ;;;;
If Not A_IsAdmin
{
    Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
    ExitApp
}
^+r::Reload
^+p::Pause
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Gnome-style hotkeys ;;;
;Run terminal
^!t:: Run, Powershell.exe

;Toggle hidden items
^!h:: 
    codeLines=
    (
        $key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
        $keyProperties = Get-ItemProperty $key
        $hidden = $keyProperties.Hidden
        If($hidden -eq "2") 
        {
            Set-ItemProperty $key Hidden 1
            Set-ItemProperty $key ShowSuperHidden 1
        }
        Else
        {
            Set-ItemProperty $key Hidden 2
            Set-ItemProperty $key ShowSuperHidden 0
        }
    )
    PsRun(codeLines)
    RefreshExplorer()
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;


F6:: ; open relevant ahk script files in VSCode
    codeLine = code %A_ScriptFullPath% %A_ScriptDir%\Functions.ahk %A_ScriptDir%\GlobalVariables.ahk
    PsRun(codeLine)
return

;;;;;;;;;; Spotify ;;;;;;;;;
!s::InitializeSpotify()
!Left::Media_Prev
!Right::Media_Next
!Space::Media_Play_Pause
!Home::FavouriteSpotifySong()
!Up::SetSpotifyVolume(2)
!Down::SetSpotifyVolume(-2)
^!Up::SetSpotifyVolume(SPOTIFY_VOLUME_MAX)
^!Down::SetSpotifyVolume(0)
;;;;;;;;;;;;;;;;;;;;;;;;;;;

!^c:: Run, "%A_WinDir%\System32\calc.exe"

!o:: Run, ".\Shortcuts\obs64.lnk"