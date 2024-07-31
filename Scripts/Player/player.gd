class_name Player

extends Entity

var saved_state

func _process(delta: float) -> void:
	velocity = direction * speed * delta
	if direction != Vector2.ZERO and current_state != State.ATTACKING:
		switchState(State.MOVING)
	elif direction == Vector2.ZERO:
		switchState(State.IDLE)

func _input(event: InputEvent) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_just_pressed("ui_accept"):
		saved_state = current_state
		switchState(State.ATTACKING)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	switchState(saved_state)
