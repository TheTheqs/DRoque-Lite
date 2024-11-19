extends StatusEffect

class_name AgiMinus
#value
func _init(nstacks: int) -> void:
	self.statusId = 47
	self.schance = -1
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/AgiMinus.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.isStackable = true
	self.stacks = nstacks
	self.stacksLimit = 999

func applyingEffect(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(46)):
		var counterEffect: AgiPlus = digimon.statusEffect[46]
		if(counterEffect.stacks > self.stacks):
			self.showIcon = false
			counterEffect.stacks -= self.stacks
			digimon.changeBonusAttribute("agi", -self.stacks)
			digimon.statusDisplay.changeIcon(digimon.statusDisplay.statusToShow[digimon.statusDisplay.currentShowing])
		elif(counterEffect.stacks < self.stacks):
			self.stacks -= counterEffect.stacks
			digimon.unapplyStatus(counterEffect.statusId)
			digimon.changeBonusAttribute("agi", -self.stacks)
		else:
			self.showIcon = false
			digimon.unapplyStatus(counterEffect.statusId)
	else:
		digimon.changeBonusAttribute("agi", -self.stacks)

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.changeBonusAttribute("agi", self.stacks)

func effectOverlap(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(self.statusId)):
		var digimonStatus: AgiMinus = digimon.statusEffect[self.statusId]
		if(digimonStatus.stacks + self.stacks >= self.stacksLimit):
			var difference: int = abs(digimonStatus.stacks - stacksLimit)
			digimonStatus.stacks = stacksLimit
			digimon.changeBonusAttribute("agi", -difference)
			digimon.BM.showMessage(tr(StringName("StackLimit")) + "("+tr(StringName(self.statusName)) +")")
		else:
			digimonStatus.stacks += self.stacks
			digimon.changeBonusAttribute("agi", -self.stacks)

func getStatus() -> StatusEffect:
	var agiMinus: AgiMinus = AgiMinus.new(self.stacks)
	return agiMinus

func getAditionalDescription() -> String:
	var newString: String = ""
	if(self.isStackable):
		newString += "\n" + tr(StringName("AGI")) + " " + str(self.stacks)
	if(self.isExpirable):
		newString += "\n" + tr(StringName("Duration")) + ": " + str(self.duration)
	return newString
