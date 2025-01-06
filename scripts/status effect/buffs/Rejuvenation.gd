extends StatusEffect

class_name Rejuvenation
#value
func _init(nDuration: int) -> void:
	self.statusId = 37
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Rejuvenation.png")
	self.setStats()
	self.isExpirable = true
	self.canCount = false
	self.duration = nDuration
	self.statusType = Enums.StatusType.BUFF
	self.statusTriggers.append(RejuvenationTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onTurnStart.append(statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onTurnStart.erase(statusTriggers[0])

func getStatus() -> StatusEffect:
	return Rejuvenation.new(self.duration)
