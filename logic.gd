extends Control
@onready var enemy_stats: Panel = $EnemyStats
@onready var buttons: Panel = $buttons
@onready var control: Control = $"."
@onready var player_stats: Panel = $PlayerStats
var dice: Dictionary
var playerRoll = 0
var enemyRoll = 0
class die:
	func roll() -> int:
		var n = randi() % 20 + 1
		return n
class coinDie:
	func roll() -> int:
		var n = [1, 20][randi() %2]
		return n
class normalDie:
	func roll() -> int:
		var scale:float = PackedInt32Array([0x407ce0f5]).to_byte_array().to_float32_array()[0]
		var norm = func(a): return 1.0/scale*(1.0/(sqrt(2.0*PI))*exp((-1.0/2.0)*(((10.5/4.0)-(a/4.0))**2.0)))
		var n = randf()
		var t = 0
		for i in range(1, 21):
			t += norm.call(i)
			if t > n or i==20:
				return i
		return 0
		
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var default = die.new()
	var coin = coinDie.new()
	var normal = normalDie.new()
	dice = {
		"default": default,
		"coin": coin,
		"normal": normal
	}
	player_stats.haveTurn()
	#dieSprite.get_parent().pressed.connect(spinDie.bind(20))
	#get_node("Attack").pressed.connect(updUI)
func cycle():
	if !(buttons.visible) && player_stats.hp > 0 && enemy_stats.hp > 0:
		await enemy_stats.haveTurn()
	elif buttons.visible:
		player_stats.haveTurn()
	else:
		get_tree().quit()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
