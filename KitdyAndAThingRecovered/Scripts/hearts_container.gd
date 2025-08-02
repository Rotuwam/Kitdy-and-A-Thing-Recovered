extends HBoxContainer

@onready var heart_gui_class = preload("res://Scenes/heart_gui.tscn")


func set_max_hearts(max_no: int):
    for i in range(max_no):
        var heart = heart_gui_class.instantiate()
        add_child(heart)


func update_heart(current_health: int):
    var hearts = get_children()

    for i in range(current_health):
        hearts[i].update(true)

    for i in range(current_health, hearts.size()):
        hearts[i].update(false)
