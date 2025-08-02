extends Node2D




func _on_animation_player_animation_finished(_anim_name: StringName) -> void :
    Global.game_controller.change_current_menu("res://Scenes/main_menu.tscn")
