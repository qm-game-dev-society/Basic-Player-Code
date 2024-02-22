extends GunState

var timePass : float

# Calls reload method from current gun node and starts timer
func enter(_msg := {}) -> void:
	print("Reloading gun")
	player.gun.RELOAD()
	timePass = player.gun.ReloadTime

# Waits until timer finishes and transitions back to idle
func update(_delta: float) -> void:
	timePass -= _delta
	
	if timePass <= 0:
		state_machine.transition_to("Idle")
