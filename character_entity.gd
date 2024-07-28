class_name characterEntity extends CharacterBody2D

@export var entityName : String = ""
@export var godMode : bool = false
@export var health : int = 100
@export var sprite : AnimatedSprite2D
@export var canMove : bool = false
@export var speed : int = 200
@export var canAttack : bool = false
@export var canAutoHeal : bool = false
@export var controllable : bool = false
@export var collisionBox : CollisionShape2D
@export var hurtBox : Area2D
@export var hitBox : Area2D
@export var isAnimated : bool = false
@export var animTree : AnimationTree
@export var animPlayer : AnimationPlayer

var direction : Vector2 = Vector2.ZERO
var isAttacking = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if controllable:
		get_input()
	if isAnimated:
		set_animations()
	if canMove:
		print(Input.get_vector("left", "right", "up", "down"))
		move_and_slide(velocity)
	
func get_input():
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	if Input.is_action_just_pressed("ui_accept"):
			#isAttacking = true
			animTree.get("parameters/playback").travel("Attack")
 
func set_animations():
	if direction == Vector2.ZERO:
		if animTree.get("parameters/playback").get_current_node() != "Idle":
			animTree.get("parameters/playback").travel("Idle")
	elif !isAttacking:
		if animTree.get("parameters/playback").get_current_node() != "Walk":
			animTree.get("parameters/playback").travel("Walk")
		animTree.set("parameters/Idle/BlendSpace2D/blend_position", direction)
		animTree.set("parameters/Walk/BlendSpace2D/blend_position", direction)
		animTree.set("parameters/Attack/BlendSpace2D/blend_position", direction)

func get_health() -> int:
	return self.health
	
func set_health(newHealth : int):
	self.health = newHealth
	
func get_speed() -> int:
	return self.speed

func get_canMove() -> bool:
	return self.canMove

func set_canMove(newCanMove : bool):
	self.canMove = newCanMove

func get_controllable() -> bool:
	return controllable
	
func set_controllable(newControllable : bool):
	self.controllable = newControllable 
	
func get_entityName() -> String:
	return self.entityName
