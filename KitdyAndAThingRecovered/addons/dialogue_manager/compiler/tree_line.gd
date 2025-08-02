
class_name DMTreeLine extends RefCounted



var line_number: int = 0



var parent: WeakRef

var id: String

var type: String = ""

var is_random: bool = false

var indent: int = 0

var text: String = ""

var children: Array[DMTreeLine] = []

var notes: String = ""

var is_nested_dialogue: bool = false


func _init(initial_id: String) -> void :
    id = initial_id


func _to_string() -> String:
    var tabs = []
    tabs.resize(indent)
    tabs.fill("\t")
    tabs = "".join(tabs)

    return tabs.join([tabs + "{\n", 
        "\tid: %s\n" % [id], 
        "\ttype: %s\n" % [type], 
        "\tis_random: %s\n" % ["true" if is_random else "false"], 
        "\ttext: %s\n" % [text], 
        "\tnotes: %s\n" % [notes], 
        "\tchildren: []\n" if children.size() == 0 else "\tchildren: [\n" + ",\n".join(children.map( func(child): return str(child))) + "]\n", 
    "}"])
