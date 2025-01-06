extends StatusEffect

class_name Bless
#value
func _init() -> void:
	self.statusId = 27
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Bless.png")
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.statusTriggers.append(BlessTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onDamageCalc.append(statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onDamageCalc.erase(statusTriggers[0])

func getStatus() -> StatusEffect:
	return Bless.new()
