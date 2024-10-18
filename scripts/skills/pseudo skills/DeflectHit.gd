extends DamageSkill
#Essa é uma pseudo habilidade, significa que ela nao vai ser usada diretamente, e sim pelo efeito secundário de outra habilidade ou trigger.
class_name DeflectHit
var damageData: DamageData = DamageData.new()
func _init()-> void:
	damageData.buildData(Enums.DamageType.TRUE, Enums.DamageSubType.DEFLECT, Enums.Element.NEUTRAL, Enums.Type.SPECIAL, 0.0, false)

func priorityCheck(_digimon: Digimon) -> void:
	priority = 0

func effect(digimon: Digimon) -> void:
	digimon.enemy.processDamage(damageData)
