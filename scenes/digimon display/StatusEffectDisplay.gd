extends Node2D

class_name StatusEffectDisplay
#elementos de cena
@export var display: DigimonDisplay
@export var statusList: BoxContainer
@export var builtTimer: Timer
#elemento de instância
var staticInfoCard: PackedScene = preload("res://scenes/entities/InfoCard.tscn")
var newStatusE: Array = []
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

func resetStatusList(newCards: Array) -> void:
	if(currentStatus.size() > 0):
		for statusId in currentStatus:
			display.allButtons.erase(currentStatus[statusId].button)
		Util.clearChildren(statusList)
		currentStatus.clear()
	newStatusE.clear()
	newStatusE = newCards
	builtTimer.call_deferred("start", 0.1)

func buildList() -> void:
	if(newStatusE.size() > 0):
		for newStat : StatusEffect in newStatusE:
			addStatus(newStat)
