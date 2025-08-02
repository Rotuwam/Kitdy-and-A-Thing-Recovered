extends ProgressBar


var parent
var max_health
var min_health

func _ready() -> void :
    parent = get_parent()
    max_health = parent.max_health
    min_health = parent.min_health

func _process(_delta: float) -> void :
    self.value = parent.health
    if parent.health == min_value:
        self.visible = false
    else:
        self.visible = true
