extends Node

class_name Skill
#Identificação
var skillId: int
var skillName: String
var skillDescription: String
var skillIcon: CompressedTexture2D
var manaCost: int

#elementos de controle
var staticPriority: int
var priority: int
var bonusPriority: int = 0
var usable: bool = true
var usableCount: int = 0
var accuracy : float
var cooldowm: int
var currentCooldown: int = 0 #valor zero por padrão
var needsAnimation: bool = true
var hasAnimation: bool = true
var isSlow: bool = false

#scene elements
var texture: CompressedTexture2D
var textureRange: int
var isGlobal: bool = false

#learning and unlearning abstract functions
func learn(learner: Digimon, index: int) -> bool:
	learner.digimonSkills[index] = self
	return true

func unlearn(_unlearner: Digimon) -> void:
	pass

#função que aplica o cooldown depois do uso
func applyCooldown(_digimon: Digimon) -> void:
	currentCooldown = cooldowm
	if(currentCooldown > 0):
		usable = false
	
#função que vai deminuir o cooldown a cada fim de turno.
func countCooldown(digimon: Digimon) -> void:
	if(currentCooldown > 0):
		currentCooldown -= 1
		if(currentCooldown <= 0):
			currentCooldown = 0
			usable = true
	if(digimon.tamer is Player):
		var theTamer: Player = digimon.tamer
		theTamer.buttonPanel.updateButtons()

func effect(_digimon: Digimon) -> void:
	pass

func priorityCheck(_digimon: Digimon) -> void:
	pass

#a função abaixo nunca deve ser sobreescrita, e sim as funções abstratas que a fragmentam
func priorityCalculation(digimon: Digimon) -> void:
	priority = staticPriority
	priority += getElementalChartPriority(digimon)
	priority += bonusPriority
	priorityCheck(digimon)
	if(!usable or currentCooldown != 0 or digimon.currentMana < self.manaCost):
		self.priority = 0

 #a função abaixo é criada apra ser sobreescrita nas classes DamageSkill
func getElementalChartPriority(_digimon: Digimon) -> int:
	return 0

func manageUsability(discount: int) -> void:
	usableCount = max(0, usableCount + discount)
	if(usableCount != 0):
		self.usable = false
	else:
		self.usable = true
	
