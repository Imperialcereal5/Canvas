extends Button
@onready var lock: Sprite2D = $lock
var locked = false
const LOCKED = preload("uid://cqn8pfil0jm5n")
const UNLOCKED = preload("uid://b0ldtb52o14t2")

func cycleIcon():
	if locked:
		locked = false
		lock.texture = UNLOCKED
	else:
		lock.texture = LOCKED
		locked = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	pressed.connect(cycleIcon)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
