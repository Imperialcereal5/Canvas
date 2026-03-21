extends Box
@onready var fader: ColorRect = $"../../../../fader"
@onready var enemy_stats:Panel = $"../../../Combat/EnemyStats"
var sprite = preload("res://assets/Dummy Test.png")

func _ready():
	character_body_2d = $"../../../Player"
	super()
	
func interact():
	timer = 10
	await fader.fadeIn()
	await combat.encounter(sprite, Vector2(8,8), 20, 50, enemy_stats.attack, "Dummy")
	await fader.fadeOut()
