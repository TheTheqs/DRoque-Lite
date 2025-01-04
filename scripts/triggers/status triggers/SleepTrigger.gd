extends Trigger

class_name SleepTrigger

#preencher com atributos de identificação
func _init() -> void:
	self.triggerId = 22

#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageData or (context is String and context == "TurnStart")):
		print("Tentando")
		if(Util.chance(31.0)):
			print("Deu certo!")
			digimon.unapplyStatus(22)
	return false
