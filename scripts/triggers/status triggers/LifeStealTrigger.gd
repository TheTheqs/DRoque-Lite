extends Trigger

class_name LifeStealTrigger
var relatedLifeSteal : LifeSteal
#skill de cura
#preencher com atributos de identificação
func _init(nRelatedLifeSteal: LifeSteal)-> void:
	self.triggerId = 33
	self.action = LifeStealHeal.new()
	relatedLifeSteal = nRelatedLifeSteal
#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(_digimon: Digimon, context) -> bool:
	if(context is DamageData and context.damageSubType == Enums.DamageSubType.DIRECT):
		action.healValue = (context.damageValue * relatedLifeSteal.stacks)/100
		return true
	else:
		return false
