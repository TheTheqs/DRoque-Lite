extends DamageSkill
#Essa é uma pseudo habilidade, significa que ela nao vai ser usada diretamente, e sim pelo efeito secundário de outra habilidade ou trigger.
class_name PoisonHit
var skillData: DamageSkillData = load("res://resources/skills/pseudo skills/PoisonHit.tres")

func _init():
	setStats(skillData)
	self.isSlow = true
	self.needsAnimation = false

func priorityCheck(_digimon: Digimon) -> void:
	priority = 0

func skillSingularity(digimon: Digimon) -> void:
	self.isCritic = false
	self.accuracy = -1
	var percentDamage: float =  Util.cap(randf_range(0.05, 0.2))
	self.damageValue = Util.cap(digimon.maxHelth*percentDamage)

func effect(digimon: Digimon) -> void:
	setValues(digimon)
	skillSingularity(digimon)
	digimon.getTageted(self)
	if(digimon.tamer is Player):
		var player: Player = digimon.tamer
		player.buttonPanel.updateButtons()
