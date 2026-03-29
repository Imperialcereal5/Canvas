extends Box
@onready var fader: ColorRect = $"../../../../fader"
@onready var enemy_stats:Panel = $"../../../Combat/EnemyStats"
@onready var panel:Panel = $"../../../Combat/buttons/Panel"
@onready var player_stats:Panel = $"../../../Combat/PlayerStats"
var hasFired = 0
var sprite = preload("uid://cv7qdmgv3oywq")

func _ready():
	character_body_2d = $"../../../Player"
	super()
func gargAI():
	if enemy_stats.hp <= 20:
		panel.spells["to cinders"].cast(enemy_stats, player_stats)
	else:
		if enemy_stats.mp >= 10:
			panel.spells["impale"].cast(enemy_stats, player_stats)
			enemy_stats.mp -= 10
		else:
			enemy_stats.attack()
func interact():
	timer = 10
	await fader.fadeIn()
	await combat.encounter(sprite, Vector2(3,3), 100, 100, gargAI, "Gargoyle", "normal")
	await fader.fadeOut()
