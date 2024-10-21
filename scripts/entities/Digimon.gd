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
var gotHited: bool
#Scene Elements
@export var skillSpawner: SkillSpawner
@export var enemy: Digimon
@export var digimonSprite: Sprite2D
@export var digimonAnimator: AnimationPlayer
@export var tamer: Tamer
@export var BM: BattleMessenger
@export var BTM: BattleManager
@export var skillAnnouncer: SkillAnnouncer

#Battle Skills
#o array abaixo precisa sempre ter esse tamanho (5) para evitar conflitos. Nunca use erase nesse array, e sim [index] = null
var digimonSkills:Array[Skill] = [null, null, null, null, null]
var digimonPassiveSkills: Dictionary = {
	
}
var digimonLearnedSkills: Array[int]
#status effects. Precisa ser sempre um dicinario para facilidade de consulta.
var statusEffect: Dictionary = {
	
}
var statusImunity: Array[int]
var elementalImunity:Array[Enums.Element]
var statusToRemove: Array[int]
var isDisabled: bool
#actions
var currentAction: Skill

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
var onLearnSkill: Array[Trigger] #Qaundo o digimon aprende uma skill APENAS DURANTE UMA BATALHA
var onInventory: Array[Trigger] #Quando o digimon usa um item ou equipamento
var onGotHited: Array[Trigger] #Quando uma habilidade acerta o digimon. Veja que difere pouco de quando ele é apenas alvo.
var onEvadeDamage: Array[Trigger] #Quando o digimon se esquiva de uma damage skill
var onEvadeStats: Array[Trigger] #Quando o digimon se esquiva da aplicação de um efeito
var onGettingStats: Array[Trigger] #Quando um efeito é aplicado com sucesso
var onDamageDelt: Array[Trigger] #Quando o digimon causa dano. Atenção, a chamada desse contexto deve ser feita no digimon inimigo
var onDying: Array[Trigger] #Quando a vida do digimon chega a 0.
var onActing: Array[Trigger] #Verificado imediatamente antes de uma ação ser atribuída a choose action
var onEvolution: Array[Trigger] #Verificado quando o digimon evolui durante a batalha

#Actions Array
var actionsToGo: Array[Skill] = []

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
	print("Precisão: " + str(currentAccuracy))
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
	skillSpawner.spawSkill(skill)
#função que determina o acerto das habilidades.

func gotTargeted(skill: Skill) -> void:
	BTM.inAction()
	gotHited = false
	triggerCheck(self.onGotTargeted, skill)
	if(skill is DamageSkill):
		if(skill.accuracy == -1):
			gotHited = true
		else:
			#a agilidade base é a taxa de esquiva, assim como a destreza base é a taxa de acerto
			gotHited = Util.chance(skill.accuracy)
		if(gotHited):
			var processableDamage: DamageData = Util.damageDataBuilder(skill)
			processDamage(processableDamage)
			if(skill.hasEffect):
				skill.applyStats(self)
		else:
			tamer.showContent(tr(StringName("Miss")))
	elif(skill is StatusSkill):
		for nstatus : StatusEffect in skill.statusEffects:
			self.applyStatus(nstatus.getStatus())
	BTM.outAction("Digimon Got Targeted")

#Função que processa o dano recebido
func processDamage(damageData: DamageData) -> void:
	BTM.inAction()
	if(damageData.damageElement in self.elementalImunity):
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
		tamer.showContent(damageData)
		digimonAnimator.play("damage")
		tamer.HUDD.updateValues()
	
#função que processa a aplica um status effect
func applyStatus(nstatus: StatusEffect) -> void:
	BTM.inAction()
	if(nstatus.statusId in self.statusImunity):
		tamer.showContent(tr(StringName("Immunity")))
	else:
		if(nstatus.schance <= -1 or nstatus.statusType == Enums.StatusType.BUFF): #dizer que a chance é -1 é o mesmo que dizer que o status será obrigatoriamente aplicado
			if(statusEffect.has(nstatus.statusId)):
				nstatus.effectOverlap(self)
			else:
				nstatus.applyingEffect(self)
				if(nstatus.statusId != 41):
					self.statusEffect[nstatus.statusId] = nstatus
			tamer.showContent(nstatus)
			triggerCheck(self.onGettingStats, nstatus)
		else:
			#a inteligência base é a taxa de acerto do atacante, mas também e a taxa de esquiva do atacado
			nstatus.calculateChance(self)
			gotHited = Util.chance(nstatus.schance)
			if(gotHited):
				if(statusEffect.has(nstatus.statusId)): #verifica se o status já está presente, chama função de sobreposição
					nstatus.effectOverlap(self)
				else:
					nstatus.applyingEffect(self)
					if(nstatus.statusId != 41):
						self.statusEffect[nstatus.statusId] = nstatus
				tamer.showContent(nstatus)
				triggerCheck(self.onGettingStats, nstatus)
			else:
				tamer.showContent(tr(StringName("Miss")))
	BTM.outAction("Aplying Status")

#função para remover um status.
func unapplyStatus(statusID: int) -> void:
	if(self.statusEffect.has(statusID)):
		var ostatusEffect: StatusEffect = self.statusEffect[statusID]
		ostatusEffect.unapplyingEffect(self)
		self.statusEffect.erase(statusID)
		tamer.showContent("-" + tr(StringName(ostatusEffect.statusName)))
	else:
		print("Erro, status não encontrado no dicionário")

#essa função está incompleta
func learnSkill(skill: Skill) -> void:
	var _learned: bool = false
	if(skill != null):
		if(skill.skillId in self.digimonLearnedSkills):
			BM.showMessage(tr(StringName("AlreadyKnowSkill")))
			_learned = true
		else:
			if(skill is PassiveSkill):
				skill.learn(self, -1)
				self.digimonPassiveSkills[skill.skillId] = skill
			else:
				for i in range(digimonSkills.size()):
					if(digimonSkills[i] == null):
						_learned = skill.learn(self, i)
						break
			self.digimonLearnedSkills.append(skill.skillId)


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
	if(currentMana - value <= 0):
		currentMana = 0
	else:
		currentMana -= value
	tamer.HUDD.updateValues()

func action() -> void:
	BTM.inAction()
	if(actionsToGo.size() > 0 and actionsToGo[0] is Skill):
		currentAction = actionsToGo[0]
		actionsToGo.remove_at(0)
		if(currentAction.needsAnimation):
			self.digimonAnimator.play("action")
			if(currentAction.skillIcon != null):
				self.skillAnnouncer.announceSkill(currentAction.skillIcon)
		else:
			if(currentAction.skillIcon != null):
				self.skillAnnouncer.announceSkill(currentAction.skillIcon)
			currentAction.effect(self)
			BTM.outAction("Action: no animation skill")
	else:
		BTM.outAction("Digimon no action")

func animationFinished(anim_name: String):
	if(anim_name == "action"):
		currentAction.effect(self)
		self.digimonAnimator.play("Idle")
		BTM.outAction("Action: animation skill")
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

func getActions(nActions: int) -> void:
	self.tamer.getActions(nActions)

#função que varre e verifica triggers, semelhante a mesma função encontrada no BattleManager
func triggerCheck(triggersToTest: Array, context) -> void:
	if(triggersToTest.size() > 0):
		for trigger: Trigger in triggersToTest:
			if(trigger != null):
				trigger.triggerValidation(self, context)
