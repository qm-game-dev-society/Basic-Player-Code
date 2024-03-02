class_name Dummy
extends Enemy

var cooldown : float
var hurt : float

func _ready() -> void:
	maxHealth = 50
	SetUpEnemy()
	


func hit(damage:float) -> void:
	hurt += damage
	cooldown = 5

func reset() -> void:
	super.reset()
	cooldown = 0
	hurt = 0


func _process(delta):
	if cooldown > 0:
		$Label.text = str(hurt)
		cooldown -= delta
	else:
		$Label.text = ""
		hurt = 0

func _physics_process(delta):
	#fall(delta)
	pass



