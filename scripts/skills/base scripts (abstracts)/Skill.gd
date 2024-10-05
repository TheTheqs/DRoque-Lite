extends Node

class_name Skill
#Identificação
var skillId: int
var skillName: String
var skillDescritption: String
var skillIcon: CompressedTexture2D

#elementos de controle
var usable: bool = true
var accuracy : int
var cooldowm: int
var currentCooldown: int = 0 #valor zero por padrão

#scene elements
var texture: CompressedTexture2D
var textureRange: int

#learning and unlearning abstract functions
func learn(learner: Digimon, index: int) -> bool:
	learner.digimonSkills[index] = self
	return true

func unlearn(_unlearner: Digimon) -> void:
	pass

#função que aplica o cooldown depois do uso
func applyCooldown() -> void:
	currentCooldown = cooldowm
	if(currentCooldown > 0):
		usable = false

#função que vai deminuir o cooldown a cada fim de turno.
func countCooldown() -> void:
	if(currentCooldown > 0):
		currentCooldown -= 1
		if(currentCooldown == 0):
			usable = true
