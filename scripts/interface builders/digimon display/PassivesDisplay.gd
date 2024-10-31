extends Node2D

class_name PassivesDisplay
#elementos de cena
@export var display: DigimonDisplay
@export var passiveList: BoxContainer
#elemento de instância
var staticInfoCard: PackedScene = preload("res://scenes/entities/InfoCard.tscn")
#dicionário de cards ativos
var currentPassives: Dictionary = {
	
}

func addPass(newPassive: PassiveSkill) -> void:
	if(currentPassives.has(newPassive.skillId)):
		return
	else:
		var newCard: InfoCard = staticInfoCard.instantiate()
		newCard.buildCard(newPassive.skillIcon, tr(StringName(newPassive.skillName)), tr(StringName(newPassive.skillDescription)), display)
		currentPassives[newPassive.skillId] = newCard
		passiveList.call_deferred("add_child", newCard)
		display.allButtons.append(newCard.button)

func removePass(passId: int) -> void:
	if(currentPassives.has(passId)):
		currentPassives[passId].queue_free()
		display.allButtons.erase(currentPassives[passId].button)
		currentPassives.erase(passId)
	else:
		print("ERROR: Id not found")

func resetPassList(newPassives: Array) -> void:
	if(currentPassives.size() > 0):
		for passId in currentPassives:
			display.allButtons.erase(currentPassives[passId].button)
		Util.clearChildren(passiveList)
		currentPassives.clear()
	if(newPassives.size() > 0):
		for newPassive : PassiveSkill in newPassives:
			addPass(newPassive)
