
-- RequestScriptAudioBank will be used to load the .awc container that holds all the sounds. Follow the folder structure starting from the resource audiodirectory/custom_sounds

-- The audioRef will be `special_soundset` because we called our soundset that
-- You can use any sound that you put inside your soundset.

RegisterCommand('testsound', function (source, args, raw)
    while not RequestScriptAudioBank('audiodirectory/custom_sounds', false) do Wait(0) end
    print('Audio bank loaded')
    local soundId = GetSoundId()
    PlaySoundFrontend(soundId, 'blowoff', 'special_soundset', true)
    ReleaseSoundId(soundId)
    ReleaseNamedScriptAudioBank('audiodirectory/custom_sounds')
end, false)
