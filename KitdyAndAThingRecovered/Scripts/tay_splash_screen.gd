extends Control



@onready var dismiss_timer = $dismiss_timer



func _ready():
    get_viewport().set_input_as_handled()
    dismiss_timer.start()

func _unhandled_input(event):
    if event.is_action_pressed("space"):
        Global.game_controller.change_current_menu("res://Scenes/nate_splash_screen.tscn")




func _on_blep_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/blep_menu.tscn")
