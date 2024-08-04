extends Sprite2D

var score = [0 , 0] # [Player1 , Player2]
const PADDLE_SPEED = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ball_timer_timeout():
	$Ball.new_ball()


func _on_score_left_body_entered(body):
	score[1] += 1
	$HUD/Player2Score.text = str(score[1])
	$BallTimer.start()
	$"ScoreLeft/Audio-Score_Sound".play()

func _on_score_right_body_entered(body):
	score[0] += 1
	$HUD/Player1Score.text = str(score[0])
	$BallTimer.start()
	$"ScoreRight/Audio-Score_Sound".play()
	
