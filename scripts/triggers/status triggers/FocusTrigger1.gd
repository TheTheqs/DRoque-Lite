extends Trigger

class_name FocusTrigger1
var relatedFocus: Focus
#preencher com atributos de identificação
func _init(nFocus: Focus) -> void:
	self.triggerId = 35
	self.relatedFocus = nFocus

#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageData):
		if(Util.chance(50.0)):
			digimon.unapplyStatus(35)
	return false
