extends Node2D


func _ready() -> void :
    pass


func _on_levels_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/levels_menu.tscn")


func _on_quit_pressed() -> void :
    get_tree().quit()


func _on_blep_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/blep_menu.tscn")


func _on_settings_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/options_menu.tscn")


func _on_start_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/tay_splash_screen.tscn")
