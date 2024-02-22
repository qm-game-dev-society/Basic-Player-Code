# Run.gd
extends PlayerState


func physics_update(delta: float) -> void:
	# Notice how we have some code duplication between states. That's inherent to the pattern,
	# although in production, your states will tend to be more complex and duplicate code
	# much more rare.
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	# We move the run-specific input code to the state.
	# A good alternative would be to define a `get_input_direction()` function on the `Player.gd`
	# script to avoid duplicating these lines in every script.
	var input_direction_x: float = (
		Input.get_action_strength("MOVE_right")
		- Input.get_action_strength("MOVE_left")
	)
	
	if(player.velocity.x < 0 && input_direction_x > 0 || player.velocity.x > 0 && input_direction_x < 0):
		player.velocity.x = 0;
	
	player.velocity.x += player.speed * input_direction_x * delta
	player.velocity.y += player.gravity * delta
	player.velocity.x = clamp(player.velocity.x,-player.maxSpeed, player.maxSpeed)
	
	player.move_and_slide()
	if Input.is_action_just_pressed("MOVE_up"):
		state_machine.transition_to("Air", {"do_jump": true})
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
