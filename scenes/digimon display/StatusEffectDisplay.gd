extends Node2D

class_name StatusEffectDisplay
#elementos de cena
@export var display: DigimonDisplay
@export var statusList: BoxContainer
#elemento de instância
var staticInfoCard: PackedScene = preload("res://scenes/entities/InfoCard.tscn")
#dicionário de cards ativos
var currentStatus: Dictionary = {
	
}

func addStatus(newStatus: StatusEffect) -> void:
	if(currentStatus.has(newStatus.statusId)):
		return
	else:
		var newCard: InfoCard = staticInfoCard.instantiate()
		newCard.buildCard(newStatus.statusIcon, tr(StringName(newStatus.statusName)), tr(StringName(newStatus.statusDescription)), display, false)
		currentStatus[newStatus.statusId] = newCard
		statusList.call_deferred("add_child", newCard)
		display.allButtons.append(newCard.button)

func resetStatusList(newStatus: Array) -> void:
	if(currentStatus.size() > 0):
		for statusId in currentStatus:
			display.allButtons.erase(currentStatus[statusId].button)
		Util.clearChildren(statusList)
		currentStatus.clear()
	if(newStatus.size() > 0):
		for newStat : StatusEffect in newStatus:
			addStatus(newStat)
