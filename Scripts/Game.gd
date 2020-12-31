extends Node2D

var timer

onready var globals = Globals
onready var start = get_node("UI/MenuButtons/Start")
onready var ui = get_node("UI")
onready var difficulty = get_node("UI/MenuButtons/Difficulty")
onready var buttons = get_node("Buttons")
onready var score = get_node("Score")
onready var high_score = get_node("Score/HighScore")
onready var emitters_node = get_node("Emitters")
onready var emitters = [get_node("Emitters/HBoxContainer/Left"), get_node("Emitters/HBoxContainer/Middle"), get_node("Emitters/HBoxContainer/Right")]

var choices = [
	preload("res://Scenes/BlueProjectile.tscn"),
	preload("res://Scenes/GreenProjectile.tscn"),
	preload("res://Scenes/RedProjectile.tscn"),
	preload("res://Scenes/PurpleProjectile.tscn"),
	preload("res://Scenes/OrangeProjectile.tscn"),
	preload("res://Scenes/YellowProjectile.tscn"),
	preload("res://Scenes/DiffGreenProjectile.tscn"),
	preload("res://Scenes/DiffBlueProjectile.tscn"),
	preload("res://Scenes/DiffRedProjectile.tscn")
]

var screen_height = OS.window_size.y



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Start_pressed():
	start.move(Vector2(-576, 0))
	difficulty.move(Vector2(0, 0))


func _on_Back_pressed():
	start.move(Vector2(0, 0))
	difficulty.move(Vector2(576, 0))

# Quit
func _on_Quit_pressed():
	get_tree().quit()


# Called by the UI
func move_stuff(ui_x, ui_y, difficulty_x, difficulty_y, score_x, score_y, buttons_x, buttons_y, em_x, em_y, mode, limit, is_over):
	ui.move(Vector2(ui_x, ui_y))
	difficulty.move(Vector2(difficulty_x, difficulty_y))
	score.move(Vector2(score_x, score_y))
	buttons.move(Vector2(buttons_x, buttons_y))
	begin_game()
	emitters_node.move(Vector2(em_x, em_y))
	high_score.text = "High Score: " + str(globals.get_high_score("HighScores", mode))
	globals.current_mode = mode
	globals.projectile_limit = limit
	globals.game_over = is_over


func _on_Easy_pressed():
	move_stuff(0, -400, 576, 0, 0, 0, 0, 757, 0, 0, "Easy", 3, false)

func _on_Medium_pressed():
	move_stuff(0, -400, 576, 0, 0, 0, 0, 655, 0, 0, "Medium", 6, false)

func _on_Hard_pressed():
	move_stuff(0, -400, 576, 0, 0, 0, 0, 538, 0, 0, "Hard", 9, false)

func _on_Restart_pressed():
	get_node("Restart").move(Vector2(576, 0))
	globals.score = 0
	match globals.current_mode:
		"Easy":
			_on_Easy_pressed()
		"Medium":
			_on_Medium_pressed()
		"Hard":
			_on_Hard_pressed()
	
func _on_Menu_pressed():
	get_node("Restart").move(Vector2(576, 0))
	move_stuff(0, 0, 0, 0, 0, -600, 0, 1070, 700, -100, globals.current_mode, globals.projectile_limit, true)
	globals.score = 0

# Start timer at the beginning of game, interval between projectiles
func begin_game():
	timer = get_node("spawn_timer")
	globals.emit_time = 1.5
	timer.set_wait_time(globals.emit_time)
	timer.start()
	globals.can_shoot = true

func _on_Timer_timeout():
	randomize()
	# Store instance of projectile node
	var projectile = choices[int(rand_range(0, globals.projectile_limit))].instance()
	# Add it to the tree
	add_child(projectile)
	
	randomize()
	var rand_emitter = int(rand_range(0, 3))
	projectile.position = emitters[rand_emitter].position
	projectile.y_speed = globals.projectile_speed
	
	if (!globals.game_over):
		# Restart interval
		timer.set_wait_time(globals.emit_time)
		timer.start()
	else:
		timer.stop()
