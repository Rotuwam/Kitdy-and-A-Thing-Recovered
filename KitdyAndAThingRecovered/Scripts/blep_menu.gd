extends Node2D



func _ready() -> void :
    pass



func _process(_delta: float) -> void :
    pass


func _on_about_game_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/about_page.tscn")


func _on_kitdy_links_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/kitdy_links_screen.tscn")


func _on_cast_list_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/natentay_links_screen.tscn")


func _on_credits_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/credits.tscn")


func _on_quit_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/main_menu.tscn")
