extends CharacterBody2D
@onready var feet: ShapeCast2D = $ShapeCast2D
var speed = 100
var jumpPwr = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _physics_process(delta:float) -> void:
	var xMotion = 0
	if feet.is_colliding():
		if Input.is_action_pressed("jump"):
			velocity.y = jumpPwr
		#print("grounded")
	else:
		velocity.y += 9.81
	if Input.is_action_pressed("left"):
		xMotion -= speed
	if Input.is_action_pressed("right"):
		xMotion += speed
	velocity.x = xMotion
	move_and_slide()
