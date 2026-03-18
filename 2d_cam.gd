extends Camera2D
@onready var player: CharacterBody2D = $"../Player"
@onready var bg_front: Sprite2D = $bgFront
@onready var bg_back: Sprite2D = $bgBack
@onready var initPos = Vector2(-7500, 0)
var minX = -10000
var maxX = 10000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = clamp(player.position.x, minX, maxX)
	position.y = player.position.y
	bg_front.position.x = -(1.0/4.0)*(position.x - initPos.x)
	bg_back.position.x = -(1.0/2.0)*(position.x - initPos.x)
	
