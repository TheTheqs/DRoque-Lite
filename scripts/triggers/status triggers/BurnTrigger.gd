extends Trigger

class_name BurnTrigger
#preencher com atributos de identificação
func _init()-> void:
	action = BurnHit.new()
	self.triggerId = 0

#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(_digimon: Digimon, context) -> bool:
	if(context is String and context == "TurnEnd"):
		return true
	else:
		return false
