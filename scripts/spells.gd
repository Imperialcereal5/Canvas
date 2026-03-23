extends Panel
@onready var enemy_stats: Panel = $"../../EnemyStats"
@onready var spell_1: Button = $spell1
var tradTh = preload("uid://bd1tw2mejy8x2")
var debugTh = preload("uid://dn86y02omkr6x")
@onready var player_stats: Panel = $"../../PlayerStats"
class spell:
	var cost = 0
	var body = print.bind("debug spell")
	var style = "digital"
	var _name = "debug"
	func _init(c, b, s, n):
		cost = c
		body = b
		style = s
		_name = n
	func cast(user, target):
		body.call(user, target)
			
func blastBody(_user, _target):
	await _target.updateHP(-6)
func comboBody(_user, _target):
	_user.combo2 += 1
func healBody(_user, _target):
	_user.updateHP(12)
func manaStealBody(_user, _target):
	_user.updateMP(15)
	_target.updateMP(-15)
func smiteBody(_user, _target):
	_target.updateHP(-18)
func poisonBody(_user, _target):
	_target.poison += 3
var spellButtons = ["Blast|10", "Combo|20", "Heal|25", "Mana steal|10", "Smite|50",
"Poison|10"]:
	set(spellButtons):
		for i in range(len(spellButtons)):
			var b:Button = get_node("spell"+str(i+1))
			b.pressed.connect(player_stats.act.bind(spells[spellButtons[i]]))
			b.text = spellButtons[i]
			b.theme = spells[spellButtons[i]].style
var spells = {
	"Blast|10": spell.new(10, blastBody, tradTh, "blast"),
	"Combo|20": spell.new(20, comboBody, tradTh, "combo"),
	"Heal|25": spell.new(25, healBody, tradTh, "heal"),
	"Mana steal|10": spell.new(10, manaStealBody, tradTh, "blast"),
	"Smite|50": spell.new(10, smiteBody, tradTh, "blast"),
	"Poison|10": spell.new(10, poisonBody, debugTh, "blast")
}
var costs = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in spells:
		costs[spells[i]] = spells[i].cost
	for i in range(len(spellButtons)):
		var b = get_node("spell"+str(i+1))
		b.pressed.connect(player_stats.act.bind(spells[spellButtons[i]]))
		b.text = spellButtons[i]
		b.theme = spells[spellButtons[i]].style
		print("set up button "+ str(i))
		print("used theme" + str(spells[spellButtons[i]].style))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
