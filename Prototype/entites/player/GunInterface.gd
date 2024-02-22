extends Node2D

const GUNTYPE = preload("res://entites/guns/GunTypeEnum.gd").GUNTYPE

# Gun scenes


var currentGun

# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func FireGun():
	if(currentGun):
		currentGun.FIRE();

func ArmNewGun(gunType): 
	match gunType:
		GUNTYPE.TestA:
			UnArmCurrentGun()
			loadGun(GUN_TestA)
			
		GUNTYPE.TestB:
			UnArmCurrentGun()
			loadGun(GUN_TestB)


func UnArmCurrentGun():
	for n in self.get_children():
		self.remove_child(n)
		n.queue_free()


func loadGun(scene):
	var gun = scene.instantiate()
	gun.position = Vector2.ZERO
	add_child(gun)
	currentGun = gun
	currentGun.ARM()
