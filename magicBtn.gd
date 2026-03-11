extends Button
@onready var panel: Panel = $"../Panel"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _button_pressed():
	print("button pressed")
	panel.show()
	hide()
