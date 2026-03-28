extends Button
@onready var grid_container: GridContainer = $"../../../../GridContainer"
@onready var inventory: Panel = $"../../../.."
@onready var panel:Panel = $"../../../../../../Combat/buttons/Panel"
@onready var spell = panel.spells["none"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(get_child(0).show)
	mouse_exited.connect(get_child(0).hide)
func linkSpell(x):
	pressed.connect((func(y): grid_container.get_child(inventory.selectedSpellSlot).activeSpell = y).bind(x))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
