class_name PlayerCamera
extends Camera2D

@export var transitionTargetScene : PackedScene

var currentTarget : Node2D
var transitionNode : Node2D
var transitionStartPoint : Vector2
var totalTime : float

# Called when the node enters the scene tree for the first time.
func _ready():
	transitionNode = transitionTargetScene.instantiate()
	get_parent().add_child(transitionNode)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent() != currentTarget:
		totalTime += delta
		transitionNode.position = lerp(transitionStartPoint, currentTarget.global_position, totalTime/0.75)
		if totalTime > 0.75:
			get_parent().remove_child(self)
			currentTarget.add_child(self)
			drag_horizontal_enabled = true
			drag_vertical_enabled = true

func setTarget(node: Node2D):
	if currentTarget == null:
		currentTarget = node
		get_parent().remove_child(self)
		node.add_child(self)
	else:
		drag_horizontal_enabled = false
		drag_vertical_enabled = false
		transitionStartPoint= currentTarget.position
		transitionNode.position = transitionStartPoint
		currentTarget = node
		get_parent().remove_child(self)
		transitionNode.add_child(self)
		position = Vector2.ZERO
	
