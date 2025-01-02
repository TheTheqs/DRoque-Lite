extends StatusEffect

class_name Cursed
#construtora
func _init() -> void:
	self.statusId = 14
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Cursed.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.isStackable = true
	self.stacks = 1
	self.stacksLimit = 10
	self.statusTriggers.append(CursedTrigger.new(self))

func applyingEffect(digimon: Digimon) -> void:
	digimon.onHealing.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onHealing.erase(self.statusTriggers[0])

func getStatus() -> StatusEffect:
	var newCursed: Cursed = Cursed.new()
	return newCursed
