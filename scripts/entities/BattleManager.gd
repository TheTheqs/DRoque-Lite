extends Node2D

class_name BattleManager

#Entidades de Cena
@export var player: Player
@export var enemy: Enemy
@export var playerDigimon: Digimon
@export var enemyDigimon: Digimon
@export var changeTurnTimer: Timer
@export var BM: BattleMessenger
@export var turnLabel: Label
#Possíveis janelas da tela
@export var allWindows: Array[Node2D]
#Controle de fases
var upgradeTurn: bool = false
var turn: int = 1
var currentPhase: Enums.BattlePhase
var somethingIsHappening: int
var currentDigimon: Digimon
var oppositeDigimon: Digimon
var currentTamer: Tamer
var oppositeTamer: Tamer
var tamerReady: int = 0
var choosing: bool = false
var isPassing: bool = false

#principais funções de mudança de fase
func inAction(_location: String) -> void:
	#print(_location + " inAction")
	somethingIsHappening += 1

func outAction(_location: String) -> void:
	somethingIsHappening -= 1
	#print(_location, " outAction")
	#print("Something is Happening: ", str(somethingIsHappening))
	if(somethingIsHappening <= 0):
		somethingIsHappening = 0
		if(currentDigimon!= null and (currentDigimon.actionsToGo.size() > 0)):
			currentDigimon.action()
		elif(oppositeDigimon!= null and (oppositeDigimon.actionsToGo.size() > 0)):
			oppositeDigimon.action()
		else:
			if(not choosing):
				changeTurnTimer.start(0.2)

func changeTurn():
	changeTurnTimer.stop()
	inAction("Turn Phase")
	if(currentPhase == Enums.BattlePhase.BATTLESTART):
		BM.showMessage(tr(StringName("BattleMessage0")))
		if(enemyDigimon.getAttribute("agi") >= playerDigimon.getAttribute("agi")):
			currentDigimon = enemyDigimon
			currentTamer = enemy
			oppositeDigimon = playerDigimon
			oppositeTamer = player
		else:
			currentDigimon = playerDigimon
			currentTamer = player
			oppositeDigimon = enemyDigimon
			oppositeTamer = enemy
		triggerCheck(currentDigimon.onBattleStart, currentDigimon, "BattleStart")
		triggerCheck(oppositeDigimon.onBattleStart, oppositeDigimon, "BattleStart")
		currentPhase = Enums.BattlePhase.TURNSTART
		outAction("Battle Start- Turn Phase")
	elif(currentPhase == Enums.BattlePhase.TURNSTART):
		currentDigimon.tamer.getActions(generateActions(currentDigimon, oppositeDigimon))
		triggerCheck(currentDigimon.onTurnStart, currentDigimon, "TurnStart")
		currentPhase = Enums.BattlePhase.CHOICE
		outAction("Turn Start - Turn Phase")
	elif(currentPhase == Enums.BattlePhase.CHOICE):
		if(currentDigimon.isDisabled):
			currentTamer.takeActions(1)
			BM.showMessage(tr(StringName(currentDigimon.digimonName)) + " " + tr(StringName("Disabled")))
			currentPhase = Enums.BattlePhase.TURNEND
			outAction("Disabled Digimon - Turn Phase")
		else:
			currentPhase = Enums.BattlePhase.ACTION
			choosing = true
			currentDigimon.tamer.takeTurn()
	elif(currentPhase == Enums.BattlePhase.ACTION):
		somethingIsHappening -= 1
		currentPhase = Enums.BattlePhase.POSACTION
		currentDigimon.action()
	elif(currentPhase == Enums.BattlePhase.POSACTION):
		currentTamer.takeActions(1)
		if(isPassing):
			currentPhase = Enums.BattlePhase.TURNEND
			isPassing = false
		elif(currentTamer.actions <= 0):
			currentTamer.actions = 0
			currentPhase = Enums.BattlePhase.TURNEND
		elif(currentTamer.actions > 0):
			currentPhase = Enums.BattlePhase.CHOICE
		outAction("Post Action - Turn Phase")
	elif(currentPhase == Enums.BattlePhase.TURNEND):
		if(currentDigimon.actionsToGo.size() == 0 and oppositeDigimon.actionsToGo.size() == 0):
			triggerCheck(currentDigimon.onTurnEnd, currentDigimon, "TurnEnd")
			sweepExpiredStatus(currentDigimon)
			changeActor()
			currentPhase = Enums.BattlePhase.TURNSTART
		outAction("Turn End - Turn Phase")
	elif(currentPhase == Enums.BattlePhase.BATTLEEND):
		#ainda para ser implementado
		pass

func generateActions(actor: Digimon, opponent: Digimon) -> int:
	@warning_ignore("integer_division")
	var totalActions: int  = int(actor.getAttribute("agi")/opponent.getAttribute("agi"))
	if(totalActions <= 1):
		return 1
	else:
		return totalActions

func triggerCheck(triggers: Array, digimon: Digimon, context) -> void:
	if(triggers.size() > 0):
		for trigger: Trigger in triggers:
			trigger.triggerValidation(digimon, context)

func changeActor() -> void:
	updateTurn()
	if(currentDigimon == playerDigimon):
		currentDigimon = enemyDigimon
		currentTamer = enemy
		oppositeDigimon = playerDigimon
		oppositeTamer = player
	else:
		currentDigimon = playerDigimon
		currentTamer = player
		oppositeDigimon = enemyDigimon
		oppositeTamer = enemy

func gettingStarted() -> void:
	tamerReady += 1
	if(tamerReady == 2):
		turnLabel.text = str(turn)
		inAction("Getting Started")
		currentPhase = Enums.BattlePhase.BATTLESTART
		outAction("Getting Started")

func passingTurn() -> void:
	triggerCheck(currentDigimon.onPassingTurn, currentDigimon, "PassingTurn")
	currentPhase = Enums.BattlePhase.POSACTION
	isPassing = true
	outAction("Passing Turn")

#função complementar para remover status que tiverem seu tempo de duração zerados
func sweepExpiredStatus(digimon: Digimon) -> void:
	if(digimon.statusToRemove.size() > 0):
		for statusId: int in digimon.statusToRemove:
			digimon.unapplyStatus(statusId)
		digimon.statusToRemove.clear()

func updateTurn() -> void:
	if(upgradeTurn):
		upgradeTurn = false
		turn += 1
		self.turnLabel.text = str(turn)
	else:
		upgradeTurn = true
	if(self.turn == 2):
		var taunt: Meditation = Meditation.new()
		taunt.schance = -1
		var taunt1: Meditation = Meditation.new()
		taunt1.schance = -1
		self.playerDigimon.applyStatus(taunt1)
		self.enemyDigimon.applyStatus(taunt)

func closeAllWindows() -> void: #função usada para forçar que todas as janelas sejam fechadas.
	for window in allWindows:
		if (window.visible):
			window.forcedClose()

func updateInterface() -> void: #essa função atualiza as informações de interface, útil em casos, por exemplo, de mudança de idioma no jogo
	self.BM.showMessage(tr(StringName("LangUpdate")))
	self.player.HUDD.updateValues()
	self.enemy.HUDD.updateValues()
	self.player.takeActions(0)
	self.enemy.takeActions(0)
