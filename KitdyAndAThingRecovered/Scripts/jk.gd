extends CharacterBody2D

@onready var animation = $AnimatedSprite2D
@onready var kitdy = get_tree().get_root().find_child("Kitdy", true, false)
@onready var hurt_timer = $hurt_timer

@export var jk_bullets: PackedScene
@export var max_health: = 50
@export var min_health: = 0

var health: = max_health
var dead: = false
var is_hurt: = false


func _ready() -> void :
    if !is_hurt:
        animation.play("standing")
    add_to_group("jk")
    $shoot_speed.start()

func _physics_process(_delta: float) -> void :

    pass

func shoot():

    var bullet = jk_bullets.instantiate()


    bullet.pos = global_position


    var direction = global_position.direction_to(kitdy.global_position)
    bullet.dir = direction.angle()


    bullet.rota = bullet.dir
    get_tree().current_scene.add_child(bullet)

func _on_shoot_speed_timeout() -> void :
    shoot()

func take_damage(amount: int):
    health -= amount
    is_hurt = true
    animation.play("hurt")
    hurt_timer.start()
    if health <= 0:
        dead = true
        queue_free()
        win()

func _on_hurt_timer_timeout():
    is_hurt = false
    animation.play("standing")

func win():
    print("You won!")
    if Global.game_controller.current_game_scene:
            Global.game_controller.current_game_scene.queue_free()
            Global.game_controller.current_game_scene = null
    Global.game_controller.change_current_menu("res://Scenes/win_screen.tscn")
