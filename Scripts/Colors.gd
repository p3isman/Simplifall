extends TextureButton

onready var globals = Globals

# Serialize color
export (String) var color


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func change_color():
	globals.current_color = color
