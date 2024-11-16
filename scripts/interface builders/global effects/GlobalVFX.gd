extends Node2D

class_name GlobalVFX
#elementos de cena
@export var sprite: Sprite2D
@export var anime: AnimationPlayer
@export var fade: Fade
@export var canvas: CanvasLayer
@export var digimonSprite: Sprite2D
@export var digimonBehave: AnimationPlayer
#controle de estado
var state: Enums.GlobalEffectState 
var currentDigimon: Digimon
#banco de dados de texturas
var textureDB: Dictionary = {
	"Evolution" : "res://assets/sprites/vfx/special effects/EvolutionVFX.png",
	"newDigimon" : null
}
func _ready()->void:
	self.manageVisible(false)

func afterAction(animName: String): #finish animation do digimon
	if(animName == "action"):
		self.digimonBehave.play("idle")
		if(self.state == Enums.GlobalEffectState.EVOLVING):
			self.startEvolutionVFX()
		elif(self.state == Enums.GlobalEffectState.FINISHED):
			self.manageVisible(false)
			if(self.currentDigimon != null):
				self.currentDigimon.digimonSprite.visible = true
			self.fade.startFade(false)

func afterFade() -> void:
	if(self.state == Enums.GlobalEffectState.EVOLVING):
		self.digimonBehave.play("action")
	elif(self.state == Enums.GlobalEffectState.FINISHED):
		if(self.currentDigimon != null):
			self.currentDigimon.globalFeedback()

func startEvolutionVFX() -> void:
	self.sprite.texture = load(textureDB["Evolution"])
	self.sprite.hframes = 5
	self.sprite.vframes = 9
	self.anime.speed_scale = 1.2
	self.sprite.visible = true
	self.anime.play("evolution")

func afterSpecialVFX(animName: String):
	self.sprite.visible = false
	self.sprite.hframes = 1
	self.sprite.vframes = 1
	if(self.state == Enums.GlobalEffectState.EVOLVING):
		if(animName == "evolution"):
			self.state = Enums.GlobalEffectState.FINISHED
			self.digimonBehave.play("action")
#a função abaixo desencaideia automarticamente a fusão e todas as suas camadas!
func startEvolution(oldDigimon: CompressedTexture2D, newDigimon: CompressedTexture2D, digimon: Digimon) -> void:
	self.currentDigimon = digimon
	self.manageVisible(true)
	self.state = Enums.GlobalEffectState.EVOLVING
	self.digimonSprite.texture = oldDigimon
	self.textureDB["newDigimon"] = newDigimon
	self.sprite.visible = false
	self.digimonSprite.visible = true
	self.digimonBehave.play("idle")
	self.fade.startFade(true)

func changeSprite() -> void:
	if(self.textureDB["newDigimon"] != null):
		self.digimonSprite.texture = self.textureDB["newDigimon"]

func manageVisible(seeing: bool) -> void:
	self.visible = seeing
	self.canvas.visible = seeing
