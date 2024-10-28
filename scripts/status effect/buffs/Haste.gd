extends StatusEffect

class_name Haste
#value
func _init(nDuration: int) -> void:
	self.statusId = 1
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Haste.png")
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.isExpirable = true
	self.canCount = false
	self.duration = nDuration
	self.statusTriggers.append(HasteTrigger.new(self))

func applyingEffect(digimon: Digimon) -> void:
	digimon.onTurnStart.append(statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onTurnStart.erase(statusTriggers[0])

func effectOverlap(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(self.statusId)):
		var digimonHaste: Haste = digimon.statusEffect[1]
		if(digimonHaste.duration < self.duration):
			digimonHaste.duration = self.duration

func getStatus() -> StatusEffect:
	return Haste.new(self.duration)
