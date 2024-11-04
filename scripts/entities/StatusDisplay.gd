extends Node2D

class_name StatusDisplay
#atributos básicos
var buffBaloon: CompressedTexture2D = preload("res://assets/interface/Icons/InterfaceIcons/BuffBaloon.png")
var debuffBaloon: CompressedTexture2D = preload("res://assets/interface/Icons/InterfaceIcons/DebuffBaloon.png")
var statusToShow: Array[StatusEffect] = []
var currentShowing: int = 0
var selectBase: Dictionary = {
	0 : self.buffBaloon,
	1 : self.debuffBaloon
}
#elementos de cena
@export var baseIcon: Sprite2D
@export var statusIcon: Sprite2D
@export var stacks: Label
@export var currentDigimon: Digimon
@export var changeIconTimer: Timer

#variáveis de controle de movimento
var velocity: float = 0.3
var currentDesloc: float = 0.0
var totalDesloc: float = 4.0
var going: bool = true

#posicionamento por função ready
func _ready() -> void:
	currentShowing = 0
	if(currentDigimon.tamer is Enemy):
		self.position.x -= 40
		self.statusIcon.position.x -= 2
		self.baseIcon.flip_h = true
	else:
		self.position.x += 40
	setBehave()

#função process para deslocamento
func _process(_delta) -> void:
	var target : float
	var step : float
	if(going):
		target = totalDesloc
		step = velocity
	else:
		target = -totalDesloc
		step = -velocity
	if abs(currentDesloc - target) <= abs(step):
		baseIcon.position.y = target
		currentDesloc = target
		going = not going
	else:
		baseIcon.position.y += step
		currentDesloc += step

#função que de fato muda ícone. Esta separada da função gerente por questões de modularidade
func changeIcon(nStatusEffect: StatusEffect) -> void:
	if(nStatusEffect.isStackable):
		stacks.text = str(nStatusEffect.stacks)
		stacks.visible = true
	else:
		stacks.visible = false
	self.baseIcon.texture = selectBase[nStatusEffect.statusType]
	self.statusIcon.texture = nStatusEffect.statusIcon
	changeIconTimer.start(1.0)

#função gerente que atulaiza o ícone
func showing() -> void:
	if(currentShowing >= 0 and currentShowing < statusToShow.size() and statusToShow[currentShowing] != null):
		changeIcon(statusToShow[currentShowing])
	else:
		currentShowing = 0
		changeIconTimer.start(1.0)


#função do timer, principal responsável pela alternância dos ícones
func nextIcon():
	if(currentShowing < statusToShow.size() - 1):
		currentShowing += 1
	else:
		currentShowing = 0
	showing()

#função que adiciona um novo status para ser exibido.
func addStatus(newStatus: StatusEffect) -> void:
	if(not newStatus in statusToShow):
		statusToShow.append(newStatus)
	showing()
	setBehave()

#função que remove um status a ser exibido.
func removeStatus(oldStatus: StatusEffect) -> void:
	if(oldStatus in statusToShow):
		if(statusToShow.size() == 1):
			changeIconTimer.stop()
			statusToShow.erase(oldStatus)
		else:
			statusToShow.erase(oldStatus)
			if(currentShowing >= statusToShow.size()):
				currentShowing = 0 #reseta-se o índice para evitar erros de sincronia
			showing()
	setBehave()

#função que desliga a exibição de ícones. Setar visible é essencial, mas o process é opicional, 
#já que ele poderia ficar sempre ligado. Optou-se por desligar quando possível para melhor desempenho
func setBehave() -> void:
	if(statusToShow.size() > 0):
		self.visible = true
		set_process(true)
	else:
		self.visible = false
		set_process(false)
