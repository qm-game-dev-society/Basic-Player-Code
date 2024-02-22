extends PlayerState

func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO

func update(_delta: float) -> void:
	state_machine.transition_to("Idle")
