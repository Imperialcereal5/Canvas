extends StaticBody2D
class_name Box
@onready var area_2d: Area2D = $Area2D
@onready var interact_dialog: Sprite2D = $interactDialog
#@onready var _2d_cam: Camera2D = $"/root/Node2D/Overworld/sideOn/2dCam"
@onready var combat: Control = $"/root/Node2D/Overworld/sideOn/Combat"
@onready var side_on: Node2D = $"/root/Node2D/Overworld/sideOn"
const digiBack = preload("uid://crijirqngrp4m")
const digiFront = preload("res://assets/digiBgFront.png")
@onready var character_body_2d: CharacterBody2D = $"/root/Node2D/Overworld/CharacterBody2D"
var interactible = false
var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.body_entered.connect(enter)
	area_2d.body_exited.connect(exit)
	
func enter(body):
	if body == character_body_2d or body == $"/root/Node2D/Overworld/sideOn/Player":
		interact_dialog.show()
		interactible = true
func exit(_body):
	interact_dialog.hide()
	interactible = false
func interact():
	side_on.show()
	await side_on.setup(side_on.zones[1])
	timer = 1
	character_body_2d.position = Vector2(0, 0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (interactible && Input.is_action_pressed("interact") && timer<=0):
		await interact()
	elif timer >0:
		timer -= delta
