extends Node2D

onready var globals = Globals
onready var score_text = get_node("Score")
onready var high_score = get_node("HighScore")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	
	var score = globals.score
	
	if (score > globals.get_high_score("HighScores", globals.current_mode)):
		globals.save_item("HighScores", globals.current_mode, score)
		high_score.text = "High Score: " + str(int(score))

	if !globals.game_over:
		score_text.text = str(int(score))
		
		
func move(target):
	var move_tween = get_node("move_tween")
	move_tween.interpolate_property(self, "position", position, target, 1.3, Tween.TRANS_QUINT, Tween.EASE_OUT)
	move_tween.start()
