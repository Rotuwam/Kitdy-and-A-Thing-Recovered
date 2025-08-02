extends AudioStreamPlayer

@export var bg_music_player = AudioStreamPlayer

const levels_music = preload("res://Assests/Audio/Kitdy game music updated drums no awiwiw.wav")
const menu_music = preload("res://Assests/Audio/Kitdy game music paino only .wav")



func _play_music(music: AudioStream, volume = -20.0):
    if stream == music:
        return

    stream = music
    volume_db = volume
    play()

func play_music_menu():
    _play_music(menu_music)

func play_music_level():
    _play_music(levels_music)

func _ready() -> void :
    pass


func _process(_delta: float) -> void :
    update_volume()

func update_volume():
    var bg_music_index = AudioServer.get_bus_index("Background")
    var all_music_index = AudioServer.get_bus_index("Master")
    var sfx_music_index = AudioServer.get_bus_index("SFX")


    AudioServer.set_bus_volume_db(bg_music_index, AudioGlobal.bg_music_volume)
    AudioServer.set_bus_volume_db(sfx_music_index, AudioGlobal.sfx_music_volume)
    AudioServer.set_bus_volume_db(all_music_index, AudioGlobal.all_music_volume)
