extends StatusEffect

class_name Exhaust
#construtora
func _init() -> void:
	self.statusId = 30
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.statusTriggers.append(ExhaustTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onDamageCalc.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onDamageCalc.erase(self.statusTriggers[0])

func getStatus() -> StatusEffect:
	return Exhaust.new()
