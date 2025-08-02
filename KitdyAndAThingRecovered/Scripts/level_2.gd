extends Node2D

var current_wave: int

@export var nate_scene: PackedScene
@export var gopissgirl_scene: PackedScene
@export var sink_scene: PackedScene
@export var max_waves: int = 3

@onready var heart_container = $CanvasLayer / Hearts_container
@onready var kitdy = $Kitdy
@onready var pause = $pause_menu
var starting_node: int
var current_node: int
var wave_spawn_ended
var paused = false

func _ready() -> void :
    heart_container.set_max_hearts(kitdy.max_health)
    heart_container.update_heart(kitdy.health)
    kitdy.health_changed.connect(heart_container.update_heart)
    current_wave = 0
    Global.current_wave = current_wave
    starting_node = get_child_count()
    current_node = get_child_count()
    position_to_next_wave()

func position_to_next_wave():
    if current_node == starting_node:
        if current_wave >= max_waves:
            print("All waves complete.")
            return
        if current_wave != 0:
            Global.moving_to_next_wave = true
        wave_spawn_ended = false
        current_wave += 1
        Global.current_wave = current_wave
        prepare_spawn("enemy", 10.0, 4.0)
        print("Spawning wave:", current_wave)
        if current_wave >= max_waves:
            print("All waves complete.")
            Global.waves_done = true
            return




func prepare_spawn(type, multiplier, mob_spawns):
        var mob_amount = float(current_wave) * multiplier
        var mob_wait_time: float = 5.0
        print("mob amount", mob_amount)
        var mob_spawn_rounds = mob_amount / mob_spawns
        spawn_type(type, mob_spawn_rounds, mob_wait_time)

func spawn_type(type, mob_spawn_rounds, mob_wait_time):
    if type == "enemy":
        var enemy_spawn = $spawn_pointG
        var enemy2_spawn = $spawn_pointN
        var enemy3_spawn = $spawn_pointS
        if mob_spawn_rounds >= 1:
            for i in mob_spawn_rounds:
                var enemy = nate_scene.instantiate()
                enemy.global_position = enemy_spawn.global_position
                var enemy2 = nate_scene.instantiate()
                enemy2.global_position = enemy2_spawn.global_position
                var enemy3 = gopissgirl_scene.instantiate()
                enemy3.global_position = enemy3_spawn.global_position
                add_child(enemy)
                add_child(enemy2)
                add_child(enemy3)
                mob_spawn_rounds -= 1
                await get_tree().create_timer(mob_wait_time).timeout
        wave_spawn_ended = true
        call_deferred("position_to_next_wave")


func _process(_delta: float) -> void :
    current_node = get_child_count()
    if Input.is_action_just_pressed("pause"):
        pause_menu()

    if wave_spawn_ended:

        if current_wave >= max_waves and current_node == starting_node:
            win()
        else:
            position_to_next_wave()

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
