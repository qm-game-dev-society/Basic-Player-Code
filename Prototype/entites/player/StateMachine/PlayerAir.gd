extends PlayerState


# If we get a message asking us to jump, we jump.
func enter(_msg := {}) -> void:
	if _msg.has("do_jump") && _msg["do_jump"] == true:
		player.velocity.y -= player.jump_impulse
		


func physics_update(delta: float) -> void:
	# Horizontal movement.
	var input_direction_x: float = (
		Input.get_action_strength("MOVE_right")
		- Input.get_action_strength("MOVE_left")
	)
	
	if player.canMove:
		player.velocity.x += player.airSpeed * input_direction_x * delta
		# Vertical movement.
		player.velocity.y += player.gravity * delta
		player.move_and_slide()

		player.velocity.x = clamp(player.velocity.x,-player.maxSpeed, player.maxSpeed)
		# Landing.
		if player.is_on_floor():
			if is_equal_approx(player.velocity.x, 0.0):
				state_machine.transition_to("Idle")
			else:
				state_machine.transition_to("Run")
	else:
		state_machine.transition_to("Idle")
