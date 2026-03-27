extends Button
@onready var grid_container: GridContainer = $"../../../../GridContainer"
@onready var inventory: Panel = $"../../../.."
var spell

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(get_child(0).show)
	mouse_exited.connect(get_child(0).hide)
func linkSpell():
	pressed.connect(func(): grid_container.get_child(inventory.selectedSpellSlot).activeSpell = spell)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
