extends Box


# Called when the node enters the scene tree for the first time.
func interact():
	side_on.show()
	await side_on.setup(side_on.zones[0])
	timer = 1
	character_body_2d.position = Vector2(0, 0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
