extends StatusEffect

class_name StrMinus
#value
func _init(nstacks: int) -> void:
	self.statusId = 43
	self.schance = -1
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/StrMinus.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.isStackable = true
	self.stacks = nstacks
	self.stacksLimit = 999

func applyingEffect(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(42)):
		var counterEffect: StrPlus = digimon.statusEffect[42]
		if(counterEffect.stacks > self.stacks):
			self.showIcon = false
			counterEffect.stacks -= self.stacks
			digimon.changeBonusAttribute("str", -self.stacks)
			digimon.statusDisplay.changeIcon(digimon.statusDisplay.statusToShow[digimon.statusDisplay.currentShowing])
		elif(counterEffect.stacks < self.stacks):
			self.stacks -= counterEffect.stacks
			digimon.unapplyStatus(counterEffect.statusId)
			digimon.changeBonusAttribute("str", -self.stacks)
		else:
			self.showIcon = false
			digimon.unapplyStatus(counterEffect.statusId)
	else:
		digimon.changeBonusAttribute("str", -self.stacks)

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.changeBonusAttribute("str", self.stacks)

func effectOverlap(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(self.statusId)):
		var digimonStatus: StrMinus = digimon.statusEffect[self.statusId]
		if(digimonStatus.stacks + self.stacks >= self.stacksLimit):
			var difference: int = abs(digimonStatus.stacks - stacksLimit)
			digimonStatus.stacks = stacksLimit
			digimon.changeBonusAttribute("str", -difference)
			digimon.BM.showMessage(tr(StringName("StackLimit")) + "("+tr(StringName(self.statusName)) +")")
		else:
			digimonStatus.stacks += self.stacks
			digimon.changeBonusAttribute("str", -self.stacks)

func getStatus() -> StatusEffect:
	var strMinus: StrMinus = StrMinus.new(self.stacks)
	return strMinus
func getAditionalDescription() -> String:
	var newString: String = ""
	if(self.isStackable):
		newString += "\n" + tr(StringName("STR")) + " " + str(self.stacks)
	if(self.isExpirable):
		newString += "\n" + tr(StringName("Duration")) + ": " + str(self.duration)
	return newString
