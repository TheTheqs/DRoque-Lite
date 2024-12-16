extends DamageSkill

class_name DeathParadeBlaster
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/DeathParadeBlaster.tres")
func _init():
	self.isGlobal = true #a declaração de skill global deve estar no init do script, e não no recurso.
	setStats(skillData)

#função de cálculo de prioridade
func priorityCheck(digimon: Digimon) -> void:
	if(Util.getProportion(digimon.enemy.currentMana, digimon.enemy.maxMana) > 0.5):
		priority += 2

func applyStats(digimon: Digimon) -> void:
	var consumedMana : float = Util.cap(digimon.maxMana*0.5)
	digimon.manaConsumption(consumedMana)
