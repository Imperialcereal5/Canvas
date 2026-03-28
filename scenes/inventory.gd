extends Panel
@onready var none: Button = $spellPickWin/ScrollContainer/VBoxContainer/none
@onready var default: Button = $diePickWin/GridContainer/none
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
			n.theme = i.style
			n.linkDie()
			var childNames = []
			for j in default.get_parent().get_children():
				childNames.append(j.name)
			if i.name not in childNames:
				default.get_parent().add_child(n)
var unlockedSpells = []:
	set(unlockedSpells):
		for i in unlockedSpells:
			var n:Button = none.duplicate()
			var text:Label = n.get_child(0).get_child(0)
			n.name = i._name
			n.text = i._name
			n.theme = i.style
			n.get_child(0).get_child(0).text = i.desc
			var childNames = []
			n.spell = i
			n.linkSpell(i)
			for j in none.get_parent().get_children():
				childNames.append(j.name)
			if i._name not in childNames:
				none.get_parent().add_child(n)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	none.linkSpell(none.spell)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
