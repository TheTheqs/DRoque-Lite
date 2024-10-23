extends Trigger

class_name SlowTrigger
#preencher com atributos de identificação
var getDebuff: bool
func _init()-> void:
	self.triggerId = 20

func checkContext(digimon: Digimon, context) -> bool:
	if(context is int and getDebuff == false):
		getDebuff = true
		digimon.tamer.showContent(Slow.new())
		digimon.gainActions = 0
	elif(context is String and context == "TurnStart"):
		getDebuff = false
	return false
