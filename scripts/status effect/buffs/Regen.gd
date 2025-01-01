extends StatusEffect

class_name Regen
#value
func _init() -> void:
	self.statusId = 7
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Regen.png")
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.statusTriggers.append(RegenTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onTurnStart.append(statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onTurnStart.erase(statusTriggers[0])

func getStatus() -> StatusEffect:
	return Regen.new()
