extends Trigger

class_name BraveryTrigger
var bravery: Bravery
#preencher com atributos de identificação
func _init(relatedBravery: Bravery)-> void:
	self.triggerId = 3
	self.bravery = relatedBravery
#funções de checagem. A primeira é para ser sobreescrita.

func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageSkill and context.damageType == Enums.DamageType.PHYSICAL):
		var percentDamage: float = 1 + (bravery.stacks*0.25)
		digimon.totalDamage *= percentDamage
	return false
