extends Trigger

class_name FortitudeTrigger
#skill de cura
#preencher com atributos de identificação
func _init()-> void:
	self.triggerId = 9
#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(_digimon: Digimon, context) -> bool:
	if(context is DamageData and context.damageType == Enums.DamageType.MAGICAL):
		context.damageValue *= 0.7
	return false
