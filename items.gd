extends Panel
@onready var copy_button: Button = $"ScrollContainer/VBoxContainer/(copyButton)"
class Item:
	var desc 
	var effect
	var name
	var consumed = false
	func _init(d:String, n: String, u:Callable):
		desc = d
		effect = u
		name = n
	func use():
		effect.call()
		consumed = true
var dummy = Item.new("dummy item","twig",print.bind("item used"))
var inventory: Array[Item] = [dummy]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in inventory:
		var n = copy_button.duplicate()
		n.item = i
		n.show()
		copy_button.get_parent().add_child(n)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
