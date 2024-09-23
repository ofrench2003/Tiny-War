extends CharacterBody2D

enum{CHOPPING, BUILDING, COLLECTING, RETURNING, FINDING}
#-Different phases for phase management
#CHOPPING - chopping down a tree
#BUILDING - building a building OR repairing something
#COLLECTING - collecting wood/other from the floor
#RETURNING - returning to the castle with materials
#FINDING - finding a job to do (cut a tree, collect a resource, build/repair building
@onready var team = "blue"
@onready var inControl = true
var animator
var speed = 300

func _ready() -> void:
	if team == "blue":
		animator = $blue


func _physics_process(delta: float) -> void:
	if inControl:
		playerControl()


func playerControl():
	var moveDirection = Vector2.ZERO
	moveDirection.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	moveDirection.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	moveDirection = moveDirection.normalized()
	
	if moveDirection:
		velocity = moveDirection * speed
		animator.play("run")
	else:
		velocity = moveDirection
		animator.play("idle")
	if moveDirection.x > 0:
		scale.x = scale.y * 1
	elif moveDirection.x < 0:
		scale.x = scale.y * -1
	move_and_slide()
