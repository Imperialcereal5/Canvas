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

# Called when the node enters the scene tree for the first time.
func pickDie():
	player_die.active = die
	dice.buttonPressed.emit()
func _ready() -> void:
	die = "two"
	pressed.connect(pickDie)
	mouse_entered.connect(label.show)
	mouse_exited.connect(label.hide)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
