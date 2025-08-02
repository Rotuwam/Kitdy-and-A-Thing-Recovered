extends CanvasLayer

@onready var pause = $"."

var paused = false

func _ready() -> void :
    pass



func _process(delta: float) -> void :
    pass


func _on_blep_pressed() -> void :
    _unpause_and_reset()
    if Global.game_controller.current_game_scene:
            Global.game_controller.current_game_scene.queue_free()
            Global.game_controller.current_game_scene = null
    if Global.game_controller.current_menu:
            Global.game_controller.current_menu.queue_free()
            Global.game_controller.current_menu = null
    Global.game_controller.change_current_menu("res://Scenes/blep_menu.tscn")


func _on_levels_pressed() -> void :
    _unpause_and_reset()
    if Global.game_controller.current_game_scene:
            Global.game_controller.current_game_scene.queue_free()
            Global.game_controller.current_game_scene = null
    if Global.game_controller.current_menu:
            Global.game_controller.current_menu.queue_free()
            Global.game_controller.current_menu = null
    Global.game_controller.change_current_menu("res://Scenes/levels_menu.tscn")



func _on_settings_pressed() -> void :
    _unpause_and_reset()
    if Global.game_controller.current_game_scene:
            Global.game_controller.current_game_scene.queue_free()
            Global.game_controller.current_game_scene = null
    if Global.game_controller.current_menu:
            Global.game_controller.current_menu.queue_free()
            Global.game_controller.current_menu = null
    Global.game_controller.change_current_menu("res://Scenes/options_menu.tscn")


func _on_main_menu_pressed() -> void :
    _unpause_and_reset()
    if Global.game_controller.current_game_scene:
            Global.game_controller.current_game_scene.queue_free()
            Global.game_controller.current_game_scene = null
    if Global.game_controller.current_menu:
            Global.game_controller.current_menu.queue_free()
            Global.game_controller.current_menu = null
    Global.game_controller.change_current_menu("res://Scenes/main_menu.tscn")


func _on_quit_pressed() -> void :
    pause.hide()
    Engine.time_scale = 1
    AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX_GAME"), false)

func _unpause_and_reset():
    Engine.time_scale = 1
    AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX_GAME"), false)
    paused = false
    pause.hide()
