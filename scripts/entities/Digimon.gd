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
var totalDamage: float
var criticalChance: float
var currentAccuracy: float
var consumedMana: float
var gainActions: int
var gotHited: bool #esse bool verifica se uma habilidade acertou ou não depois da animação.
var getHited: bool #esse verifica antes de fazer a animação das habilidades
var gettingStatus: bool #para verificação de status
var positionSet: bool = false
#Scene Elements
@export var skillSpawner: SkillSpawner
@export var enemy: Digimon
@export var digimonSprite: Sprite2D
@export var digimonAnimator: AnimationPlayer
@export var tamer: Tamer
@export var BM: BattleMessenger
@export var BTM: BattleManager
@export var skillAnnouncer: SkillAnnouncer
@export var statusDisplay: StatusDisplay
@export var digimonDisplay: DigimonDisplay
#Equipamentos #ATENÇÃO!!!!!! nunca usar erase no array abaixo, seu size() precisa ser sempre 4 ¬¬
var armory: Array[Equipment] = [null, null, null, null]
#[0] é para arma, [1] é para offhand, [2] é para armor e [3] é para acessório.
var armoryIndex: Dictionary = {
	Enums.EquipmentType.WEAPON: 0,
	Enums.EquipmentType.OFFHAND: 1,
	Enums.EquipmentType.ARMOR: 2,
	Enums.EquipmentType.ACESSORY: 3,
}
#Battle Skills
#o array abaixo precisa sempre ter esse tamanho (5) para evitar conflitos. Nunca use erase nesse array, e sim [index] = null
var digimonSkills:Array[Skill] = [null, null, null, null, null]
var digimonPassiveSkills: Dictionary = {
	
}
var passiveCount: Dictionary = {
	
}
var digimonLearnedSkills: Array[int]
#status effects. Precisa ser sempre um dicinario para facilidade de consulta.
var statusEffect: Dictionary = {
	
}
var statusImunity: Dictionary = {
	
}
var elementalImunity: Dictionary = {
	
}
var statusToRemove: Array[int]
var isDisabled: bool = false
var canUseItem: bool = true
var onChanging: bool = false
#actions
var selectedSkill: Skill = null
var currentAction: Skill
var animationQueue: Array[String]
var currentAnimation: String

#Triggers
#triggers verificados pelo BattleManager
var onBattleStart: Array[Trigger] #começo da batalha
var onTurnStart: Array[Trigger] #começo do turno
var onTurnEnd: Array[Trigger] = [CoolDownTrigger.new(), StatusCheckTrigger.new()] #final do turno
var BattleEnd: Array[Trigger] # Ao fim da batalha
#triggers verificados pela prórpia classe com o uso da função triggerCheck
var onHealing: Array[Trigger] #Quando recebe cura (de vida e mana)
var onGetDamage: Array[Trigger] #Quando recebe dano
var onGotTargeted: Array[Trigger] #Quando é alvo de uma habilidade
var onDamageCalc: Array[Trigger] #No cálculo de dano
var onCriticalCalc: Array[Trigger] #No cálculo de chance de crítico
var onAccuracyCalc: Array[Trigger] #No cálculo de precisão das habilidades
var onManaConsumption: Array[Trigger] #No consumo de mana
var onPassingTurn: Array[Trigger] #Quando o jogador passa o turno
var onGettingActions: Array[Trigger] #No ganho de ações extras por turno
var onLearnSkill: Array[Trigger] #Quando o digimon aprende uma skill APENAS DURANTE UMA BATALHA
var onEquipingItem: Array[Trigger] #Quando o digimon equipa um item
var onUnequipingItem: Array[Trigger] #Quando o digimon desequipa um item
var onGotHited: Array[Trigger] #Quando uma habilidade acerta o digimon. Veja que difere pouco de quando ele é apenas alvo.
var onEvadeDamage: Array[Trigger] #Quando o digimon se esquiva de uma damage skill
var onEvadeStats: Array[Trigger] #Quando o digimon se esquiva da aplicação de um efeito
var onBeforeGettingStats: Array[Trigger] #para quando há a atentativa de aplicação de um efeito no digimon
var onGettingStats: Array[Trigger] #Quando um efeito é aplicado com sucesso
var onUnapplyStatus: Array[Trigger] #Qaundo um status termina ou é removido.
var onDamageDelt: Array[Trigger] #Quando o digimon causa dano. Atenção, a chamada desse contexto deve ser feita no digimon inimigo
var onDying: Array[Trigger] #Quando a vida do digimon chega a 0.
var onActing: Array[Trigger] #Verificado imediatamente antes de uma ação ser atribuída a choose action
var onEvolution: Array[Trigger] #Verificado quando o digimon evolui durante a batalha
#esse array enorme abaixo contém todos os arrays de triggers, ele é essencial para a realização de troca de digimons
var allTriggers: Array = [
	#arrays
	onBattleStart,
	onTurnStart,
	onTurnEnd,
	BattleEnd,
	onHealing,
	onGetDamage,
	onGotTargeted,
	onDamageCalc,
	onCriticalCalc,
	onAccuracyCalc,
	onManaConsumption,
	onPassingTurn,
	onGettingActions,
	onLearnSkill,
	onEquipingItem,
	onUnequipingItem,
	onGotHited,
	onEvadeDamage,
	onEvadeStats,
	onBeforeGettingStats,
	onGettingStats,
	onUnapplyStatus,
	onDamageDelt,
	onDying,
	onActing,
	onEvolution,
	digimonLearnedSkills,
	statusToRemove,
	actionsToGo,
	#dicionários
	passiveCount,
	statusEffect,
	statusImunity,
	elementalImunity
]
#Actions Array
var actionsToGo: Array[Skill] = []

func setBehave() -> void:
	if(not isDisabled):
		digimonAnimator.play("Idle")
		currentAnimation = "Idle"
	if(not self.positionSet):
		self.positionSet = true
		if(self.position.x < 140):
			digimonSprite.flip_h = true
			if(self.digimonTier == Enums.Tier.ROOKIE):
				self.position.x -= 40
				self.position.y += 30
		else:
			if(self.digimonTier == Enums.Tier.ROOKIE):
				self.position.x += 40
				self.position.y += 30

func setStats(index: int) -> void:
	self.onChanging = true
	var reference = tamer.tamerReference
	var stats: DigimonData = tamer.getDigimonStats(index)
	self.setBasics(stats)
	self.setAttributes(stats)
	self.levelUpAttributes(currentLevel)
	self.setSkills(reference.digimonActiveSkills[index], reference.fixedPassives.values())
	self.setEquips(reference.currentEquipments[index])
	self.setPermanentStatus(reference.currentStatus[index])
	self.currentHealth = self.maxHelth*reference.currentHealthMana[index][0]
	self.currentMana = self.maxMana*reference.currentHealthMana[index][1]
	self.onChanging = false
	self.setBehave()

#função que seta os elementos visuais e descritivos do digimon
func setBasics(stats: DigimonData) -> void:
	self.digimonId = stats.digimonId
	self.digimonIcon = stats.digimonIcon
	self.digimonName ="DigimonName" + str(self.digimonId)
	self.digimonSprite.texture = stats.texture
	self.element = stats.element
	self.digimonTier = stats.digimonTier
	self.digimonType = stats.digimonType
#função que seta os atirbutos, vida máxima e mana.
func setAttributes(stats: DigimonData) -> void:
	self.baseSTR = 0
	self.baseINT = 0
	self.baseAGI = 0
	self.baseVIT = 0
	self.baseWIS = 0
	self.baseDEX = 0
	self.bonusSTR = 0
	self.bonusINT = 0
	self.bonusAGI = 0
	self.bonusVIT = 0
	self.bonusWIS = 0
	self.bonusDEX = 0
	self.currentLevel = tamer.tamerLevel
	self.levelSTR = stats.levelSTR
	self.levelINT = stats.levelINT
	self.levelAGI = stats.levelAGI
	self.levelVIT = stats.levelVIT
	self.levelWIS = stats.levelWIS
	self.levelDEX = stats.levelDEX
#função para setar as habilidades (passivas e ativas) baseado na variável global de campanha
func setSkills(skills: Array, passives: Array) -> void:
	self.digimonSkills = [null, null, null, null, null]
	self.digimonPassiveSkills.clear()
	self.learnSkill(BasicAtack.new())
	self.learnSkill(SkillDB.getNative(self.digimonId, 1))
	if(Util.checkArray(skills) and skills.size() <= 3):
		for skill: Skill in skills:
			self.learnSkill(skill)
	#verificação de passivas
	for nPassive: Array in passives:
		if(nPassive[0] is PassiveSkill):
			self.learnSkill(nPassive[0])

#função que busca os equipamentos na referência
func setEquips(equips: Array) -> void:
	self.armory = [null, null, null, null]
	if(Util.checkArray(equips) and equips.size() <= 4):
		for equip: Equipment in equips:
			if(equip != null):
				self.equipItem(equip)

#função que busca os status fixos e aplica-os no digimon
func setPermanentStatus(statuses: Array) -> void:
	self.statusEffect.clear()
	if(Util.checkArray(statuses)):
		for nStatus: StatusEffect in statuses:
			nStatus.schance = -1
			self.applyStatus(nStatus)

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
func getCriticalChance(damageSkill: DamageSkill) -> float:
	criticalChance = 0
	criticalChance = float(getAttribute("dex"))
	triggerCheck(onCriticalCalc, damageSkill)
	return criticalChance
#retorna a precisão do digimon
func getAccuracy(nobject, nemeny: Digimon) -> float:
	currentAccuracy = 0
	if(nobject is DamageSkill):
		currentAccuracy = 250.0*self.baseDEX/(self.baseDEX + nemeny.baseAGI)
	elif(nobject is StatusEffect):
		currentAccuracy = 100.0*self.baseINT/(self.baseINT + nemeny.baseINT)
	currentAccuracy = Util.cap(currentAccuracy)
	triggerCheck(onAccuracyCalc, nobject)
	return currentAccuracy

#calcula o dano das habilidades
func getSkillDamage(nskill: DamageSkill) -> float:
	totalDamage = 0
	if(nskill.damageType == Enums.DamageType.PHYSICAL):
		totalDamage = float(getAttribute("str"))
	elif(nskill.damageType == Enums.DamageType.MAGICAL):
		totalDamage = float(getAttribute("int"))
	triggerCheck(self.onDamageCalc, nskill)
	return Util.cap(totalDamage)

#função que chama o skill spawner para executar o vfx de uma skill usada no digimon
func getTageted(skill: Skill) -> void:
	BTM.inAction()
	getHited = true
	triggerCheck(self.onGotTargeted, skill)
	if(getHited):
		if(skill.hasAnimation):
			skillSpawner.spawSkill(skill)
		else:
			gotTargeted(skill)
	BTM.outAction("Digimon getTargeted")

#função que determina o acerto das habilidades.
func gotTargeted(skill: Skill) -> void:
	BTM.inAction()
	gotHited = false
	if(skill is DamageSkill):
		if(self.isDisabled):
			skill.accuracy = -1
		if(skill.accuracy == -1):
			gotHited = true
		else:
			#a agilidade base é a taxa de esquiva, assim como a destreza base é a taxa de acerto
			gotHited = Util.chance(skill.accuracy)
		triggerCheck(onGotHited, skill)
		if(gotHited):
			var processableDamage: DamageData = Util.damageDataBuilder(skill)
			processDamage(processableDamage)
			if(skill.hasEffect):
				skill.applyStats(self)
		else:
			tamer.showContent(tr(StringName("Miss")))
			triggerCheck(self.onEvadeDamage, skill)
	elif(skill is StatusSkill):
		for nstatus : StatusEffect in skill.statusEffects:
			self.applyStatus(nstatus.getStatus())
	BTM.outAction("Digimon Got Targeted")

#Função que processa o dano recebido
func processDamage(damageData: DamageData) -> void:
	BTM.inAction()
	if(self.elementalImunity.has(damageData.damageElement)):
		tamer.showContent(tr(StringName("Immunity")))
	else:
		damageData.damageValue *= Util.getTypeRatio(damageData.atackerType, self.digimonType)
		damageData.damageValue *= Util.getElementRatio(damageData.damageElement, self.element)
		applyDefense(damageData)
		if(damageData.damageValue <= 0):
			damageData.damageValue = 1.0
		#calculando dano
		if(self.currentHealth - damageData.damageValue <= 0):
			currentHealth = 0
		else:
			currentHealth -= damageData.damageValue
		triggerCheck(self.onGetDamage, damageData)
		enemy.triggerCheck(enemy.onDamageDelt, damageData)
		tamer.showContent(damageData)
		addAnimation("damage")
		tamer.HUDD.updateValues()
	
#função que processa a aplica um status effect
func applyStatus(nstatus: StatusEffect) -> void:
	BTM.inAction()
	if(statusImunity.has(nstatus.statusId)):
		if(nstatus.statusType == Enums.StatusType.DEBUFF):
			tamer.showContent(tr(StringName(nstatus.statusName)) + " " + tr(StringName("Immunity")))
		else:
			tamer.showContent(tr(StringName(nstatus.statusName)) + " " + tr(StringName("Denied")))
	else:
		if(self.isDisabled):
			nstatus.schance = -1
		triggerCheck(onBeforeGettingStats, nstatus) #checagem de trigger antes de ativar o status
		if(nstatus.schance <= -1 or nstatus.statusType == Enums.StatusType.BUFF): #dizer que a chance é -1 é o mesmo que dizer que o status será obrigatoriamente aplicado
			if(statusEffect.has(nstatus.statusId)):
				nstatus.effectOverlap(self)
				if(self.statusEffect.has(nstatus.statusId)):
					self.statusDisplay.changeIcon(self.statusEffect[nstatus.statusId])
			else:
				nstatus.applyingEffect(self)
				if(nstatus.statusId != 41):
					if(nstatus.showIcon):
						self.statusDisplay.addStatus(nstatus)
						self.statusEffect[nstatus.statusId] = nstatus
			tamer.showContent(nstatus)
			triggerCheck(self.onGettingStats, nstatus)
		else:
			#a inteligência base é a taxa de acerto do atacante, mas também e a taxa de esquiva do atacado
			nstatus.calculateChance(self)
			gotHited = Util.chance(nstatus.schance)
			triggerCheck(onGotHited, nstatus)
			if(gotHited):
				if(statusEffect.has(nstatus.statusId)): #verifica se o status já está presente, chama função de sobreposição
					nstatus.effectOverlap(self)
				else:
					nstatus.applyingEffect(self)
					if(nstatus.statusId != 41):
						if(nstatus.showIcon):
							self.statusDisplay.addStatus(nstatus)
							self.statusEffect[nstatus.statusId] = nstatus
				tamer.showContent(nstatus)
				triggerCheck(self.onGettingStats, nstatus)
			else:
				triggerCheck(self.onEvadeStats, nstatus)
	#atualização do display
	if(self.digimonDisplay.currentDigimon == self and digimonDisplay.visible):
		var statsList: Array = self.statusEffect.values()
		digimonDisplay.status.resetStatusList(statsList)
	BTM.outAction("Aplying Status")

#função para remover um status.
func unapplyStatus(statusID: int) -> void:
	if(self.statusEffect.has(statusID)):
		var ostatusEffect: StatusEffect = self.statusEffect[statusID]
		ostatusEffect.unapplyingEffect(self)
		self.statusEffect.erase(statusID)
		tamer.showContent("-" + tr(StringName(ostatusEffect.statusName)))
		self.statusDisplay.removeStatus(ostatusEffect)
		triggerCheck(self.onUnapplyStatus, statusID)
		#atualização do display
		if(self.digimonDisplay.currentDigimon == self and digimonDisplay.visible):
			var statsList: Array = self.statusEffect.values()
			digimonDisplay.status.resetStatusList(statsList)
	else:
		print("Erro, status não encontrado no dicionário. Skill ID = ", str(statusID))

#essa função está incompleta (é necessário criar um código para quando não houver espaço para novas habilidades)
func learnSkill(skill: Skill) -> void:
	var _learned: bool = false
	if(skill != null):
		if(skill.skillId in self.digimonLearnedSkills):
			BM.showMessage(tr(StringName("AlreadyKnowSkill")))
			_learned = true
			if(passiveCount.has(skill.skillId)):
				passiveCount[skill.skillId] += 1 #incrementa as fontas da habilidade passiva caso haja mais de uma
		else:
			if(skill is PassiveSkill):
				skill.learn(self, -1) #esse menos um é figurativo
				self.digimonPassiveSkills[skill.skillId] = skill
				self.passiveCount[skill.skillId] = 1 #cria uma contagem de passivas, para evitar remoção indevida
				if(self.digimonDisplay.currentDigimon == self and digimonDisplay.visible):
					self.digimonDisplay.passives.addPass(skill)
			else:#código abaixo é para habilidades ativas.
				for i in range(digimonSkills.size()):
					if(digimonSkills[i] == null):
						_learned = skill.learn(self, i)
						break
			self.digimonLearnedSkills.append(skill.skillId)


func unlearnSkill(skill: Skill) -> void:
	if(skill.skillId in digimonLearnedSkills):
		if(skill is PassiveSkill):
			if(passiveCount.has(skill.skillId)):
				passiveCount[skill.skillId] -= 1
				if(passiveCount[skill.skillId] == 0):
					var oldSkill: PassiveSkill = self.digimonPassiveSkills[skill.skillId]
					oldSkill.unlearn(self)
					digimonLearnedSkills.erase(skill.skillId)
					digimonPassiveSkills.erase(skill.skillId)
					if(self.digimonDisplay.currentDigimon == self and digimonDisplay.visible):
						self.digimonDisplay.passives.removePass(skill.skillId)
					passiveCount.erase(skill.skillId)
			else:
				print("ERROR: Skill not known")
		else:
			var skillIndex: int = self.digimonSkills.find(skill)
			skill.unlearn(self)
			self.digimonSkills[skillIndex] = null
			digimonLearnedSkills.erase(skill.skillId)
	else:
		print("ERROR: Skill not known")


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
	var newHealData: HealData = HealData.new()
	newHealData.buildData(value, isMana)
	triggerCheck(onHealing, newHealData)
	if(newHealData.healValue != 0):
		if(not isMana):
			if((currentHealth + newHealData.healValue) > maxHelth):
				currentHealth = maxHelth
			else:
				currentHealth += newHealData.healValue
		else:
			if((currentMana + newHealData.healValue) > maxMana):
				currentHealth = maxMana
			else:
				currentMana += newHealData.healValue
		tamer.showContent(newHealData)
		tamer.HUDD.updateValues()
	BTM.outAction("Digimon Heal")

func manaConsumption(value: float) -> void:
	self.consumedMana = value
	self.triggerCheck(onManaConsumption, consumedMana)
	if(currentMana - consumedMana <= 0):
		currentMana = 0
	else:
		currentMana -= consumedMana
	tamer.HUDD.updateValues()

func action() -> void:
	BTM.inAction()
	if(selectedSkill != null):
		actionsToGo.append(selectedSkill)
		selectedSkill = null
	if(actionsToGo.size() > 0 and actionsToGo[0] is Skill):
		currentAction = actionsToGo[0]
		actionsToGo.remove_at(0)
		if(currentAction.needsAnimation == false):
			if(currentAction.skillIcon != null):
				self.skillAnnouncer.announceSkill(currentAction.skillIcon)
			currentAction.effect(self)
			BTM.outAction("Action: no animation skill")
		elif(currentAction.needsAnimation == true and isDisabled == false):
			addAnimation("action")
			if(currentAction.skillIcon != null):
				self.skillAnnouncer.announceSkill(currentAction.skillIcon)
		else:
			self.tamer.showContent(tr(StringName("Denied"))+"("+tr(StringName(currentAction.skillName))+")")
			BTM.outAction("Disabled")
		triggerCheck(self.onActing, self.currentAction)
	else:
		BTM.outAction("Digimon no action")

func animationFinished(anim_name: String) -> void:
	if(anim_name == "action"):
		currentAction.effect(self)
		addAnimation(currentAnimation)
		BTM.outAction("Action: animation skill")
	elif(anim_name == "damage"):
		addAnimation(currentAnimation)
		BTM.outAction("Digimon finish damaged")
	elif(anim_name == "freeze"):
		currentAnimation = anim_name
	if(animationQueue.size() > 0):
		self.digimonAnimator.play(animationQueue[0])
		self.animationQueue.remove_at(0)

func applyDefense(damageData: DamageData) -> void:
	if(damageData.damageType == Enums.DamageType.PHYSICAL):
		damageData.damageValue *= 1 - (self.getAttribute("vit")/(100.0 + self.getAttribute("vit")))
	elif(damageData.damageType == Enums.DamageType.MAGICAL):
		damageData.damageValue *= 1 - (self.getAttribute("wis")/(100.0 + self.getAttribute("wis")))
	else:
		damageData.damageValue += 0

func chooseAction(newAction) -> void:
	if(newAction is Skill):
		selectedSkill = newAction

func getActions(nActions: int) -> void:
	gainActions = nActions
	triggerCheck(self.onGettingActions, gainActions)
	self.tamer.getActions(gainActions)

#função que varre e verifica triggers, semelhante a mesma função encontrada no BattleManager
func triggerCheck(triggersToTest: Array, context) -> void:
	if(self.onChanging and triggersToTest != self.onLearnSkill):
		return
	else:
		if(triggersToTest.size() > 0):
			for trigger: Trigger in triggersToTest:
				if(trigger != null):
					trigger.triggerValidation(self, context)

func addAnimation(animeName: String) -> void:
	if(self.digimonAnimator.current_animation != "Idle" and digimonAnimator.is_playing()):
		animationQueue.append(animeName)
	else:
		digimonAnimator.play(animeName)

func changeBonusAttribute(att: String, value: int) -> void:
	var attributes: Dictionary = {
		"str": "bonusSTR",
		"int": "bonusINT",
		"agi": "bonusAGI",
		"vit": "bonusVIT",
		"wis": "bonusWIS",
		"dex": "bonusDEX"
	}
	var healthMana: Dictionary = {
		"maxHealth" : false,
		"maxMana" : true
	}
	if att in attributes:
		self.set(attributes[att], self.get(attributes[att]) + value)
	elif(att in healthMana):
		Util.updateMaxHealthMana(self, value, healthMana[att])
	else:
		print("ERRO: invalid bônus value")
	if(self.digimonDisplay.currentDigimon == self and digimonDisplay.visible):
		self.digimonDisplay.attributes.showContent(self)
	# implementar função de atualização da interface de atributos (futuramente)e)

func equipItem(equip: Equipment) -> void:
	var armorIndex: int = armoryIndex[equip.equipType]
	if(armory[armorIndex] != null):
		self.unequipItem(armorIndex)
	armory[armorIndex] = equip
	for i : int in range(equip.attBuffs.size()):
		if(equip.attBuffs[i] != 0):
			self.changeBonusAttribute(equip.buffAdress[i], equip.attBuffs[i])
	if(equip.itemPassives.size() > 0):
		for newPassive: PassiveSkill in equip.itemPassives:
			self.learnSkill(newPassive)
	if(self.tamer is Player):
		self.tamer.buttonPanel.setButtons()
	if(self.digimonDisplay.currentDigimon == self and digimonDisplay.visible):
		digimonDisplay.armory.buildIcons(self.armory)
	tamer.showContent(tr(StringName("Equiped")) + "("+ tr(StringName(equip.itemName))+")")

func unequipItem(equipIndex: int) -> void:
	if(armory[equipIndex] != null):
		var equip: Equipment = armory[equipIndex]
		for i : int in range(equip.attBuffs.size()):
			if(equip.attBuffs[i] != 0):
				self.changeBonusAttribute(equip.buffAdress[i], -1*equip.attBuffs[i])
		if(equip.itemPassives.size() > 0):
			for oldPassive: PassiveSkill in equip.itemPassives:
				self.unlearnSkill(oldPassive)
		armory[equipIndex] = null
		if(not self.onChanging):
			self.tamer.inventory.addItem(equip, 1)
		if(self.digimonDisplay.currentDigimon == self and digimonDisplay.visible):
			digimonDisplay.armory.buildIcons(self.armory)
		tamer.showContent(tr(StringName("Unequiped")) + "("+ tr(StringName(equip.itemName))+")")
	else:
		print("ERROR: no equip to be removed!")

func addImmunity(dicCount: Dictionary, key: int) -> void:
	if(dicCount.has(key)):
		dicCount[key] += 1
	else:
		dicCount[key] = 1

func removeImmunity(dicCount: Dictionary, key: int) -> void:
	if(dicCount.has(key)):
		dicCount[key] -= 1
		if(dicCount[key] <= 0):
			dicCount.erase(key)
	else:
		print("ERROR: Immunnity does not exist!")
#função que reseta todos os arrays, essencial para a troca de digmons
func resetTriggers() -> void:
	self.onChanging = true
	for key in self.statusEffect:
		self.unapplyStatus(self.statusEffect[key].statusId)
	for triggerArray in allTriggers:
		triggerArray.clear()
	self.digimonDisplay.resetEquips()
	self.onTurnEnd = [CoolDownTrigger.new(), StatusCheckTrigger.new()]
	self.onChanging = false
#a função abaixo é feita para integrar a animação de troca de digimon <3
func callReplace() -> void:
	self.tamer.replaceDigimon()
