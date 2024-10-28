extends StatusEffect

class_name LifeSteal
#value
func _init(nstacks: int) -> void:
	self.statusId = 33
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/LifeSteal.png")
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.isStackable = true
	self.stacks = nstacks
	self.stacksLimit = 100
	self.statusTriggers.append(LifeStealTrigger.new(self))

func applyingEffect(digimon: Digimon) -> void:
	digimon.onDamageDelt.append(statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onDamageDelt.erase(statusTriggers[0])

func effectOverlap(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(self.statusId)):
		var digimonStatus: Reflect = digimon.statusEffect[self.statusId]
		if(digimonStatus.stacks + self.stacks >= self.stacksLimit):
			digimonStatus.stacks = stacksLimit
			digimon.BM.showMessage(tr(StringName("StackLimit")) + "("+tr(StringName(self.statusName)) +")")
		else:
			digimonStatus.stacks += self.stacks

func getStatus() -> StatusEffect:
	var newLifeSteal: LifeSteal = LifeSteal.new(self.stacks)
	return newLifeSteal
