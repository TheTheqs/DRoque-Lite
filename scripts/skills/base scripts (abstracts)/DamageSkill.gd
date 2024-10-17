extends Skill

class_name DamageSkill

#actvation atributtes
var ratio: float
var isCritic: bool
var damageValue: float
var hasEffect: bool
var element: Enums.Element
var atackerType: Enums.Type
var damageType: Enums.DamageType
var damageSubType: Enums.DamageSubType

#transferência de dados estáticos
func setStats(stats: DamageSkillData) -> void:
	self.skillId = stats.skillId
	self.skillName = "SkillName" + str(self.skillId)
	self.skillIcon = stats.skillIcon
	self.skillDescritption = "SkillDescription" + str(self.skillId)
	self.staticPriority = stats.staticPriority
	self.element = stats.element
	self.damageType = stats.damageType
	self.damageSubType = stats.damageSubType
	self.ratio = stats.ratio
	self.manaCost = stats.manaCost
	self.cooldowm = stats.coolDown
	self.hasEffect = stats.hasEffect
	self.texture = stats.skillTexture
	self.textureRange = stats.textureRange

#definição de status dinâmicos
func setValues(digimon: Digimon) -> void:
	self.atackerType = digimon.digimonType
	self.damageValue = digimon.getSkillDamage(self.damageType)
	self.damageValue *= ratio
	self.accuracy = digimon.getAccuracy(self, digimon.enemy)
	self.isCritic = Util.chance(digimon.getCriticalChance())
	if(self.isCritic):
		self.damageValue *= 1.5

#função de ataque de fato
func effect(digimon: Digimon) -> void:
	setValues(digimon)
	skillSingularity(digimon)
	applyCooldown(digimon)
	digimon.manaConsumption(self.manaCost)
	digimon.enemy.getTageted(self)
	if(digimon.tamer is Player):
		var player: Player = digimon.tamer
		player.buttonPanel.updateButtons()
	
#A função abaixo só é usada quando o bool has stats for True
func applyStats(_digimon: Digimon) -> void:
	pass
#função abistrada que vai executar comandos específicos de cada skill caso houver
func skillSingularity(_digimon: Digimon) -> void:
	pass
#essa função vai colaborar para o calculo de prioridade baseado no aumento o decremento de dano por diferença de elemento
func getElementalChartPriority(digimon: Digimon) -> int:
	var elementRatio: float = Util.getElementRatio(self.element, digimon.enemy.element)
	if(elementRatio == 1.0):
		return 0
	elif(elementRatio < 1.0):
		return -2
	else:
		return 2
