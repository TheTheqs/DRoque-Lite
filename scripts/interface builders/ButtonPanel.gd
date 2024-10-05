extends Node

class_name ButtonPanel
#Elementos da Cena
@export var relatedPlayer: Player
@export var relatedDigimon: Digimon
#Botões
@export var allButtons: Array[Button]
@export var skillButtons: Array[Button]
#função que relaciona cada skill com um botão
func setButtons() -> void:
	for i in range(relatedDigimon.digimonSkills.size()):
		if(relatedDigimon.digimonSkills[i] != null):
			skillButtons[i].icon = relatedDigimon.digimonSkills[i].skillIcon
		else:
			skillButtons[i].visible = false

func updateButtons() -> void:
	for i in range(skillButtons.size()):
		if(relatedDigimon.digimonSkills[i] != null):
			var relatedButton: Button = skillButtons[i]
			if(relatedDigimon.digimonSkills[i].currentCooldown > 0):
				relatedButton.disabled = true
				relatedButton.text = str(relatedDigimon.digimonSkills[i].currentCooldown)
			elif(relatedDigimon.digimonSkills[i].currentCooldown == 0):
				relatedButton.disabled = false
				relatedButton.text = ""
