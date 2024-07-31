class_name Entity 

extends PhysicsBody2D

@export var entity_name : String = ""
@export var god_mode : bool = false
@export var max_health : int = 100
@export var can_move : bool = false
@export var speed : int = 100
@export var isAnimated : bool = false

@export var anim_tree : AnimationTree
@export var sprite : AnimatedSprite2D

var current_state : State
var current_health : int = max_health
var velocity : Vector2
var direction : Vector2

enum State {IDLE, MOVING, ATTACKING}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if isAnimated:
		anim_tree.get("parameters/playback").travel("Idle", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if isAnimated:
		set_animations(current_state, direction)
	if can_move:
		move_and_collide(velocity)
		
func switchState(newState : State):
	match newState:
		State.IDLE:
			current_state = State.IDLE
		State.MOVING:
			current_state = State.MOVING
		State.ATTACKING:
			current_state = State.ATTACKING

func set_animations(state : State, direction : Vector2):
	match state:
		State.ATTACKING:
			if anim_tree.get("parameters/playback").get_current_node() != "Attack":
				anim_tree.get("parameters/playback").travel("Attack")
		State.IDLE:
			if anim_tree.get("parameters/playback").get_current_node() != "Idle":
				anim_tree.get("parameters/playback").travel("Idle")
		State.MOVING:
			if anim_tree.get("parameters/playback").get_current_node() != "Walk":
				anim_tree.get("parameters/playback").travel("Walk")
			anim_tree.set("parameters/Attack/BlendSpace2D/blend_position", direction)
			anim_tree.set("parameters/Idle/BlendSpace2D/blend_position", direction)
			anim_tree.set("parameters/Walk/BlendSpace2D/blend_position", direction)

func apply_damage(damage_amount : int):
	current_health -= damage_amount
	if current_health <= 0:
		kill_entity()

func apply_heal(heal_amount : int):
	current_health += heal_amount

func kill_entity():
	queue_free()
