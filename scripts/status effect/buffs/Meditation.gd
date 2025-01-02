extends StatusEffect

class_name Meditation
#value
func _init() -> void:
	self.statusId = 17
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Meditation.png")
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.statusTriggers.append(MeditationTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onTurnStart.append(statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onTurnStart.erase(statusTriggers[0])

func getStatus() -> StatusEffect:
	return Meditation.new()
