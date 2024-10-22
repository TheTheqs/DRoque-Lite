extends Trigger

class_name PoisonTrigger
#variável de contole para impedir loops
var hited: bool = false
#preencher com atributos de identificação
func _init()-> void:
	action = PoisonHit.new()
	self.triggerId = 0

#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(_digimon: Digimon, context) -> bool:
	if(context is String and context == "TurnEnd" and not hited):
		hited = true
		return true
	else:
		hited = false
		return false
