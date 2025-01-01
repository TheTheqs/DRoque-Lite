extends Trigger

class_name ProtectTrigger
#skill de cura
#preencher com atributos de identificação
func _init()-> void:
	self.triggerId = 5
#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(_digimon: Digimon, context) -> bool:
	if(context is DamageData and context.damageType == Enums.DamageType.PHYSICAL):
		context.damageValue *= 0.7
	return false
