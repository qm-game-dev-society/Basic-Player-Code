extends GunState

# Loads default gun if no gun is currently loaded
func enter(_msg := {}) -> void:
	if player.gun == null:
		state_machine.transition_to("ChangeGun", {"gun": "test_gun"})

#Every frame checks if player enters inputs for attack reload or shoot and trasitions to appropriate
#state if required
func update(_delta: float) -> void:
	if player.canFire:
		##if Input.is_action_just_pressed("ATTACK_reload"):
		##	state_machine.transition_to("Reload")
		if Input.is_action_pressed("ATTACK_shoot"):
			state_machine.transition_to("Fire")
