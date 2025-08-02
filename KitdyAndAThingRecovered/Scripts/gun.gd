extends Area2D

@onready var dingle_sound = $AudioStreamPlayer2D_shoot

var bomb_path = preload("res://Scenes/bomb.tscn")

func _physics_process(_delta: float) -> void :
    look_at(get_global_mouse_position())
    if Input.is_action_just_pressed("L Mouse"):
        fire()



func fire():
    var bomb = bomb_path.instantiate()
    bomb.dir = rotation
    bomb.pos = $".".global_position
    bomb.rota = global_rotation
    get_tree().current_scene.add_child(bomb)
    dingle_sound.play()
