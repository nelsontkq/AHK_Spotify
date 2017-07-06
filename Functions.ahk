; Run a PowerShell script and exit with optional params
PsRun(script, params := "none")
{
    tmpParams := params
    psScript =
    (
        %script%
        exit
    )
    returnParams := ""
    if (tmpParams != "none")
    {
        tmpParams := StrSplit(tmpParams, A_Space)
        Loop, tmpParams.Length()
        {
            MsgBox % A_Index
            tmp := tmpParams[A_Index]
            
            if (A_Index == 0)
            {
                returnParams = '%tmp%'
            }
            else
            {
                returnParams = %returnParams% '%tmp%'
            }
        }
    }
    
    RunWait PowerShell.exe -Command &{%psScript%} %returnParams%,, hide
}

RefreshExplorer()
{
	for wb in ComObjCreate("Shell.Application").Windows
	{
		if wb.Name = "File Explorer"
			ControlSend, ToolbarWindow323, {F5}, % "ahk_id " wb.hwnd
	}
	Return
}

InitializeSpotify()
{
    RunWait, %SPOTIFY_DIR%
    SetSpotifyVolume(0)
}

SetSpotifyVolume(newVolumeOffset)
{
    if SPOTIFY_VOLUME between %SPOTIFY_VOLUME_MIN% and %SPOTIFY_VOLUME_MAX%
    {
        SetSpotifyVars()
        
        SPOTIFY_VOLUME += newVolumeOffset
        newX := SPOTIFY_VOLUME_X_LOCATION + SPOTIFY_VOLUME
        ControlClick, X%newX% Y%SPOTIFY_VOLUME_Y_LOCATION%, ahk_class SpotifyMainWindow
        Exit
    }
    if abs(SPOTIFY_VOLUME_MIN - SPOTIFY_VOLUME) <= abs(SPOTIFY_VOLUME_MAX - SPOTIFY_VOLUME)
        SPOTIFY_VOLUME := SPOTIFY_VOLUME_MIN + 1
    else
        SPOTIFY_VOLUME := SPOTIFY_VOLUME_MAX - 1
    
}

FavouriteSpotifySong()
{
    SetSpotifyVars()
    yPos := SPOTIFY_Y_AXIS - 30
    ControlClick, X25 Y%yPos%, ahk_class SpotifyMainWindow,, RIGHT
    Sleep 75
    yPos -= 54
    ControlClick, X33 Y%yPos%, ahk_class SpotifyMainWindow
}

SetSpotifyVars()
{
    WinGetPos, , , SPOTIFY_X_AXIS, SPOTIFY_Y_AXIS, ahk_class SpotifyMainWindow
    WinGet, maximized, MinMax, ahk_class SpotifyMainWindow
    if(maximized)
    {
        SPOTIFY_VOLUME_Y_LOCATION := SPOTIFY_Y_AXIS - (SPOTIFY_VOLUME_Y_OFFSET + 15)
        SPOTIFY_VOLUME_X_LOCATION := SPOTIFY_X_AXIS - (SPOTIFY_VOLUME_X_OFFSET + 15)
    }
    else
    {
        SPOTIFY_VOLUME_Y_LOCATION := SPOTIFY_Y_AXIS - SPOTIFY_VOLUME_Y_OFFSET
        SPOTIFY_VOLUME_X_LOCATION := SPOTIFY_X_AXIS - SPOTIFY_VOLUME_X_OFFSET
    }
}