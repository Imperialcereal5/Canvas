extends Control
@onready var side_on: Node2D = $".."
@onready var _2d_cam: Camera2D = $"../2dCam"
var offset

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	offset = position-_2d_cam.position
	hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = _2d_cam.position+offset
	if Input.is_action_just_pressed("inventory") &&side_on.visible:
		if get_child(1).visible && visible:
			hide()
		else:
			show()
			get_child(2).hide()
			get_child(1).show()
	if Input.is_action_just_pressed("settings") &&side_on.visible:
		if get_child(2).visible && visible:
			hide()
		else:
			show()
			get_child(1).hide()
			get_child(2).show()
			
		
