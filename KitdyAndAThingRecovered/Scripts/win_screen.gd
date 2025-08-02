extends Control



func _ready() -> void :
    pass



func _process(delta: float) -> void :
    pass


func _on_lvl_1_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/tay_splash_screen.tscn")

func _on_lvl_2_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/gopissgirl_splash_screen.tscn")


func _on_lvl_3_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/sink_splash_screen.tscn")


func _on_lvl_4_pressed() -> void :
    Global.game_controller.change_current_menu("res://Scenes/joekeery_splash_screen.tscn")
