extends Control
@onready var enemy_stats: Panel = $EnemyStats
@onready var buttons: Panel = $buttons
@onready var control: Control = $"."
@onready var player_stats: Panel = $PlayerStats
@onready var enemy_sprite: Sprite2D = $enemySprite
@onready var fader: ColorRect = $"../../fader"
@onready var diceCont: HBoxContainer = $diceUI/DiceRect/Dice/HBoxContainer
@onready var inventory: Panel = $"../sideOnMenu/Inventory"
@onready var _2d_cam: Camera2D = $"../2dCam"	
var dice: Dictionary
var playerRoll = 0
var enemyRoll = 0
class die:
	var tradTh = preload("uid://bd1tw2mejy8x2")
	var digiTh = preload("uid://cl8ukh3u5138o")
	var pixelTh = preload("uid://0d3wdme6mbon")
	func roll() -> int:
		var n = randi() % 20 + 1
		return n
	var sprite = preload("res://assets/d20.png")
	var desc = "the default die. Rolls from 0 to 20 with a uniform distribution"
	var name = "default"
	var style = tradTh
class coinDie:
	extends die
	func roll() -> int:
		var n = [1, 20][randi() %2]
		return n
	func _init():
		desc = "an old coin. Rolls either 1 or 20 with 50/50 odds"
		name = "coin"
		style = digiTh
class normalDie:
	extends die
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
	func _init():
		desc = "a very normal die. Rolls from 1 to 20 following a normal distribution"
		name = "normal"
		style = pixelTh
class twoDie:
	extends die
	func roll() -> int:
		var n = randi() % 10 + 1
		return n
	func _init():
		desc = "Remnants of stick yaoi. Rolls 1 to 10 but you take 2 turns at a time"
		name = "two"
		style = pixelTh
class cursedDie:
	extends die
	func roll() -> int:
		var n = [0, 30][randi()%2]
		return n
	func _init():
		desc = "the Queen's favourite. Rolls either 0 or 30 with a 50/50 chance"
		name = "cursed"
func toggleCam():
	if visible:
		$combatCam.make_current()

	else:
		_2d_cam.make_current()
# Called when the node enters the scene tree for the first time.
func encounter(sprite, scl, hp, mp, ai, _name):
	enemy_sprite.texture = sprite
	enemy_sprite.scale = scl
	enemy_stats.hp = hp
	enemy_stats.maxHp = hp
	enemy_stats.mp = 0
	enemy_stats.maxMp = mp
	enemy_stats.ai = ai
	player_stats.hp = 20
	player_stats.mp = 0
	enemy_stats.get_child(2).text = _name
	player_stats.updateMP(0); player_stats.updateHP(0)
	enemy_stats.updateMP(0); enemy_stats.updateHP(0)
	show()
	player_stats.haveTurn()
func _ready() -> void:
	var default = die.new()
	var coin = coinDie.new()
	var normal = normalDie.new()
	visibility_changed.connect(toggleCam)
	dice = {
		"default": default,
		"coin": coin,
		"normal": normal,
		"two":twoDie.new(),
		"cursed":cursedDie.new()
	}
	await inventory.ready
	inventory.unlockedDice = [default, coin, normal, dice["two"], dice["cursed"]]
	diceCont.get_child(0).die = "default"
	diceCont.get_child(1).die = "two"
	diceCont.get_child(2).die = "normal"
	hide()
	#player_stats.haveTurn()
	#dieSprite.get_parent().pressed.connect(spinDie.bind(20))
	#get_node("Attack").pressed.connect(updUI)
func cycle():
	if !(buttons.visible) && player_stats.hp > 0 && enemy_stats.hp > 0:
		await enemy_stats.haveTurn()
	elif buttons.visible:
		player_stats.haveTurn(1)
	else:
		pass

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
