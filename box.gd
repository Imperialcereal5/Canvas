extends StaticBody2D
@onready var area_2d: Area2D = $Area2D
@onready var interact_dialog: Sprite2D = $interactDialog
@onready var _2d_cam: Camera2D = $"../sideOn/2dCam"
@onready var combat: Control = $"../sideOn/Combat"
@onready var side_on: Node2D = $"../sideOn"
const digiBack = preload("uid://crijirqngrp4m")
const digiFront = preload("res://digiBgFront.png")
@onready var character_body_2d: CharacterBody2D = $"../CharacterBody2D"
var interactible = false
var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.body_entered.connect(enter)
	area_2d.body_exited.connect(exit)
	
func enter(body):
	if body == character_body_2d:
		interact_dialog.show()
		interactible = true
func exit(body):
	interact_dialog.hide()
	interactible = false
func interact():
	side_on.show()
	combat.show()
	_2d_cam.get_child(0).texture = digiBack
	_2d_cam.get_child(1).texture = digiFront
	_2d_cam.get_child(0).scale = Vector2(1,1)
	_2d_cam.get_child(1).scale = Vector2(1,1)
	timer = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (interactible && Input.is_action_pressed("interact") && timer<=0):
		interact()
	elif timer >0:
		timer -= delta
