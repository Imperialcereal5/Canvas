extends Panel
@onready var enemy_stats: Panel = $".."
var statuses = []
var user = enemy_stats
var icons = [
	preload("uid://bjgtsdgmdbuxn"),
	preload("uid://d0qbknterhkv2"),
	preload("uid://cyyuokvla221o"),
	preload("uid://bsw7ft30ondf1"),
	preload("uid://be5bgini4ym0x"),
	preload("uid://d3n7f5fm80y41"),
	preload("uid://d4a8kdoylglt0"),
	preload("uid://dm77f8n8b2mbw"),
	preload("uid://dbk6eavtkrk71")
]
var descs = [
	"Unable to act this turn.",
	"Unable to act this turn.",
	"Takes 2 damage per turn.",
	"Will take double damage for the next",
	"Deals half as much damage.",
	"Regenerate 4 hp each turn.",
	"Regenerate 5 mana each turn.",
	"The next action taken will be performed 1 additional time.",
	"The next action taken will be performed 2 additional times."
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
func update():
	size = Vector2(15, 52)
	statuses = [user.erased, user.stunned, user.posion, user.vulnerable, user.weakened, user.regen, user.manaRegen, user.combo1, user.combo2]
	for i in range(len(statuses)):
		if statuses[i] != 0:
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
