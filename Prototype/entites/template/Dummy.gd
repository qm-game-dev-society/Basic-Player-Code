class_name Entity
extends CharacterBody2D

var cooldown : float
var hurt : float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func hit(damage:float) -> void:
	hurt += damage
	cooldown = 5

func _process(delta):
	if cooldown > 0:
		$Label.text = str(hurt)
		cooldown -= delta
	else:
		$Label.text = ""
		hurt = 0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta


	move_and_slide()


