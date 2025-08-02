extends Node2D


func _on_level_1_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/tay_splash_screen.tscn")


func _on_level_2_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/gopissgirl_splash_screen.tscn")


func _on_level_3_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/sink_splash_screen.tscn")


func _on_level_4_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/joekeery_splash_screen.tscn")


func _on_blep_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/blep_menu.tscn")


func _on_quit_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/main_menu.tscn")
