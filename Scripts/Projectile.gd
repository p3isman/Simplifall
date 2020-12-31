extends Node2D

# Get globals when loaded
onready var globals = Globals

var y_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += y_speed * delta
	
	# Delete node when out of screen or game is over
	if position.y > 1024 || position.y < -1500 || globals.game_over:
		queue_free()

func _on_Area2D_area_entered(area):
	# Check if same color
	if get_node("Area2D").areaType == area.areaType:
		globals.change_score(0.5)
		queue_free()
		
	# Projectiles coming from top impacting with our buttons
	if area.areaType == "Barrier" and y_speed > 0:
		globals.game_over = true
		get_node("/root/Game/Restart").move(Vector2(0, 0))
		get_node("/root/Game/Score/Score").text = "END"
		queue_free()
		
		
