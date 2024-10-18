extends StatusEffect

class_name Reflect
#value
func _init() -> void:
	self.statusId = 29
	self.statusType = Enums.StatusType.BUFF
	self.isStackable = true
	self.stacks = 0
	self.statusTriggers.append(ReflectTrigger.new(self))

func applyingEffect(digimon: Digimon) -> void:
	digimon.onGetDamage.append(statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onGetDamage.erase(statusTriggers[0])

func effectOverlap(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(self.statusId)):
		var digimonReflect: Reflect = digimon.statusEffect[29]
		if(digimonReflect.stacks + self.stacks >= 60):
			digimonReflect.stacks = 60
			digimon.BM.showMessage(tr(StringName("StackLimit")) + "("+tr(StringName(self.statusName)) +")")
		else:
			digimonReflect.stacks += self.stacks
