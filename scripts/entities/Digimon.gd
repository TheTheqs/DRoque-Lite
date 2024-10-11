extends Node

class_name Digimon

#Database info
var digimonId: int
var digimonName: String
var digimonIcon: CompressedTexture2D
var digimonDescription: String
#enums
var element: Enums.Element
var digimonTier: Enums.Tier
var digimonType: Enums.Type
#atributos base.
var baseSTR: int = 5
var baseINT: int = 5
var baseAGI: int = 5
var baseVIT: int = 5
var baseWIS: int = 5
var baseDEX: int = 5
#atributos por nível
var levelSTR: int
var levelINT: int
var levelAGI: int
var levelVIT: int
var levelWIS: int
var levelDEX: int
#atributo bonus.
var bonusSTR: int
var bonusINT: int
var bonusAGI: int
var bonusVIT: int
var bonusWIS: int
var bonusDEX: int
#vida mana, experiência e nível
var maxHelth: float = 1
var currentHealth: float = 1
var maxMana: float = 1
var currentMana: float = 1
var currentExp: float
var maxExp: float
var currentLevel: int
#valores constantes de retorno.
var totalDamage: int
var criticalChance: int
var currentAccuracy: int
var gotHited: bool
#Scene Elements
@export var skillSpawner: SkillSpawner
@export var enemy: Digimon
@export var digimonSprite: Sprite2D
@export var digimonAnimator: AnimationPlayer
@export var tamer: Tamer
@export var damageShower: DamageShower
@export var BM: BattleMessenger
@export var BTM: BattleManager

#Battle Skills
#o array abaixo precisa sempre ter esse tamanho (5) para evitar conflitos. Nunca use erase nesse array, e sim [index] = null
var digimonSkills:Array[Skill] = [null, null, null, null, null]

#Status Control
var isDisabled: bool = false
var isBlind: bool = false
#actions
var currentAction: Skill

#Triggers
var onBattleStart: Array[Trigger]
var onTurnStart: Array[Trigger]
var onTurnEnd: Array[Trigger]

#Actions Array
var actionsToGo: Array[Skill] = []
var effectsToGo: Array[Trigger] = []

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
	self.digimonName ="DigimonName" + str(self.digimonId)
	self.digimonSprite.texture = stats.texture
	self.element = stats.element
	self.digimonTier = stats.digimonTier
	self.digimonType = stats.digimonType
	self.currentLevel = tamer.tamerLevel
	self.levelSTR = stats.levelSTR
	self.levelINT = stats.levelINT
	self.levelAGI = stats.levelAGI
	self.levelVIT = stats.levelVIT
	self.levelWIS = stats.levelWIS
	self.levelDEX = stats.levelDEX
	levelUpAttributes(currentLevel)
	print(str(self.maxHelth))
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
#função que chama o skill spawner para executar o vfx de uma skill usada no digimon
func getTageted(skill: Skill) -> void:
	skillSpawner.spawSkill(skill)
#função que determina o acerto das habilidades.
func gotTargeted(skill: Skill) -> void:
	gotHited = false
	if(skill is DamageSkill):
		gotHited = Util.chance((float(skill.accuracy)/self.baseAGI)*100)
		if(gotHited):
			var processableDamage: DamageData = Util.damageDataBuilder(skill)
			processDamage(processableDamage)
		else:
			#função de mandar msg quando um ataque erra o alvo
			pass
	BTM.outAction("Digimon Got Targeted")

#Função que processa o dano recebido
func processDamage(damageData: DamageData) -> void:
	BTM.inAction()
	damageData.damageValue *= Util.getTypeRatio(damageData.atackerType, self.digimonType)
	damageData.damageValue *= Util.getElementRatio(damageData.damageElement, self.element)
	applyDefense(damageData)
	#calculando dano
	if(self.currentHealth - damageData.damageValue <= 0):
		currentHealth = 0
		digimonAnimator.play("damage")
	else:
		currentHealth -= damageData.damageValue
		digimonAnimator.play("damage")
	damageShower.showDamage(damageData)
	tamer.HUDD.updateValues()

#essa função está incompleta
func learnSkill(skill: Skill) -> void:
	var _learned: bool = false
	if(skill is DamageSkill):
		for i in range(digimonSkills.size()):
			if(digimonSkills[i] == null):
				_learned = skill.learn(self, i)
				break

func levelUpAttributes(level: int) -> void:
	self.baseSTR += (self.levelSTR*level)
	self.baseINT += (self.levelINT*level)
	self.baseAGI += (self.levelAGI*level)
	self.baseVIT += (self.levelVIT*level)
	self.baseWIS += (self.levelWIS*level)
	self.baseDEX += (self.levelDEX*level)
	var maxHelthBonus = baseVIT*3.5
	var newMaxHealth = self.maxHelth + maxHelthBonus
	updateMaxHelth(newMaxHealth)
	var maxManaBonus = baseWIS*3.5
	var newMaxMana = self.maxMana + maxManaBonus
	updateMaxMana(newMaxMana)

func updateMaxHelth(newMaxHealth: float) -> void:
	var proportion: float = Util.getProportion(currentHealth, maxHelth)
	self.maxHelth = newMaxHealth
	self.currentHealth = Util.cap(self.maxHelth*proportion)
	tamer.HUDD.setHealth()

func updateMaxMana(newMaxMana: float) -> void:
	var proportion: float = Util.getProportion(currentMana, maxMana)
	self.maxMana = newMaxMana
	self.currentMana = Util.cap(self.maxMana*proportion)
	tamer.HUDD.setMana()

func heal(value: float, isMana: bool) -> void:
	BTM.inAction()
	value = Util.cap(value)
	if(not isMana):
		if((currentHealth + value) > maxHelth):
			currentHealth = maxHelth
		else:
			currentHealth += value
	else:
		if((currentMana + value) > maxMana):
			currentHealth = maxMana
		else:
			currentMana += value
	tamer.HUDD.updateValues()
	BTM.outAction("Digimon Heal")

func manaConsumption(value: float) -> void:
	if(currentMana - value <= 0):
		currentMana = 0
	else:
		currentMana -= value
	tamer.HUDD.updateValues()

func action() -> void:
	BTM.inAction()
	if(actionsToGo.size() > 0 or effectsToGo.size() > 0):
		if(effectsToGo.size() > 0):
			effectsToGo[0].effect(self)
			effectsToGo.remove_at(0)
			#implementar BTM out action no final da aplicação de efeitos!!
		elif(actionsToGo[0] is Skill):
			currentAction = actionsToGo[0]
			actionsToGo.remove_at(0)
			BM.showMessage(tr(StringName(self.digimonName)) + tr(StringName("BattleMessage3")) + tr(StringName(currentAction.skillName)))
			self.digimonAnimator.play("action")
	else:
		BTM.outAction("Digimon no action")

func animationFinished(anim_name: String):
	if(anim_name == "action"):
		currentAction.effect(self)
		self.digimonAnimator.play("Idle")
		#implementar BTM out action ao final da ação
	elif(anim_name == "damage"):
		self.digimonAnimator.play("Idle")
		BTM.outAction("Digimon finish damaged")

func applyDefense(damageData: DamageData) -> void:
	if(damageData.damageType == Enums.DamageType.PHYSICAL):
		damageData.damageValue *= 1 - (self.getAttribute("vit")/(100.0 + self.getAttribute("vit")))
	elif(damageData.damageType == Enums.DamageType.MAGICAL):
		damageData.damageValue *= 1 - (self.getAttribute("wis")/(100.0 + self.getAttribute("wis")))
	else:
		damageData.damageValue += 0

func chooseAction(newAction) -> void:
	if(newAction is Skill):
		actionsToGo.append(newAction)
