extends Button
class_name dieSelect
@onready var inventory: Panel = $"../.."
@onready var combat: Control = $"../../../../Combat"
@onready var die_pick_win: Panel = $"../../diePickWin"
var activeDie:
	set(activeDie):
		get_child(1).texture = activeDie.sprite
		
var num = 0 

func _ready() -> void:
	var descBox = get_child(0)
	mouse_entered.connect(descBox.show)
	mouse_exited.connect(descBox.hide)
	pressed.connect(toggle)
func toggle():
	if die_pick_win.visible && inventory.selectedDieSlot == num:
		die_pick_win.hide()
	else:
		die_pick_win.show()
		inventory.selectedDieSlot = num


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
