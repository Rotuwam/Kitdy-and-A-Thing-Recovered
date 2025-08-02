extends CharacterBody2D

signal health_changed

@export var speed: float = 300.0
@export var sprint_speed: float = 600.0

@onready var kitdy_walking_audio = $AudioStreamPlayer2D_walk
@onready var kitdy_take_damage_audio = $AudioStreamPlayer2D_oof
@onready var hurt_timer = $hurt_timer
@onready var animation = $AnimatedSprite2D

var current_dir: String = "S"
var flip_h: bool = false


var enemy_inattack_range = false
var max_health: = 10
var min_health: = 0
var player_alive = true
var health: = max_health
var is_hurt: = false

var damage_cooldown_time: = 2.5
var damage_cooldown_timer: = 0.0

func _ready() -> void :
    max_health


func _physics_process(_delta: float) -> void :
    var input_vector = Vector2.ZERO

    input_vector.x = int(Input.is_action_pressed("R")) - int(Input.is_action_pressed("L"))
    input_vector.y = int(Input.is_action_pressed("D")) - int(Input.is_action_pressed("U"))

    if input_vector != Vector2.ZERO:
        input_vector = input_vector.normalized()


        var current_speed = sprint_speed if Input.is_action_pressed("SHIFT") else speed

        velocity = input_vector * current_speed
        if !kitdy_walking_audio.playing:
            kitdy_walking_audio.play()
        update_direction(input_vector)
        play_anim(true)
    else:
        velocity = Vector2.ZERO
        kitdy_walking_audio.stop()
        play_anim(false)

    if health <= 0:
        player_alive = false


        if Global.game_controller.current_game_scene:
            Global.game_controller.current_game_scene.queue_free()
            Global.game_controller.current_game_scene = null


        Global.game_controller.change_current_menu("res://Scenes/death_screen.tscn")





    if damage_cooldown_timer > 0.0:
        damage_cooldown_timer -= _delta


    move_and_slide()


func update_direction(dir: Vector2) -> void :
    flip_h = false


    if dir.x < -0.5 and dir.y < -0.5:
        current_dir = "NE"
        flip_h = true
    elif dir.x > 0.5 and dir.y < -0.5:
        current_dir = "NE"
    elif dir.x < -0.5 and dir.y > 0.5:
        current_dir = "SE"
        flip_h = true
    elif dir.x > 0.5 and dir.y > 0.5:
        current_dir = "SE"
    elif dir.x < -0.5:
        current_dir = "E"
        flip_h = true
    elif dir.x > 0.5:
        current_dir = "E"
    elif dir.y < -0.5:
        current_dir = "N"
    elif dir.y > 0.5:
        current_dir = "S"

func play_anim(is_moving: bool) -> void :
    if !is_hurt:
        var anim = $AnimatedSprite2D
        var action = "_walk" if is_moving else "_idle"


        if is_moving:
            anim.speed_scale = 1.5 if Input.is_action_pressed("SHIFT") else 1.0
        else:
            anim.speed_scale = 1.0

        anim.play(current_dir + action)
        anim.flip_h = flip_h


func _on_kitdy_hitbox_body_entered(body: Node2D) -> void :
    if body.is_in_group("enemy"):
        take_damage(body.damage_to_deal)

func enemy_attack(enemy: Node2D):
    if enemy_inattack_range and enemy.has_method("damage_to_deal"):
        health -= enemy.damage_to_deal


func take_damage(amount: int):
    health -= amount
    is_hurt = true
    animation.play(current_dir + "_hurt")
    hurt_timer.start()
    health_changed.emit(health)
    kitdy_take_damage_audio.play()

    print("Player health:", health)

func _on_hurt_timer_timeout() -> void :
    is_hurt = false

    var input_vector = Vector2(
        int(Input.is_action_pressed("R")) - int(Input.is_action_pressed("L")), 
        int(Input.is_action_pressed("D")) - int(Input.is_action_pressed("U"))
    )

    if input_vector.length() > 0:
        play_anim(true)
    else:
        play_anim(false)
