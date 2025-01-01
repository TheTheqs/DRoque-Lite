extends Trigger

class_name FaithTrigger
var faith: Faith
#preencher com atributos de identificação
func _init(relatedFaith: Faith)-> void:
	self.triggerId = 11
	self.faith = relatedFaith
#funções de checagem. A primeira é para ser sobreescrita.

func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageSkill and context.damageType == Enums.DamageType.MAGICAL):
		var percentDamage: float = 1 + (faith.stacks*0.25)
		digimon.totalDamage *= percentDamage
	return false
