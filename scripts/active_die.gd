extends Button
@onready var label: PanelContainer = $PanelContainer
@onready var dice: Panel = $"../.."
@onready var control: Control = $"../../../../.."
@onready var player_die: Button = $"../../../../playerDie"
var die:
	set(die):
		var d = control.dice[die]
		$Sprite2D.texture = d.sprite
		$PanelContainer/Label.text = d.desc
		player_die.active = d
		if pressed.is_connected(pickDie.bind(die)):
			pressed.disconnect(pickDie.bind(die))
		pressed.connect(pickDie.bind(die))
		theme = d.style

# Called when the node enters the scene tree for the first time.
func pickDie(_die):
	player_die.active = control.dice[_die]
	dice.buttonPressed.emit()
func _ready() -> void:
	pass # Replace with function body.
	await control.ready
	mouse_entered.connect(label.show)
	mouse_exited.connect(label.hide)
	die = "default"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
