extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(get_parent().get_child(0).show)
	mouse_exited.connect(get_parent().get_child(0).hide)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
