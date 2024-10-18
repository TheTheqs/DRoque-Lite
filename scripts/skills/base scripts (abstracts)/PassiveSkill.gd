extends Skill

class_name PassiveSkill
#triggers
var skillTriggers: Array[Trigger]

func setStats(stats: PassiveSkillData) -> void:
	self.skillId = stats.skillId
	self.skillName = "SkillName" + str(self.skillId)
	self.skillIcon = stats.skillIcon
	self.skillDescription = "SkillDescription" + str(self.skillId)
	self.cooldowm = stats.cooldown
	if(stats.triggers.size() > 0):
		for ntrigger: Script in stats.triggers:
			self.skillTriggers.append(ntrigger.new(self))

func effect(digimon: Digimon) -> void:
	skillSingularity(digimon)
	applyCooldown(digimon)
	if(digimon.tamer is Player):
		var player: Player = digimon.tamer
		player.buttonPanel.updateButtons()

#essa skill singularity é a função real que fará o efeito da habilidade passiva
func skillSingularity(_digimon: Digimon) -> void:
	pass
