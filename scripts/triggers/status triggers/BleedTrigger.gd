extends Trigger

class_name BleedTrigger
var relatedBleed: Bleed
#preencher com atributos de identificação
func _init(newBleed: Bleed)-> void:
	self.triggerId = 10
	self.relatedBleed = newBleed

#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(_digimon: Digimon, context) -> bool:
	if(context is String and context == "TurnEnd"):
		self.action = BleedHit.new(relatedBleed.stacks)
		return true
	else:
		return false
