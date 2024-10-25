extends Trigger

class_name BarrierTrigger
var relatedBarrier : Barrier
#preencher com atributos de identificação
func _init(nBarrier: Barrier) -> void:
	self.triggerId = 25
	self.relatedBarrier = nBarrier
#funções de checagem. A primeira é para ser sobreescrita.

func checkContext(digimon: Digimon, context) -> bool:
	if((context is DamageSkill and context.damageSubType == Enums.DamageSubType.DIRECT) or (context is StatusSkill and context.statusType == Enums.StatusType.DEBUFF)):
		digimon.getHited = false
		digimon.tamer.numberSpawner.spawnContent(tr(StringName(relatedBarrier.statusName)))
		relatedBarrier.discountStack(digimon)
	return false
