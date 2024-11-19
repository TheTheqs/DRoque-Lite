extends StatusEffect

class_name Bravery
#value
func _init(nstacks: int) -> void:
	self.statusId = 3
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Bravery.png")
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.isStackable = true
	self.stacks = nstacks
	self.stacksLimit = 4
	self.statusTriggers.append(BraveryTrigger.new(self))

func applyingEffect(digimon: Digimon) -> void:
	digimon.onDamageCalc.append(statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onDamageCalc.erase(statusTriggers[0])

func effectOverlap(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(self.statusId)):
		var digimonStatus: Bravery = digimon.statusEffect[self.statusId]
		if(digimonStatus.stacks + self.stacks >= self.stacksLimit):
			digimonStatus.stacks = stacksLimit
			digimon.BM.showMessage(tr(StringName("StackLimit")) + "("+tr(StringName(self.statusName)) +")")
		else:
			digimonStatus.stacks += self.stacks

func getStatus() -> StatusEffect:
	var newBravery: Bravery = Bravery.new(self.stacks)
	return newBravery
