extends StatusEffect

class_name IntPlus
#value
func _init(nstacks: int) -> void:
	self.statusId = 44
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/IntPlus.png")
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.isStackable = true
	self.stacks = nstacks
	self.stacksLimit = 999

func applyingEffect(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(45)):
		var counterEffect: IntMinus = digimon.statusEffect[45]
		if(counterEffect.stacks > self.stacks):
			self.showIcon = false
			counterEffect.stacks -= self.stacks
			digimon.changeBonusAttribute("int", self.stacks)
			digimon.statusDisplay.changeIcon(digimon.statusDisplay.statusToShow[digimon.statusDisplay.currentShowing])
		elif(counterEffect.stacks < self.stacks):
			self.stacks -= counterEffect.stacks
			digimon.unapplyStatus(counterEffect.statusId)
			digimon.changeBonusAttribute("int", self.stacks)
		else:
			self.showIcon = false
			digimon.unapplyStatus(counterEffect.statusId)
	else:
		digimon.changeBonusAttribute("int", self.stacks)

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.changeBonusAttribute("int", -self.stacks)

func effectOverlap(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(self.statusId)):
		var digimonStatus: IntPlus = digimon.statusEffect[self.statusId]
		if(digimonStatus.stacks + self.stacks >= self.stacksLimit):
			var difference: int = abs(digimonStatus.stacks - stacksLimit)
			digimonStatus.stacks = stacksLimit
			digimon.changeBonusAttribute("int", difference)
			digimon.BM.showMessage(tr(StringName("StackLimit")) + "("+tr(StringName(self.statusName)) +")")
		else:
			digimonStatus.stacks += self.stacks
			digimon.changeBonusAttribute("int", self.stacks)
	

func getStatus() -> StatusEffect:
	var intPlus: IntPlus = IntPlus.new(self.stacks)
	return intPlus

func getAditionalDescription() -> String:
	var newString: String = ""
	if(self.isStackable):
		newString += "\n" + tr(StringName("INT")) + " +" + str(self.stacks)
	if(self.isExpirable):
		newString += "\n" + tr(StringName("Duration")) + ": " + str(self.duration)
	return newString
