extends Trigger

class_name ReflectTrigger
var relatedReflect: Reflect
#preencher com atributos de identificação
func _init(nReflect: Reflect) -> void:
	self.triggerId = 29
	self.relatedReflect = nReflect
	self.action = DeflectHit.new()
#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(_digimon: Digimon, context) -> bool:
	if(context is DamageData and context.damageSubType == Enums.DamageSubType.DIRECT):
		action.damageValue = Util.cap(context.damageValue*(float(relatedReflect.stacks)/100))
		return true
	else:
		return false
