extends Trigger

class_name EvadeTrigger
var relatedEvade : Evade
#preencher com atributos de identificação
func _init(nEvade: Evade) -> void:
	self.triggerId = 19
	self.relatedEvade = nEvade

#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(digimon: Digimon, context) -> bool:
	if(digimon.gotHited and self.isMark(context) == false):
		digimon.gotHited = false
		digimon.unapplyStatus(relatedEvade.statusId)
	return false

func isMark(element) -> bool:
	if(element is StatusEffect and element.statusId == 18):
		return true
	else:
		return false
