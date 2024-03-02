class_name Entity
extends CharacterBody2D

var moveable : bool
var isGravity : bool

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func SetUpEntity() -> void:
	add_to_group("entity")
	set_visibility_layer_bit(0,false)
	set_visibility_layer_bit(1, true)

func fall(delta) -> void:
	if isGravity && not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()

#TODO: Make this work no matter the collision layer originally active
func setCollision(option : bool) -> void:
	set_collision_layer_value(1, option)
