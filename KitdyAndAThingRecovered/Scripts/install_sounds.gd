extends Node

@export var root_path: NodePath


@onready var sounds = {
    &"UI_Hover": AudioStreamPlayer.new(), 
    &"UI_Click": AudioStreamPlayer.new(), 
    }

func _ready() -> void :
    assert (root_path != null, "Empty root path for Interface Sounds!")


    for i in sounds.keys():
        sounds[i].stream = load("res://Assests/Audio/" + str(i) + ".ogg")

        sounds[i].bus = &"SFX"
        sounds[i].volume_db = -10.0

        add_child(sounds[i])


    install_sounds(get_node(root_path))


func install_sounds(node: Node) -> void :
    for i in node.get_children():
        if i is Button:
            i.mouse_entered.connect(ui_sfx_play.bind(&"UI_Hover"))
            i.pressed.connect(ui_sfx_play.bind(&"UI_Click"))
        elif i is OptionButton:
            i.mouse_entered.connect(ui_sfx_play.bind(&"UI_Hover"))
            i.pressed.connect(ui_sfx_play.bind(&"UI_Click"))
        elif i is TextureButton:
            i.mouse_entered.connect(ui_sfx_play.bind(&"UI_Hover"))
            i.pressed.connect(ui_sfx_play.bind(&"UI_Click"))
        elif i is TabContainer:
            i.tab_hovered.connect(ui_sfx_play.bind(&"UI_Hover"))
            i.tab_clicked.connect(ui_sfx_play.bind(&"UI_Hover"))
        install_sounds(i)


func ui_sfx_play(sound: String) -> void :

    sounds[sound].play()
