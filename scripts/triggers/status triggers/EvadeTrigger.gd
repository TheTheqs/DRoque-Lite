extends Trigger

class_name EvadeTrigger
var relatedEvade : Evade
#preencher com atributos de identificação
func _init(nEvade: Evade) -> void:
	self.triggerId = 19
	self.relatedEvade = nEvade

#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(digimon: Digimon, context) -> bool:
	if(digimon.gotHited and context is DamageSkill and context.damageSubType == Enums.DamageSubType.DIRECT):
		digimon.gotHited = false
		digimon.unapplyStatus(relatedEvade.statusId)
	return false
