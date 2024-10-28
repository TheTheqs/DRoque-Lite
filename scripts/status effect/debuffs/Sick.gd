extends StatusEffect

class_name Sick
#construtora
func _init() -> void:
	self.statusId = 28
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Sick.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.statusTriggers.append(SickTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onHealing.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onHealing.erase(self.statusTriggers[0])

func getStatus() -> StatusEffect:
	var newSick: Sick = Sick.new()
	newSick.schance = self.schance
	return newSick
