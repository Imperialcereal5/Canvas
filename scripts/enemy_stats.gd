extends Panel
@onready var control: Control = $".."
@onready var buttons: Panel = $"../buttons"
@onready var spells: Panel = $"../buttons/Panel"
@onready var player_stats: Panel = $"../PlayerStats"
var shader:ShaderMaterial = preload("uid://bq5xm6b6j3cy4")
@onready var die: Panel = $"../diceUI/enemyDie"
@onready var fader: ColorRect = $"../../../fader"
@onready var enemy_stats: Panel = $"."
var ai:Callable = attack
var hp = 20
var maxHp = 20
var mp = 0
var maxMp = 50
var roll = 0
var dmg = 5
var combo1 = 0
var combo2 = 0
var poison = 0
var manaRegen = 0
var regen = 0
var runItBack = 0
var stunned = 0
var vulnerable = 0
var weakened = 0
var active = "default"
func attack():
	await die.spinDie(20)
	var n = int(die.get_child(1).text)
	var d = (dmg if !weakened else (dmg+1)/2)
	if n == 20:
		player_stats.updateHP(d*-2)
	elif n > 1 and n < 10:
		player_stats.updateHP(d*-0.8)
	elif n > 9 and n < 15:
		player_stats.updateHP(d*-1)
	elif n != 1:
		player_stats.updateHP(d*-1.25)
	await get_tree().create_timer(1.5).timeout
	
func act(action):
	var a = Callable(action)
	if combo2:
		await a.call()
		await a.call()
		combo2 -= 1
	if combo1:
		await a.call()
		combo1 -= 1
	await a.call()
	endTurn()	
func haveTurn():
	for i in range(runItBack+1):
		if poison:
			poison -= 1
			updateHP(-2)
		if regen:
			updateHP(2)
			regen -= 1
		if manaRegen:
			updateMP(5)
			manaRegen -= 1
		if !stunned:
			await die.spinDie(20)
			await get_tree().create_timer(1.5).timeout
			roll = int(die.get_child(1).text)
			updateMP(roll)
			await act(ai)
		else:
			print("stunned")
			endTurn()
func endTurn():
	if weakened:
		weakened -= 1
	if stunned:
		stunned -= 1
	if !runItBack:
		buttons.show()
		control.cycle()
	else:
		runItBack -= 1
func updateHP(n):
	if n < 0 and vulnerable:
		await overlay(Color(1, 0, 0))
		hp += 2*n
		vulnerable -= 1
	elif n < 0:
		await overlay(Color(1, 0, 0))
		hp += n
	if hp > 20:
		hp = 20
	elif hp <= 0:
		hp = 0
		await fader.fadeIn()
		control.hide()
		await fader.fadeOut()
	get_child(0).text = ("HP: %d/"%hp) + "%d"%maxHp
	
func updateMP(n):
	mp += n
	if mp > 50:
		mp = 50
	elif mp < 0:
		mp = 0
	get_child(1).text = ("MP: %d/" % mp) + "%d" % maxMp
func overlay(clr):
	shader.set_shader_parameter("end", clr)
	var tween = create_tween()
	await tween.tween_method(func(x): shader.set_shader_parameter("scale", x),0.0, 1.0, 0.1).finished
	await get_tree().create_timer(0.1).timeout
	tween = create_tween()
	await tween.tween_method(func(x): shader.set_shader_parameter("scale", x),1.0, 0.0, 0.1).finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
