extends Button
@onready var dieSprite: Sprite2D = $"Sprite2D"
@onready var dice_rect: ColorRect = $"../DiceRect"
@onready var dice: Panel = $"../DiceRect/Dice"
@onready var diceContainer: HBoxContainer = $"../DiceRect/Dice/HBoxContainer"
@onready var control: Control = $"../.."
var active = "default"

func showPanel():
	dice_rect.show()
	for i in diceContainer.get_children():
		if i.get_child(0).text != active:
			i.disabled = true
	await dice.buttonPressed
		
func spinDie(d: int):
	disabled = true
	var tween = create_tween()
	var n = control.dice[active].roll()
	await tween.tween_property(dieSprite, "rotation_degrees", 360.0, 1.0).finished
	text = str(n)
	disabled = false
	dieSprite.rotation_degrees = 0
	return n
# Called when the node enters the scene tree for the first time.
	
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
