extends StatusEffect

class_name Blind
#construtora
func _init() -> void:
	self.statusId = 12
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
	return Blind.new()
