extends CharacterBody2D

@onready var animation = $AnimatedSprite2D
@onready var kitdy = get_tree().get_root().find_child("Kitdy", true, false)
@onready var hurt_timer = $hurt_timer

@export var speed: = 200.0
@export var max_health: = 1
@export var min_health: = 0
@export var damage_to_deal: = 1

var is_hurt: = false
var health: = max_health
var dead: = false

func _ready():
    add_to_group("enemy")

func _physics_process(_delta: float) -> void :
    if is_hurt:
        return
    var direction = global_position.direction_to(kitdy.global_position)
    move(direction, speed)
    move_and_slide()

func move(dir: Vector2, speed):
    velocity = dir.normalized() * speed
    anim()
    update_flip(dir.x)

func update_flip(dir_x):
    animation.flip_h = dir_x < 0

func anim():
    if !is_hurt:
        animation.play("walk")

func take_damage(amount: int):
    health -= amount
    is_hurt = true
    animation.play("hurt")
    hurt_timer.start()
    if health <= 0:
        dead = true
        queue_free()

func _on_hurt_timer_timeout():
    is_hurt = false
    animation.play("walk")

func _on_body_entered(body: Node2D) -> void :
    if body.is_in_group("kitdy"):
        if body.has_method("take_damage"):
            body.take_damage(damage_to_deal)
        queue_free()

func _on_avoid_body_entered(body: Node2D) -> void :
    if body.is_in_group("enemy"):
        pass
