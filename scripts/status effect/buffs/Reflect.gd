extends StatusEffect

class_name Reflect
#value
func _init(nstacks: int) -> void:
	self.statusId = 29
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Reflect.png")
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.isStackable = true
	self.stacks = nstacks
	self.stacksLimit = 60
	self.statusTriggers.append(ReflectTrigger.new(self))

func applyingEffect(digimon: Digimon) -> void:
	digimon.onGetDamage.append(statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onGetDamage.erase(statusTriggers[0])

func effectOverlap(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(self.statusId)):
		var digimonReflect: Reflect = digimon.statusEffect[29]
		if(digimonReflect.stacks + self.stacks >= self.stacksLimit):
			digimonReflect.stacks = 60
			digimon.BM.showMessage(tr(StringName("StackLimit")) + "("+tr(StringName(self.statusName)) +")")
		else:
			digimonReflect.stacks += self.stacks

func getStatus() -> StatusEffect:
	var newReflect: Reflect = Reflect.new(self.stacks)
	return newReflect

func getAditionalDescription() -> String:
	var newString: String = ""
	if(self.isStackable):
		newString += "\n" + tr(StringName("Reflect")) + str(self.stacks) + "%"
	if(self.isExpirable):
		newString += "\n" + tr(StringName("Duration")) + ": " + str(self.duration)
	return newString
