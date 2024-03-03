extends TextEdit
var name_input = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not text: return
	
	if not text.length() > _input_limit():
		name_input = text
	else: text = name_input
	
func _input_limit():
	return 10
