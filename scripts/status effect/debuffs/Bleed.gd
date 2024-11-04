extends StatusEffect

class_name Bleed
#construtora
func _init(nstacks: int) -> void:
	self.statusId = 10
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Bleed.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.isStackable = true
	self.stacks = nstacks
	self.stacksLimit = 6
	self.statusTriggers.append(BleedTrigger.new(self))

func applyingEffect(digimon: Digimon) -> void:
	digimon.onTurnEnd.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onTurnEnd.erase(self.statusTriggers[0])

func effectOverlap(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(self.statusId)):
		var digimonStatus: Bleed = digimon.statusEffect[self.statusId]
		if(digimonStatus.stacks + self.stacks >= self.stacksLimit):
			digimonStatus.stacks = stacksLimit
			digimon.BM.showMessage(tr(StringName("StackLimit")) + "("+tr(StringName(self.statusName)) +")")
		else:
			digimonStatus.stacks += self.stacks

func getStatus() -> StatusEffect:
	var newBleed: Bleed  = Bleed.new(self.stacks)
	newBleed.schance = self.schance
	return newBleed
