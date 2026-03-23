extends Panel
@onready var buttons: Panel = $"../buttons"
@onready var control: Control = $".."
@onready var attackBtn: Button = $"../buttons/Attack"
@onready var die: Button = $"../diceUI/playerDie"
@onready var dice_rect: ColorRect = $"../diceUI/DiceRect"
@onready var enemy_stats: Panel = $"../EnemyStats"
@onready var items: Panel = $"../Items"
@onready var passBtn: Button = $"../buttons/Pass"
@onready var dice: Panel = $"../diceUI/DiceRect/Dice"
@onready var spells: Panel = $"../buttons/Panel"
@onready var itemBtn: Button = $"../buttons/Item"
@onready var lock: Button = $"../diceUI/playerDie/lock"
@onready var player_die: Button = $"../diceUI/playerDie"
var hp = 20
var maxHP = 20
var mp = 0
var maxMP = 50
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
func haveTurn(first:bool=1):
	buttons.hide() 
	if !lock.locked && first:
		print("first")
		dice_rect.show()
		await dice.buttonPressed
		dice_rect.hide()
	if player_die.active == control.dice["two"] && first:
		runItBack = 1
		print("running it back")
	await die.spinDie(20)
	roll = int(die.text)
	updateMP(roll)
	if manaRegen:
		manaRegen -= 1
		updateMP(5)
	if regen:
		regen -= 1
		updateHP(2)
	if poison:
		poison -= 1
		updateHP(-2)
	if !stunned:
		buttons.show()
	else:
		act(passTurn)
func act(action):
	buttons.hide()
	var a
	if (action in spells.costs and action.cost <= mp) or action not in spells.costs:
		if action in spells.costs:
			updateMP(-action.cost)
			a = Callable(action.cast.bind(self, enemy_stats))
		else:
			a = Callable(action)
		if combo2:
			await a.call()
			await get_tree().create_timer(1.5).timeout
			if enemy_stats.hp != 0:
				await a.call()
			await get_tree().create_timer(1.5).timeout
			combo2 -= 1
		if combo1:
			if enemy_stats.hp != 0:
				await a.call()
			await get_tree().create_timer(1.5).timeout
			combo1 -= 1
		if enemy_stats.hp != 0:
			await a.call()
		print("attacked")
		await get_tree().create_timer(1.5).timeout
		if runItBack:
			runItBack -= 1
			await haveTurn(0)
		else:
			endTurn()	
	else:
		buttons.show()
func endTurn():
	if weakened:
		weakened -= 1
	control.cycle()
func attack():
	await die.spinDie(20)
	roll = int(die.text)
	if roll == 20:
		await enemy_stats.updateHP(dmg*-2)
	elif roll == 30:
		await enemy_stats.updateHP(dmg*-3)
	elif roll == 0:
		await updateHP(dmg*-1)
	elif roll > 1 and roll < 10:
		await enemy_stats.updateHP(dmg*-0.8)
	elif roll > 9 and roll < 15:
		await enemy_stats.updateHP(dmg*-1)
	elif roll != 1:
		await enemy_stats.updateHP(dmg*-1.25)
	get_child(2).text = "Roll: %d" % roll
func updateHP(n):
	if vulnerable && (n < 0):
		vulnerable -= 1
		hp += n
	hp += n
	if hp > 20:
		hp = 20
	elif hp < 0:
		hp = 0
	get_child(0).text = "HP: %d/20" % hp
func updateMP(n):
	mp += n
	if mp > 50:
		mp = 50
	elif mp < 0:
		mp = 0
	get_child(1).text = "MP: %d/50" % mp
func passTurn():
	pass
func toggleItem():
	if items.visible:
		items.hide()
	else:
		items.show()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:                                                                        
	attackBtn.pressed.connect(act.bind(attack))
	passBtn.pressed.connect(act.bind(passTurn))
	itemBtn.pressed.connect(toggleItem)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
