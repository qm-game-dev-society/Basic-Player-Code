class_name Player
extends CharacterBody2D

# Player node children
var stateMachine : StateMachine
var gunInterface : StateMachine
var healthInterface : HealthSystem


#Player Values
const N_SPEED = 100
const N_MAXSPEED = 120
const N_AIRSPEED = 60
const N_FRICTION = 3
const N_JUMPIMPULSE = 300
const N_MAXHEALTH = 50

#Current Player values
var gun : Gun
var canFire : bool
var speed = 250
var maxSpeed = 120
var airSpeed = 60
var friction = 3
var jump_impulse = 300

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	stateMachine = get_node("StateMachine") as StateMachine
	gunInterface = get_node("GunInterface") as StateMachine
	
	for child in get_children():
		if(child.is_in_group("HealthSystem")):
			healthInterface = child;
	
	
	
	assert(healthInterface != null)

	# For debug 
	stateMachine.transitioned.connect(OnPlayerChangeState)
	# For debug
	gunInterface.transitioned.connect(OnGunChangeState)
	
	# Allows the health interface to inform the main player script upon death
	healthInterface.died.connect(Died)
	
	healthInterface._maxHealth = N_MAXHEALTH
	healthInterface.ResetHealth()
	


# Debug for playerstate machine changing states
func OnPlayerChangeState(StateName : String):
	print("Player change state:" + StateName)

# Debug for gun state machine changing states
func OnGunChangeState(StateName : String): 
	print("Gun change state:" + StateName)

func Respawn(respawnPoint : Vector2):
	print("player respawn")
	position = respawnPoint
	healthInterface.ResetHealth()
	stateMachine.transition_to("Intro")

func Kill():
	healthInterface.Kill()
	Died()

func Died():
	stateMachine.transition_to("Dead")
	

