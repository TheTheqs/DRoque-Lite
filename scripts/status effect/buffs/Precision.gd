extends StatusEffect

class_name Precision
#value
func _init() -> void:
	self.statusId = 23
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.statusTriggers.append(PrecisionTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(12)):
		digimon.unapplyStatus(12)
	digimon.onAccuracyCalc.append(statusTriggers[0])


func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onAccuracyCalc.erase(statusTriggers[0])

func getStatus() -> StatusEffect:
	return Precision.new()
