extends Control

@onready var dismiss_timer = $dismiss_timer



func _ready():
    get_viewport().set_input_as_handled()
    dismiss_timer.start()

func _unhandled_input(event):
    if event.is_action_pressed("space"):
        if Global.game_controller.current_game_scene:
                Global.game_controller.current_game_scene.queue_free()
                Global.game_controller.current_game_scene = null
        if Global.game_controller.current_menu:
                Global.game_controller.current_menu.queue_free()
                Global.game_controller.current_menu = null
        Global.game_controller.change_current_game_scene("res://Scenes/level_4.tscn")




func _on_blep_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/blep_menu.tscn")
