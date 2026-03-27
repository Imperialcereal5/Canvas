extends Panel
@onready var enemy_stats: Panel = $"../../EnemyStats"
@onready var spell_1: Button = $spell1
var tradTh = preload("uid://bd1tw2mejy8x2")
var debugTh = preload("uid://dn86y02omkr6x")
@onready var player_stats: Panel = $"../../PlayerStats"
class spell:
	var cost = 0
	var body = print.bind("debug spell")
	var style = null
	var _name = "debug"
	var desc = "debug spell"
	func _init(c, b, s, n, d):
		cost = c
		body = b
		style = s
		_name = n
		desc = d
	func cast(user, target):
		body.call(user, target)
			
func impale(_user, _target):
	await _target.updateHP(-6)
func bind(_user, _target):
	_target.weakened += 3
func erase(_user, _target):
	_target.stunned += 5
func feedbackLoop(_user, _target):
	_user.combo2 += 1
func tasty(_user, _target):
	_user.updateHP(12)
func manaSteal(_user, _target):
	_user.updateMP(20)
	_target.updateMP(-20)
func toCinders(_user, _target):
	_target.updateHP(_user.dmg*-5)
func poisonBody(_user, _target):
	_target.poison += 3
func disfigure(_user, _target):
	_target.poison += 3
	_target.stunned += 1
	_target.vulnerable += 3
	_target.weakened += 3
	_user.combo2 += 1
	_user.combo1 += 2
func zap(_user, _target):
	_target.stunned += 1
	await _target.updateHP(_user.dmg*-0.8)
func daemon(_user, _target):
	_target.vulnerable += 3
func rock(_user, _target):
	await _target.updateHP(_user.dmg*-2)
var spellButtons = ["impale", "none", "none", "none", "none", "none"]:
	set(spellButtons):
		for i in range(len(spellButtons)):
			var b:Button = get_node("spell"+str(i+1))
			if spellButtons[i] != "none":
				if !b.pressed.is_connected(player_stats.act.bind(spells[spellButtons[i]])):
					b.pressed.connect(player_stats.act.bind(spells[spellButtons[i]]))
				else:
					b.pressed.disconnect(player_stats.act)
					b.pressed.connect(player_stats.act.bind(spells[spellButtons[i]]))
				b.text = spellButtons[i]
				b.theme = spells[spellButtons[i]].style
			else:
				b.theme = theme
				if b.pressed.is_connected(player_stats.act):
					b.pressed.disconnect(player_stats.act)
				b.text = "no spell equipped"
				
var spells = {
	"impale": spell.new(10, impale, tradTh, "impale", "Draw spears to impale the enemy. Costs 10 mana."),
	"tasty!": spell.new(25, tasty, tradTh, "tasty!", "Draw some nutritious food. Costs 25 mana"),
	"bind": spell.new(15, bind, tradTh, "bind", "Bind the enemy and weaken them. Costs 15 mana"),
	"erase": spell.new(50, erase, tradTh, "erase", "When you can't even say my name... Costs 50 mana"),
	"feedback loop": spell.new(20, feedbackLoop, debugTh, "feedback loop", "It's not a bug, it's a feature. Costs 20 mana."),
	"zap": spell.new(10, zap, debugTh, "zap", "Danger - high voltage. Costs 10 mana"),
	"daemon":spell.new(20, daemon, debugTh, "daemon", "You went over the edge, kid. Costs 20 mana"),
	"disfigure": spell.new(50, disfigure, debugTh, "disfigure", "Arrêter de peindre. Costs 50 mana"),
	"graviturgy": spell.new(20, rock, debugTh, "graviturgy", "Conjure a rock and hurl it at the enemy. Costs 20 mana."),
	"envenom": spell.new(10, poisonBody, debugTh, "envenom", "Inflict your enemy with poison. Costs 10 mana"),
	"mana siphon": spell.new(15, manaSteal, debugTh, "mana siphon", "What was yours is now mine. Costs 15 mana"),
	"to cinders": spell.new(50, toCinders, tradTh, "to cinders", "Let it rain down hellfire. Costs 50 mana")
}
var costs = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in spells:
		costs[spells[i]] = spells[i].cost

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
