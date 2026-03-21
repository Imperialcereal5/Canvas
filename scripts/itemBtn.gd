extends Button
@onready var items: Panel = $"../../.."
var item = null:
	set(item):
		pressed.connect(item.use)
		get_child(0).get_child(0).text = item.desc
		text = item.name

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(get_child(0).show)
	mouse_exited.connect(get_child(0).hide)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
