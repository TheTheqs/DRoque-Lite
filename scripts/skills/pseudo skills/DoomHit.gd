extends DamageSkill
#Essa é uma pseudo habilidade, significa que ela nao vai ser usada diretamente, e sim pelo efeito secundário de outra habilidade ou trigger.
class_name DoomHit
var skillData: DamageSkillData = load("res://resources/skills/pseudo skills/DoomHit.tres")

func _init():
	setStats(skillData)
	self.isSlow = true
	self.needsAnimation = false

func priorityCheck(_digimon: Digimon) -> void:
	priority = 0

func skillSingularity(_digimon: Digimon) -> void:
	self.isCritic = false
	self.accuracy = -1

#o efeito que de fato vai matar o monstro
func applyStats(digimon: Digimon) -> void:
	digimon.dying(true)

func effect(digimon: Digimon) -> void:
	setValues(digimon)
	skillSingularity(digimon)
	digimon.getTageted(self)
	if(digimon.tamer is Player):
		var player: Player = digimon.tamer
		player.buttonPanel.updateButtons()
