extends Panel
@onready var dieSprite: Sprite2D = $Sprite2D
@onready var control: Control = $"../.."
@onready var dieText: Label = $Label
var active = "default"

func spinDie(d: int):
	var tween = create_tween()
	var n = control.dice[active].roll()
	await tween.tween_property(dieSprite, "rotation_degrees", 360.0, 1.0).finished
	dieText.text = str(n)
	dieSprite.rotation_degrees = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
