extends Trigger

class_name BlessTrigger
#preencher com atributos de identificação
func _init()-> void:
	self.triggerId = 27

func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageSkill and context.element == digimon.element):
		digimon.totalDamage *= 1.5
	return false
