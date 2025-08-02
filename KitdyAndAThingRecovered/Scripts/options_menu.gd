extends Node2D


@onready var option_button: OptionButton = $Control / MarginContainer / NinePatchRect / VBoxContainer / HBoxContainer / OptionButton as OptionButton
@onready var option_button_r: OptionButton = $Control / MarginContainer / NinePatchRect / VBoxContainer / HBoxContainer2 / OptionButtonR as OptionButton



const WINDOW_MODE_ARRAY: Array[String] = [
    "Full Screen", 
    "Window Mode", 
    "Borderless Window Mode", 
    "Borderless Full Screen"
]

const RESOLUTION_DICTIONARY: Dictionary = {
    "1280 x 720": Vector2i(1280, 720), 
    "1920 x 1080": Vector2i(1920, 1080), 
    "2560 x 1440": Vector2i(2560, 1440), 
    "3840 x 2160": Vector2i(3840, 2160)
}


func _ready() -> void :
    add_window_mode_items()
    add_resolution_items()
    option_button.item_selected.connect(on_window_mode_selected)
    option_button_r.item_selected.connect(on_resolution_selected)

func _process(delta: float) -> void :
    volume_update()

func add_window_mode_items() -> void :
    for window_mode in WINDOW_MODE_ARRAY:
        option_button.add_item(window_mode)

func add_resolution_items() -> void :
    for resolution_size_text in RESOLUTION_DICTIONARY:
        option_button_r.add_item(resolution_size_text)

func on_window_mode_selected(index: int) -> void :
    match index:
        0:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
            DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
        1:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
            DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
        2:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
            DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
        3:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
            DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

func on_resolution_selected(index: int) -> void :
    DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])

func volume_update():
    var all_music_volume = $Control / MarginContainer / NinePatchRect / VBoxContainer2 / HBoxContainer / HSlider_all
    var sfx_music_volume = $Control / MarginContainer / NinePatchRect / VBoxContainer2 / HBoxContainer2 / HSlider_sfx
    var bg_music_volume = $Control / MarginContainer / NinePatchRect / VBoxContainer2 / HBoxContainer3 / HSlider_bg
    AudioGlobal.all_music_volume = all_music_volume.value
    AudioGlobal.sfx_music_volume = sfx_music_volume.value
    AudioGlobal.bg_music_volume = bg_music_volume.value


func _on_blep_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/blep_menu.tscn")


func _on_quit_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/main_menu.tscn")
