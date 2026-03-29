extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color = Color(0,0,0,0)
func overlay(clr:Color, hold:int=0.1):
	color = Color(clr, 0)
	var tween = create_tween()
	await tween.tween_property(self, "color", Color(color, 1), 0.1).finished
	await get_tree().create_timer(hold).timeout
	tween = create_tween()
	await tween.tween_property(self, "color", Color(color, 0), 0.1).finished

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
