extends Node

class_name Digimon

#Database info
var digimonId: int
var digimonName: String
var digimonDescription: String

#Scene Elements
@export var digimonSprite: Sprite2D
@export var digimonAnimator: AnimationPlayer
@export var tamer: Tamer

#Status Control
var isDisabled: bool = false
var isBlind: bool = false

func setBehave() -> void:
	if(not isDisabled):
		digimonAnimator.play("Idle")
	if(self.position.x < 140):
		digimonSprite.flip_h = true

func setStats(stats: DigimonData) -> void:
	self.digimonId = stats.digimonId
	self.digimonName = stats.digimonName
	self.digimonSprite.texture = stats.digimonTexture
	setBehave()
