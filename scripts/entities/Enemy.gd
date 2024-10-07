extends Tamer

class_name Enemy

func _ready() -> void:
	summonDigimon(Util.random(0, 5))
	#teste de habilidades.
	digimon.learnSkill(BasicAtack.new())
	#atualização da interface. Sempre a última coisa a se fazer!
	HUDD.updateValues()
