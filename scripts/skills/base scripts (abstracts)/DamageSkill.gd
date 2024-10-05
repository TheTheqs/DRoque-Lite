extends Skill

class_name DamageSkill

#actvation atributtes
var manaCost: int
var ratio: float
var isCritic: bool
var damageValue: float
var hasEffect: bool
var element: Enums.Element
var atackerType: Enums.Type
var damageType: Enums.DamageType

#transferência de dados estáticos
func setStats(stats: DamageSkillData) -> void:
	self.skillId = stats.skillId
	self.skillName = stats.skillName
	self.skillIcon = stats.skillIcon
	self.skillDescritption = stats.skillDescription
	self.element = stats.element
	self.damageType = stats.damageType
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
	self.accuracy = digimon.getAccuracy()
	self.isCritic = Util.chance(digimon.getCriticalChance())
	
	
#A função abaixo só é usada quando o bool has stats for True
func applyStats(_digimon: Digimon) -> void:
	pass
#função abistrada que vai executar comandos específicos de cada skill caso houver
func skillSingularity() -> void:
	pass
