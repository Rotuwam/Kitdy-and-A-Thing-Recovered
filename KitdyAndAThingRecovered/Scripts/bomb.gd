extends Area2D

var pos: Vector2
var rota: float
var dir: float
var speed: = 400
var velocity: = Vector2.ZERO

@export var damage_to_deal: = 1


func _ready() -> void :
    global_position = pos
    global_rotation = rota
    await get_tree().create_timer(10.0).timeout
    queue_free()

func _physics_process(delta: float) -> void :
    velocity = Vector2(speed, 0).rotated(dir)
    global_position += velocity * delta



func _on_body_entered(body: Node2D) -> void :
    if body.is_in_group("enemy") or body.is_in_group("jk"):
        if body.has_method("take_damage"):
            body.take_damage(damage_to_deal)
        queue_free()
