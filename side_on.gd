extends Node2D
@onready var fader = $"../fader"
@onready var cam:Camera2D = $"2dCam"
@onready var player = $Player
class Zone:
	extends Node2D
	var area:String
	var maxCoords:Vector2
	var minCoords:Vector2 
	var map:TileMapLayer
	var pixelBGFront = preload("res://Background_pixe_frontl.png")
	var pixelBGBack = preload("res://Background_pixe_back.png")
	var digiBGFront = preload("res://digiBgFront.png")
	var digiBGBack = preload("res://digiBgBack.png")
	
	func _init(a:String, minC:Vector2, maxC:Vector2, m:TileMapLayer):
		area = a
		maxCoords = maxC
		minCoords = minC
		map = m
		map.collision_enabled = false
		map.hide()
		
func setup(zone):
	zone.map.collision_enabled = true
	zone.map.show()
	player.position = Vector2(-7500, 0)
	await fader.fadeIn()
	#cam.minY = int(zone.minCoords.y)
	cam.minX = int(zone.minCoords.x)
	#cam.maxY = int(zone.maxCoords.x)
	cam.maxX = int(zone.maxCoords.y)
	if zone.area == "pixel":
		cam.get_child(0).texture = zone.pixelBGBack
		cam.get_child(1).texture = zone.pixelBGFront
		cam.get_child(0).scale = Vector2(3.3, 3.3)
		cam.get_child(1).scale = Vector2(3.3, 3.3)
	elif zone.area == "digital":
		cam.get_child(0).texture = zone.digiBGBack
		cam.get_child(1).texture = zone.digiBGFront
		cam.get_child(0).scale = Vector2(1, 1)
		cam.get_child(1).scale = Vector2(1, 1)
	cam.make_current()
	fader.position = cam.position + Vector2(-1000, -1000)
	await fader.fadeOut()
		
@onready var levelmaps: Node2D = $levelmaps
var zones = []
var coords = [[-9076, -10, -6942, 10],[-9076, -10, -6942, 10]]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(len(coords)):
		if i < 1:
			zones.append(Zone.new("pixel",Vector2(coords[i][0],coords[i][1]),Vector2(coords[i][2],coords[i][3]),levelmaps.get_child(i)))
		elif i < 20:
			zones.append(Zone.new("digital",Vector2(coords[i][0],coords[i][1]),Vector2(coords[i][2],coords[i][3]),levelmaps.get_child(i)))
		else:
			zones.append(Zone.new("trad",Vector2(coords[i][0],coords[i][1]),Vector2(coords[i][2],coords[i][3]),levelmaps.get_child(i)))
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
