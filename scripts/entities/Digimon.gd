extends Node

class_name Digimon

#Database info
var digimonId: int
var digimonName: String
var digimonDescription: String
#enums
var element: Enums.Element
var digimonTier: Enums.Tier
var digimonType: Enums.Type
#atributos base.
var baseSTR: int 
var baseINT: int
var baseAGI: int
var baseVIT: int
var baseWIS: int
var baseDEX: int
#atributo bonus.
var bonusSTR: int
var bonusINT: int
var bonusAGI: int
var bonusVIT: int
var bonusWIS: int
var bonusDEX: int
#valores constantes de retorno.
var totalDamage: int
var criticalChance: int
var currentAccuracy: int
var gotHited: bool
#Scene Elements
@export var enemy: Digimon
@export var digimonSprite: Sprite2D
@export var digimonAnimator: AnimationPlayer
@export var tamer: Tamer

#Battle Skills
#o array abaixo precisa sempre ter esse tamanho (5) para evitar conflitos. Nunca use erase nesse array, e sim [index] = null
var digimonSkills:Array[Skill] = [null, null, null, null, null]

#Status Control
var isDisabled: bool = false
var isBlind: bool = false

func setBehave() -> void:
	if(not isDisabled):
		digimonAnimator.play("Idle")
	if(self.position.x < 140):
		digimonSprite.flip_h = true
		if(self.digimonTier == Enums.Tier.ROOKIE):
			self.position.x -= 40
			self.position.y += 30
	else:
		if(self.digimonTier == Enums.Tier.ROOKIE):
			self.position.x += 40
			self.position.y += 30

func setStats(stats: DigimonData) -> void:
	self.digimonId = stats.digimonId
	self.digimonName = stats.digimonName
	self.digimonSprite.texture = stats.digimonTexture
	self.element = stats.element
	self.digimonTier = stats.digimonTier
	self.digimonType = stats.digimonType
	setBehave()

#a função abaixo vai retornar a soma de atributo base e atributo bonus, negando valores menores que 1
func getAttribute(att: String) -> int:
	var totalAttribute: Dictionary = {
		"str" : (baseSTR + bonusSTR),
		"int" : (baseINT + bonusINT),
		"agi" : (baseAGI + bonusAGI),
		"vit" : (baseVIT + bonusVIT),
		"wis" : (baseWIS + bonusWIS),
		"dex" : (baseDEX + bonusDEX)
	}
	var result: int = totalAttribute[att]
	if (result >= 1):
		return result
	else:
		return 1
#retorna a chance de crítico no cálculo de habilidades
func getCriticalChance() -> int:
	criticalChance = 0
	criticalChance = getAttribute("dex")
	return criticalChance
#retorna a precisão do digimon
func getAccuracy() -> int:
	currentAccuracy = 0
	currentAccuracy = baseDEX
	return currentAccuracy
	
#calcula o dano das habilidades
func getSkillDamage(damageType: Enums.DamageType) -> int:
	totalDamage = 0
	if(damageType == Enums.DamageType.PHYSICAL):
		totalDamage = getAttribute("str")
	elif(damageType == Enums.DamageType.MAGICAL):
		totalDamage = getAttribute("int")
	return totalDamage
#função que determina o acerto das habilidades.
func gotTargeted(skill: Skill) -> void:
	gotHited = false
	if(skill is DamageSkill):
		gotHited = Util.chance((float(skill.accuracy)/self.baseAGI)*100)
		if(gotHited):
			var processableDamage: DamageData = Util.damageDataBuilder(skill)
			processDamage(processableDamage)

#função que processa o dano recebido
func processDamage(_damageData: DamageData) -> void:
	pass #Essa função precisa ser implementada.

func learnSkill(skill: Skill) -> void:
	var _learned: bool = false
	if(skill is DamageSkill):
		for i in range(digimonSkills.size()):
			if(digimonSkills[i] == null):
				_learned = skill.learn(self, i)
				break
