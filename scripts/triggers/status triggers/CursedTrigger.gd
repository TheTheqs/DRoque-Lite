extends Trigger

class_name CursedTrigger
var relatedCursed: Cursed
#preencher com atributos de identificação
func _init(nCursed: Cursed)-> void:
	self.triggerId = 14
	self.relatedCursed = nCursed
	action = CurseHit.new(self.relatedCursed)

#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(_digimon: Digimon, context) -> bool:
	if(context is HealData):
		return true
	else:
		return false
