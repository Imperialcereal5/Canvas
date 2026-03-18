extends ColorRect
@onready var _2d_cam: Camera2D = $"../sideOn/2dCam"
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var side_on: Node2D = $"../sideOn"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color = Color(0, 0, 0, 0)
	

func fadeIn():
	var tween = create_tween()
	await tween.tween_property(self, "color", Color(0, 0, 0, 1), 1.0).finished
func fadeOut():
	var tween = create_tween()
	await tween.tween_property(self, "color", Color(0, 0, 0, 0), 2.0).finished
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = (_2d_cam.position + Vector2(-1000, -1000) if _2d_cam.is_current() else camera_2d.position + Vector2(-1500, -1000)) 
