extends StatusEffect

class_name Petrify
#construtora
func _init(nstacks: int) -> void:
	self.statusId = 16
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Petrify.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.isStackable = true
	self.stacks = nstacks
	self.stacksLimit = 100

func applyingEffect(digimon: Digimon) -> void:
	self.checkStacks(digimon)

func effectOverlap(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(self.statusId)):
		var digimonStatus: Petrify = digimon.statusEffect[self.statusId]
		if(digimonStatus.stacks + self.stacks >= self.stacksLimit):
			digimonStatus.stacks = stacksLimit
			digimon.BM.showMessage(tr(StringName("StackLimit")) + "("+tr(StringName(self.statusName)) +")")
		else:
			digimonStatus.stacks += self.stacks
	self.checkStacks(digimon)

func getStatus() -> StatusEffect:
	var newBleed: Bleed  = Bleed.new(self.stacks)
	newBleed.schance = self.schance
	return newBleed

func checkStacks(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(self.statusId)):
		var digimonStatus: Petrify = digimon.statusEffect[self.statusId]
		if(digimonStatus.stacks == 100):
			digimon.BTM.inAction("Petrify") #Essa chamada é necessária pq dying faz uma chamada para outaction
			digimon.dying(true)
