extends DamageSkill
#Essa é uma pseudo habilidade, significa que ela nao vai ser usada diretamente, e sim pelo efeito secundário de outra habilidade ou trigger.
class_name PoisonHit

var damageData: DamageData = DamageData.new()
func _init()-> void:
	damageData.buildData(Enums.DamageType.TRUE, Enums.DamageSubType.OVERTIME, Enums.Element.NEUTRAL, Enums.Type.SPECIAL, 0.0, false)
	self.needsAnimation = false

func priorityCheck(_digimon: Digimon) -> void:
	priority = 0

func effect(digimon: Digimon) -> void:
	var percentDamage: float =  Util.cap(randf_range(0.05, 0.2))
	damageData.damageValue = Util.cap(digimon.maxHelth*percentDamage)
	digimon.processDamage(damageData)
