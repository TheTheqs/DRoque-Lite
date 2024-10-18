extends DamageSkill
#Essa é uma pseudo habilidade, significa que ela nao vai ser usada diretamente, e sim pelo efeito secundário de outra habilidade ou trigger.
class_name GulibleGust2
var skillData: DamageSkillData = load("res://resources/skills/pseudo skills/GulibleGust2.tres")

func _init():
	setStats(skillData)

func priorityCheck(_digimon: Digimon) -> void:
	priority = 0
