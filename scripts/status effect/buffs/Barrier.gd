extends StatusEffect

class_name Barrier
#animação de barreira
var barrierAnimationScene: PackedScene = preload("res://scenes/entities/BarrierAnimation.tscn")
var barrierInstance: Node = null
#value
func _init(nstacks: int) -> void:
	self.statusId = 25
	self.setStats()
	self.statusType = Enums.StatusType.BUFF
	self.isStackable = true
	self.stacks = nstacks
	self.stacksLimit = 5
	self.statusTriggers.append(BarrierTrigger.new(self))

func applyingEffect(digimon: Digimon) -> void:
	digimon.onGotTargeted.append(statusTriggers[0])
	barrierInstance = barrierAnimationScene.instantiate()
	digimon.call_deferred("add_child", barrierInstance)

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onGotTargeted.erase(statusTriggers[0])
	if barrierInstance != null and barrierInstance.is_inside_tree():
		barrierInstance.queue_free() # Remove a instância da barreira

func effectOverlap(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(self.statusId)):
		var digimonBarrier: Barrier = digimon.statusEffect[self.statusId]
		if(digimonBarrier.stacks + self.stacks >= self.stacksLimit):
			digimonBarrier.stacks = stacksLimit
			digimon.BM.showMessage(tr(StringName("StackLimit")) + "("+tr(StringName(self.statusName)) +")")
		else:
			digimonBarrier.stacks += self.stacks

func discountStack(digimon: Digimon) -> void:
	self.stacks -= 1
	if(self.stacks <= 0):
		self.stacks = 0
		digimon.unapplyStatus(self.statusId)

func getStatus() -> StatusEffect:
	var newBarrier: Barrier = Barrier.new(self.stacks)
	return newBarrier
