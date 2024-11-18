extends StatusEffect

class_name Burn
#construtora
func _init() -> void:
	self.statusId = 2
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Burn.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.statusTriggers.append(BurnTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onTurnEnd.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onTurnEnd.erase(self.statusTriggers[0])

func getStatus() -> StatusEffect:
	var newBurn: Burn  = Burn.new()
	newBurn.schance = self.schance
	return newBurn
