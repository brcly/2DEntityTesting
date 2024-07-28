class_name player extends Entity


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	isAttacking = false
