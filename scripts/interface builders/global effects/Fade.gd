extends CanvasModulate

class_name Fade
#elementos de cena
@export var globalVFX: GlobalVFX
@export var globalSkill: GlobalSkill
#controle de fade
var darkSpeed: float = 0.5
var fading: bool = true
var fadeLimit: float = 0.15
var isEvolution = true

func _ready():
	self.set_process(false)

#uso da função process para escurecer a tela
func _process(delta) -> void:
	var currentColor: Color = self.color
	if(self.fading):
		if(currentColor.r > fadeLimit):
			currentColor.r = currentColor.r - darkSpeed*delta
			currentColor.g = currentColor.g - darkSpeed*delta
			currentColor.b = currentColor.b - darkSpeed*delta
			self.globalVFX.digimonFade(true, darkSpeed*delta)
			self.color = currentColor
		else:
			self.afterFade()
	else:
		if(currentColor.r < 1.0):
			currentColor.r = min(currentColor.r + darkSpeed*delta, 1.0)
			currentColor.g = min(currentColor.r + darkSpeed*delta, 1.0)
			currentColor.b = min(currentColor.r + darkSpeed*delta, 1.0)
			self.globalVFX.digimonFade(false, darkSpeed*delta)
			self.color = currentColor
		else:
			self.afterFade()
			

#função de fade in
func startFade(inOrOut: bool) -> void:
	self.fading = inOrOut
	self.set_process(true)

func afterFade() -> void:
	if(self.isEvolution):
		self.globalVFX.afterFade()
	else:
		if(self.fading):
			self.globalSkill.afterFading()
		else:
			self.globalSkill.afterFadeOut()
	self.set_process(false)
