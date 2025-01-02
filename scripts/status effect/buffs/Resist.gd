extends StatusEffect

class_name Resist
#value
func _init() -> void:
	self.statusId = 13
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Resist.png")
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.statusTriggers.append(ResistTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onBeforeGettingStats.append(statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onBeforeGettingStats.erase(statusTriggers[0])

func getStatus() -> StatusEffect:
	var newResist: Resist = Resist.new()
	return newResist
