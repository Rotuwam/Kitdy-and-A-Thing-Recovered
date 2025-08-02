class_name GameController extends Node2D

@export var main_game: Node2D
@export var ui_main: Control

var current_game_scene
var current_menu
@onready var transition_controller = $transition_controller

func _ready() -> void :
    Global.game_controller = self
    current_menu = $ui_main / splash_screen_manager


func change_current_game_scene(new_scene: String, delete: bool = true, keep_running: bool = false, transition: bool = true, transition_in: String = "fade_in", transition_out: String = "fade_out", seconds: float = 1.0) -> void :
    if transition:
        transition_controller.transition(transition_out, seconds)
        await transition_controller.animation_player.animation_finished
    if current_game_scene != null:
        if delete:
            current_game_scene.queue_free()
        elif keep_running:
            current_game_scene.visible = false
        else:
            main_game.remove_child(current_game_scene)
            ui_main.remove_child(current_menu)
    var new = load(new_scene).instantiate()
    main_game.add_child(new)
    current_game_scene = new
    transition_controller.transition(transition_in, seconds)
    AudioManager.play_music_level()



func change_current_menu(new_scene: String, delete: bool = true, keep_running: bool = false, transition: bool = true, transition_in: String = "fade_in", transition_out: String = "fade_out", seconds: float = 1.0) -> void :
    if transition:
        transition_controller.transition(transition_out, seconds)
        await transition_controller.animation_player.animation_finished
    if current_menu != null:
        if delete:
            current_menu.queue_free()
        elif keep_running:
            current_menu.visible = false
        else:
            ui_main.remove_child(current_menu)
            main_game.remove_child(current_game_scene)
    var new = load(new_scene).instantiate()
    ui_main.add_child(new)
    current_menu = new
    transition_controller.transition(transition_in, seconds)
    AudioManager.play_music_menu()
