extends Camera2D
@onready var combat: Control = $"../../Overworld/sideOn/Combat"
@onready var side_on: Node2D = $"../../Overworld/sideOn"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	combat.show()
	side_on.show()
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
