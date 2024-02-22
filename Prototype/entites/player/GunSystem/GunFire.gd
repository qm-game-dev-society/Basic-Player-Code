extends GunState

var time
# Fires gun and checks timer
func enter(_msg := {}) -> void:
	player.gun.FIRE(0)
	time = player.gun.CoolDown
	pass

# Keeps checking until cooldown is done every frame then transitions back to idle state
func update(_delta: float) -> void:
	time -= _delta
	if time <= 0:
		state_machine.transition_to("Idle")
	
