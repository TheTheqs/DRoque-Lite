extends StatusEffect

class_name Protect
#value
func _init() -> void:
	self.statusId = 5
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Protect.png")
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.statusTriggers.append(ProtectTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onGetDamage.append(statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onGetDamage.erase(statusTriggers[0])

func getStatus() -> StatusEffect:
	var newProtect: Protect = Protect.new()
	return newProtect
