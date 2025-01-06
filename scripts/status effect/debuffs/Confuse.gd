extends StatusEffect

class_name Confuse
#construtora
func _init(nDuration: int) -> void:
	self.statusId = 34
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Confuse.png")
	self.setStats()
	self.isExpirable = true
	self.canCount = true
	self.duration = nDuration
	self.statusType = Enums.StatusType.DEBUFF
	self.statusTriggers.append(ConfuseTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onActing.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.enemy = digimon.tamer.opponent.digimon
	digimon.onActing.erase(self.statusTriggers[0])

func getStatus() -> StatusEffect:
	return Confuse.new(self.duration)
