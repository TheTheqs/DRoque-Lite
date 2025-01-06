extends StatusEffect

class_name Doom
#construtora
func _init(nStacks: int) -> void:
	self.statusId = 26
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Doom.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.isStackable = true
	self.stacks = nStacks
	self.stacksLimit = 666
	self.statusTriggers.append(DoomTrigger.new(self))

func applyingEffect(digimon: Digimon) -> void:
	digimon.onTurnEnd.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onTurnEnd.erase(self.statusTriggers[0])

func getStatus() -> StatusEffect:
	return Doom.new(self.stacks)
