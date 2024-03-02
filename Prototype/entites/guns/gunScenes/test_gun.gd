extends Gun

 
func _ready():
	name = "Test gun"
	BulletScene = preload("res://entites/guns/bullet scenes/bullet.tscn")
	AutoFire = false
	ReloadTime = 3
	CoolDown = 0.2
	SpreadAmount = 0.1
	
	BulletDammage = 10
	BulletCritical = 0.3
	BulletVelocity = 10
	BulletPierce = 0.6
	
	angleGun()

func _physics_process(_delta):
	angleGun()


func FIRE(_prepTime : float) -> void:
	InstantiateBullet()
