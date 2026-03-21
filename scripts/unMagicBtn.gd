extends Button
var magicBtn
var panel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel = get_parent()
	var root = panel.get_parent()
	magicBtn = root.get_node("Magic")
	pressed.connect(_button_pressed)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _button_pressed():
	print("button pressed")
	magicBtn.show()
	panel.hide()
