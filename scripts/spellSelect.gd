extends Button
class_name spell_select
@onready var spell_pick_win: Panel = $"../../spellPickWin"
@onready var panel: Panel = $"../../../../Combat/buttons/Panel"
@onready var inventory = $"../.."
var num = 0
var activeSpell:
	set(activeSpell):
		var n:RichTextLabel = get_child(0).get_child(0)
		n.text = activeSpell.desc
		if activeSpell._name != "none":
			text = activeSpell._name
			theme = activeSpell.style
		else:
			theme = inventory.theme
			text = "<none>"
		var temp = panel.spellButtons
		temp[num] = activeSpell._name
		panel.spellButtons = temp
		
func toggle():
	if spell_pick_win.visible && inventory.selectedSpellSlot == num:
		spell_pick_win.hide()
	else:
		spell_pick_win.show()
		inventory.selectedSpellSlot = num

func _ready():
	mouse_entered.connect(get_child(0).show)
	mouse_entered.connect(get_child(0).hide)
	pressed.connect(toggle)
