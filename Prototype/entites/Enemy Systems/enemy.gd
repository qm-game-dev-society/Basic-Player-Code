class_name Enemy
extends Entity

var healthInterface : HealthSystem

var StartPosition : Vector2
var maxHealth : float

func _ready() -> void:
	add_to_group("enemy")
	
	StartPosition = position
	isGravity = true
	moveable = true
	
	for child in get_children():
		if(child.is_in_group("HealthSystem")):
			healthInterface = child;
	
	healthInterface.died.connect(died)
	
	healthInterface._maxHealth = maxHealth
	healthInterface.ResetHealth()
	
	super._ready()

func _physics_process(delta):
	super._physics_process(delta)

func hit(damage:float) -> void:
	healthInterface.ChangeHealth(-damage)

func died() -> void:
	visible = false
	setCollision(false)

func reset() -> void:
	healthInterface.ResetHealth()
	visible = true
	setCollision(true)
	position = StartPosition

