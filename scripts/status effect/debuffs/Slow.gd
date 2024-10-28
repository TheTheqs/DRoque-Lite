extends StatusEffect

class_name Slow
#construtora
func _init() -> void:
	self.statusId = 20
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Slow.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.statusTriggers.append(SlowTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onTurnStart.append(self.statusTriggers[0])
	digimon.onGettingActions.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onTurnStart.erase(self.statusTriggers[0])
	digimon.onGettingActions.erase(self.statusTriggers[0])

func getStatus() -> StatusEffect:
	var newSlow: Slow = Slow.new()
	newSlow.schance = self.schance
	return newSlow
