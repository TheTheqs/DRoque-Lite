extends Node

class_name Digimon

#Database info
var DigimonId: int
var DigimonName: String
var DigimonDescription: String

#Scene Elements
@export var DigimonSprite: Sprite2D
@export var DigimonAnimator: AnimationPlayer

#Status Control
var ItsDisable: bool = false
var ItsBlind: bool = false

func _ready():
	if(not ItsDisable):
		DigimonAnimator.play("Idle")
	if(self.position.x < 140):
		DigimonSprite.flip_h = true
