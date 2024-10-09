extends Node2D

class_name BattleManager

#Entidades de Cena
@export var player: Player
@export var enemy: Enemy
@export var playerDigimon: Digimon
@export var enemyDigimon: Digimon
@export var changeTurnTimer: Timer


#Controle de fases
var currentPhase: Enums.BattlePhase
var somethingIsHappening: int
var currentDigimon: Digimon
var oppositeDigimon: Digimon
var currentTamer: Tamer
var oppositeTamer: Tamer
var tamerReady: int = 0
var isPassing: bool = false
#principais funções de mudança de fase
func inAction() -> void:
	changeTurnTimer.stop()
	somethingIsHappening += 1

func outAction() -> void:
	changeTurnTimer.stop()
	somethingIsHappening -= 1
	if(somethingIsHappening <= 0):
		somethingIsHappening = 0
		if(currentDigimon.actionsToGo.size() > 0):
			currentDigimon.action()
		elif(oppositeDigimon.actionsToGo.size() > 0):
			oppositeDigimon.action()
		else:
			changeTurnTimer.start(0.2)

func changeTurn():
	inAction()
	if(currentPhase == Enums.BattlePhase.BATTLESTART):
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
		outAction()
	elif(currentPhase == Enums.BattlePhase.TURNSTART):
		currentDigimon.tamer.actions = generateActions(currentDigimon, oppositeDigimon)
		triggerCheck(currentDigimon.onTurnStart, currentDigimon, "TurnStart")
		currentPhase = Enums.BattlePhase.CHOICE
		outAction()
	elif(currentPhase == Enums.BattlePhase.CHOICE):
		currentDigimon.tamer.takeTurn()
		currentPhase = Enums.BattlePhase.ACTION
	elif(currentPhase == Enums.BattlePhase.ACTION):
		somethingIsHappening -= 1
		currentDigimon.action()
	elif(currentPhase == Enums.BattlePhase.POSACTION):
		currentTamer.actions -= 1
		if(isPassing or currentTamer.actions <= 0):
			currentTamer.actions = 0
			currentPhase = Enums.BattlePhase.TURNEND
			isPassing = false
		elif(currentTamer.actions > 0):
			currentPhase = Enums.BattlePhase.CHOICE
		outAction()
	elif(currentPhase == Enums.BattlePhase.TURNEND):
		triggerCheck(currentDigimon.onTurnEnd, currentDigimon, "TurnEnd")
		currentPhase = Enums.BattlePhase.TURNSTART
		changeActor()
		outAction()
	elif(currentPhase == Enums.BattlePhase.BATTLEEND):
		#ainda para ser implementado
		pass

func generateActions(actor: Digimon, opponent: Digimon) -> int:
	@warning_ignore("integer_division")
	var totalActions: int  = int(actor.getAttribute("agi")/opponent.getAttribute("agi"))
	return totalActions

func triggerCheck(triggers: Array, digimon: Digimon, context) -> void:
	if(triggers.size() > 0):
		for trigger: Trigger in triggers:
			trigger.triggerValidation(digimon, context)

func changeActor() -> void:
	if(currentDigimon == playerDigimon):
		currentDigimon = oppositeDigimon
		currentTamer = enemy
		oppositeDigimon = playerDigimon
		oppositeTamer = player
	else:
		currentDigimon = playerDigimon
		currentTamer = player
		oppositeDigimon = oppositeDigimon
		oppositeTamer = enemy
	

func gettingStarted() -> void:
	tamerReady += 1
	if(tamerReady == 2):
		inAction()
		currentPhase = Enums.BattlePhase.BATTLESTART
		outAction()

func passingTurn() -> void:
	isPassing = true
	outAction()
