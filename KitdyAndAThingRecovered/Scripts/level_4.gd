extends Node2D

@onready var heart_container = get_tree().get_root().find_child("Hearts_container", true, false)
@onready var kitdy = get_tree().get_root().find_child("Kitdy", true, false)
@onready var pause = $pause_menu

var paused = false

func _ready() -> void :
    heart_container.set_max_hearts(kitdy.max_health)
    heart_container.update_heart(kitdy.health)
    kitdy.health_changed.connect(heart_container.update_heart)

func _process(_delta: float) -> void :
    if Input.is_action_just_pressed("pause"):
        pause_menu()



func win():
    print("You won!")
    if Global.game_controller.current_game_scene:
            Global.game_controller.current_game_scene.queue_free()
            Global.game_controller.current_game_scene = null
    Global.game_controller.change_current_menu("res://Scenes/win_screen.tscn")

func pause_menu():
    if paused:
        _unpause_and_reset()
    else:
        pause.show()
        Engine.time_scale = 0
        AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX_GAME"), true)
    paused = !paused


func _on_pause_pressed() -> void :
    pause_menu()

func _unpause_and_reset():
    Engine.time_scale = 1
    AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX_GAME"), false)
    paused = false
    pause.hide()
