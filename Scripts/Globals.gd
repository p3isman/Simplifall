extends Node2D


var score = 0
var current_mode = "Hard"
var current_color = "Green"


var projectile_speed = 300
# Number of colors
var projectile_limit = 0

var shoot_interval = 0.4
var can_shoot = true

var emit_time = 1.5
var emit_min = .5
var emit_delta = .01

var game_over = false

var save_file_path = "user://save-file.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_file_path)

# Save high score
func get_high_score(section, mode):
	return config.get_value(section, mode, 0)
	
func get_current_mode():
	return current_mode

func save_item(section, mode, score):
	if score > config.get_value(section, mode, 0):
		config.set_value(section, mode, score)
		config.save(save_file_path)

# Increase score
func change_score(change):
	score += change
	# Speed up projectile emitting
	if (emit_time > emit_min):
		emit_time -= emit_delta
