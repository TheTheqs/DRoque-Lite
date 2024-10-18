extends StatusEffect

class_name Focus
#value
func _init() -> void:
	self.statusId = 35
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.statusTriggers.append(FocusTrigger0.new(self))
	self.statusTriggers.append(FocusTrigger1.new(self))

func applyingEffect(digimon: Digimon) -> void:
	digimon.onCriticalCalc.append(statusTriggers[0])
	digimon.onGetDamage.append(statusTriggers[1])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onCriticalCalc.erase(statusTriggers[0])
	digimon.onGetDamage.erase(statusTriggers[1])

func getStatus() -> StatusEffect:
	return Focus.new()
