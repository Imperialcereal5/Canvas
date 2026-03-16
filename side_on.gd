extends Node2D
class Zone:
	var area:String
	var maxCoords:Vector2
	var minCoords:Vector2 
	var map:TileMapLayer
	func _init(a:String, max:Vector2, min:Vector2, m:TileMapLayer):
		area = a
		maxCoords = max
		minCoords = min
		map = m
@onready var levelmaps: Node2D = $levelmaps
var zones = []
var coords = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(len(coords)):
		if i < 10:
			zones.append(Zone.new("pixel",Vector2(coords[i][0],coords[i][1]),Vector2(coords[i][2],coords[i][3]),levelmaps.get_child(i)))
		elif i < 20:
			zones.append(Zone.new("digital",Vector2(coords[i][0],coords[i][1]),Vector2(coords[i][2],coords[i][3]),levelmaps.get_child(i)))
		else:
			zones.append(Zone.new("trad",Vector2(coords[i][0],coords[i][1]),Vector2(coords[i][2],coords[i][3]),levelmaps.get_child(i)))
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
