extends Trigger

class_name ExhaustTrigger
#preencher com atributos de identificação
func _init()-> void:
	self.triggerId = 30
#funções de checagem. A primeira é para ser sobreescrita.

func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageSkill):
		digimon.totalDamage = Util.cap(digimon.totalDamage*0.7)
	return false
