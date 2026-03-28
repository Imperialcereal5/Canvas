extends Button
@onready var label: PanelContainer = $PanelContainer
@onready var dice: Panel = $"../.."
@onready var control: Control = $"../../../../.."
@onready var player_die: Button = $"../../../../playerDie"
var die:
	set(die):
		print(die)
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
	player_die.theme = control.dice[_die].style
	player_die.get_child(0).texture = control.dice[_die].sprite
	dice.buttonPressed.emit()
func _ready() -> void:
	mouse_entered.connect(label.show)
	mouse_exited.connect(label.hide)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
