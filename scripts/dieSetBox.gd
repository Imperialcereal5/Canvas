extends Button
@onready var inventory: Panel = $"../../.."
@onready var v_box_container: VBoxContainer = $"../../../VBoxContainer"
var die

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(func(): v_box_container.get_child(inventory.selectedDieSlot).activeDie = die)
	mouse_entered.connect(get_child(0).show)
	mouse_exited.connect(get_child(0).hide)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
