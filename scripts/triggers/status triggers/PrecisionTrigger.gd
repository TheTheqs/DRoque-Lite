extends Trigger

class_name PrecisionTrigger
#preencher com atributos de identificação
func _init()-> void:
	self.triggerId = 23
#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(digimon: Digimon, context) -> bool:
	if(context is Skill):
		digimon.currentAccuracy *= 2
	return false
