extends StatusEffect

class_name Blind
#construtora
func _init() -> void:
	self.statusId = 12
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Blind.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.statusTriggers.append(BlindTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(23)):
		digimon.unapplyStatus(23)
	digimon.onAccuracyCalc.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onAccuracyCalc.erase(self.statusTriggers[0])

func getStatus() -> StatusEffect:
	var newBlind: Blind = Blind.new()
	newBlind.schance = self.schance
	return newBlind
