extends Node2D



func _ready() -> void :
    pass



func _process(_delta: float) -> void :
    pass


func _on_quit_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/blep_menu.tscn")
