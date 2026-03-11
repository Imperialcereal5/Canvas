extends Panel
@onready var enemy_stats: Panel = $"../../EnemyStats"
@onready var spell_1: Button = $spell1
@onready var player_stats: Panel = $"../../PlayerStats"


func blastBody():
	enemy_stats.updateHP(-6)
func comboBody():
	player_stats.combo2 += 1
func healBody():
	player_stats.updateHP(12)
func manaStealBody():
	player_stats.updateMP(15)
	enemy_stats.updateMP(-15)
func smiteBody():
	enemy_stats.updateHP(-18)
func poisonBody():
	enemy_stats.poison += 3
	print(enemy_stats.poison)
var spellButtons = ["Blast|10", "Combo|20", "Heal|25", "Mana steal|10", "Smite|50",
"Poison|10"]:
	set(spellButtons):
		for i in range(len(spellButtons)):
			get_node("spell"+str(i+1)).pressed.connect(player_stats.act.bind(spells[spellButtons[i]]))
			get_node("spell"+str(i+1)).text = spellButtons[i]
var spells = {
	"Blast|10": blastBody,
	"Combo|20": comboBody,
	"Heal|25": healBody,
	"Mana steal|10": manaStealBody,
	"Smite|50": smiteBody,
	"Poison|10": poisonBody
}
var costs = {
	blastBody: 10,
	comboBody: 20,
	healBody: 25,
	manaStealBody: 10,
	smiteBody: 50,
	poisonBody: 10
	
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(len(spellButtons)):
		get_node("spell"+str(i+1)).pressed.connect(player_stats.act.bind(spells[spellButtons[i]]))
		get_node("spell"+str(i+1)).text = spellButtons[i]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
