extends StatusEffect

class_name Fortitude
#value
func _init() -> void:
	self.statusId = 9
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Fortitude.png")
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.statusTriggers.append(FortitudeTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onGetDamage.append(statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onGetDamage.erase(statusTriggers[0])

func getStatus() -> StatusEffect:
	var newFortitude: Fortitude = Fortitude.new()
	return newFortitude
