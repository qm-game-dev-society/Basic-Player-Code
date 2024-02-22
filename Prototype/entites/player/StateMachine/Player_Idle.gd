# Virtual base class for all states.
extends PlayerState

var fric
var dirRight

func enter(_msg := {}) -> void:
	fric = player.velocity.x * player.friction 
	if player.velocity.x > 0:
		dirRight = true;
	else:
		dirRight = false


func physics_update(delta: float) -> void:
	player.velocity.x -= fric * delta
	if dirRight:
		player.velocity.x = clamp(player.velocity.x, 0, player.maxSpeed)
	else:
		player.velocity.x = clamp(player.velocity.x,-player.maxSpeed,0)
	
	player.move_and_slide()
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	elif Input.is_action_pressed("MOVE_left") or Input.is_action_pressed("MOVE_right"):
		player.velocity = Vector2.ZERO
		state_machine.transition_to("Run")
		
	elif Input.is_action_just_pressed("MOVE_up"):
		state_machine.transition_to("Air", {"do_jump": true})
	

