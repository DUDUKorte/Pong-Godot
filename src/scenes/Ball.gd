extends CharacterBody2D

const START_SPEED = 200
const ACCEL = 50
const MAX_Y_VECTOR = 0.6

var win_size : Vector2
var speed : int
var dir : Vector2

func _ready():
	win_size = get_viewport_rect().size

func new_ball():
	#randomize position and direction
	position.x = win_size.x/2
	position.y = randi_range(200, win_size.y - 200)
	speed = START_SPEED
	dir = random_direction()

func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	var collider 
	
	if collision:
		#dir *= -1
		#dir = random_direction()
		#speed += ACCEL
		collider = collision.get_collider()
		# if hits paddles
		if collider == $"../Player_1" or collider == $"../Player_2":
			speed += ACCEL
			#dir = dir.bounce(collision.get_normal())
			dir = new_direction(collider)
			collider.play_collision_sound()
		elif collider == $"../Borders": # if hits the top or bottom borders
			dir = dir.bounce(collision.get_normal())
			$"../Borders/Audio-Wall_Sound".play()

func random_direction():
	var new_dir = Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()
	
func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir = Vector2()
	# flip x coordinate
	if dir.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	new_dir.y = (dist / (collider.p_height / 2)) * MAX_Y_VECTOR
	return new_dir.normalized()
