extends TextureButton

onready var globals = Globals
onready var shoot_timer = get_node("/root/Game/shoot_timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func arrow_pressed():
	
	if globals.can_shoot:
		var path = "res://Scenes/" + str(globals.current_color) + "Projectile.tscn"
		var projectile = load(path).instance()
		add_child(projectile)
		# Position relative to this arrow, since projectile is now a child
		projectile.position = Vector2(68, -70)
		projectile.y_speed = -int(globals.projectile_speed)
		globals.can_shoot = false
		shoot_timer.start(globals.shoot_interval)


func _on_shoot_timer_timeout():
	globals.can_shoot = true
	shoot_timer.stop()
