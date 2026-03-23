extends Panel
@onready var default: Button = $diePickWin/GridContainer/default
var selectedDieSlot = 0
var selectedSpellSlot = 0
var unlockedDice = []:
	set(unlockedDice):
		for i in unlockedDice:	
			var n:Button = default.duplicate()
			var text:Label = n.get_child(0).get_child(0)
			n.name = i.name
			n.get_child(1).texture = i.sprite
			text.text = i.desc
			n.die = i
			var childNames = []
			for j in default.get_parent().get_children():
				childNames.append(j.name)
			if i.name not in childNames:
				default.get_parent().add_child(n)
var unlockedSpells = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
