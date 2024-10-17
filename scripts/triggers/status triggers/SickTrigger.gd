extends Trigger

class_name SickTrigger
#preencher com atributos de identificação
func _init()-> void:
	self.isActionTrigger = false
	self.triggerId = 28
#funções de checagem. A primeira é para ser sobreescrita.

func checkContext(_digimon: Digimon, context) -> bool:
	if(context is HealData):
		context.healValue = Util.cap(context.healValue/2)
	return false
