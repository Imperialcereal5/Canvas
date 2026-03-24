extends Button
var saveFile = "res://saveData.txt"
@onready var combat: Control = $"../../sideOn/Combat"
@onready var player_stats: Panel = combat.get_node("PlayerStats")
@onready var inventory: Panel = $"../../sideOn/sideOnMenu/Inventory"
@onready var diceContainer: VBoxContainer = $"../../sideOn/sideOnMenu/Inventory/VBoxContainer"
@onready var camera_2d: Camera2D = $"../../Camera2D"
@onready var menu_cam: Camera2D = $"../../menuCam"
@onready var side_on: Node2D = $"../../sideOn/"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(loadSave)

func loadSave():
	var file = FileAccess.open(saveFile, FileAccess.READ)
	var data = file.get_as_text()
	var n
	data = data.split("\n")
	var vars = {}
	for i in data:
		if i != "":
			n = i.split("=")
			vars[n[0]] = n[1]
	player_stats.maxHP = int(vars["maxHP"])
	player_stats.maxMP = int(vars["maxMP"])
	n = vars["unlockedDice"].split(" ")
	for i in n:
		inventory.unlockedDice += [combat.dice[i]]
	n = vars["equippedDice"].split(" ")
	for i in range(3):
		diceContainer.get_child(i).activeDie = combat.dice[n[i]]
	if !bool(int(vars["in_sideOn"])):
		combat.hide()
		side_on.hide()
		camera_2d.make_current()
	else:
		combat.hide()
		menu_cam.make_current()
		hide()
		await side_on.setup(side_on.zones[int(vars["roomID"])])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
