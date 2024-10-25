extends Node2D

class_name BarrierAnimation

@export var barrier: Sprite2D
@export var animator: AnimationPlayer
@export var restart: Timer

func _ready():
	animator.play("action")

func restartAnimation() -> void:
	barrier.visible = true
	animator.play("action")

func animeFinished(animName) -> void:
	if(animName == "action"):
		barrier.visible = false
		restart.start(1.1)
