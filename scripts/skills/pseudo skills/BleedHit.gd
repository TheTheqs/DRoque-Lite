extends DamageSkill
#Essa é uma pseudo habilidade, significa que ela nao vai ser usada diretamente, e sim pelo efeito secundário de outra habilidade ou trigger.
class_name BleedHit
var skillData: DamageSkillData = load("res://resources/skills/pseudo skills/BleedHit.tres")
var stacks: int
func _init(nstacks: int):
	setStats(skillData)
	self.stacks = nstacks
	self.needsAnimation = false

func priorityCheck(_digimon: Digimon) -> void:
	priority = 0

func skillSingularity(digimon: Digimon) -> void:
	self.isCritic = false
	self.accuracy = -1
	var percentDamage: float =  0.07*stacks
	self.damageValue = Util.cap(digimon.maxHelth*percentDamage)

func effect(digimon: Digimon) -> void:
	setValues(digimon)
	skillSingularity(digimon)
	digimon.getTageted(self)
	if(digimon.tamer is Player):
		var player: Player = digimon.tamer
		player.buttonPanel.updateButtons()
