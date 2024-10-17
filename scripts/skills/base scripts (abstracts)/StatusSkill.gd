extends Skill

class_name StatusSkill
#status skill
var statusEffects: Array[StatusEffect]
var statusType: Enums.StatusType

#transferência de dados estáticos
func setStats(stats: StatusSkillData) -> void:
	self.skillId = stats.skillId
	self.skillName = "SkillName" + str(self.skillId)
	self.skillIcon = stats.skillIcon
	self.skillDescritption = "SkillDescription" + str(self.skillId)
	self.staticPriority = stats.staticPriority
	self.manaCost = stats.manaCost
	self.cooldowm = stats.coolDown
	self.texture = stats.skillTexture
	self.textureRange = stats.textureRange

#função de ataque de fato
func effect(digimon: Digimon) -> void:
	skillSingularity(digimon)
	applyCooldown(digimon)
	digimon.manaConsumption(self.manaCost)
	if(self.statusType == Enums.StatusType.DEBUFF):
		digimon.enemy.getTageted(self)
	else:
		digimon.getTageted(self)
	if(digimon.tamer is Player):
		var player: Player = digimon.tamer
		player.buttonPanel.updateButtons()
		
	
#A função abaixo só é usada quando o bool has stats for True
func applyStats(_digimon: Digimon) -> void:
	pass
#função abistrada que vai executar comandos específicos de cada skill caso houver
func skillSingularity(_digimon: Digimon) -> void:
	pass
