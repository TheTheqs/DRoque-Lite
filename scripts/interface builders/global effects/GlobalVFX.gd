extends Node2D

class_name GlobalVFX
#elementos de cena
@export var sprite: Sprite2D
@export var anime: AnimationPlayer
@export var fade: Fade
@export var canvas: CanvasLayer
@export var digimonNode: Control
@export var digimonSprite: Sprite2D
@export var digimonBehave: AnimationPlayer
@export var globalText: GlobalTextWindow
@export var globalSkill: GlobalSkill
#fusion digimons
@export var fusionDigimons: Node2D
@export var fusionDigimon1: GlitchShader
@export var digimon1Behave: AnimationPlayer
@export var fusionDigimon2: GlitchShader
@export var digimon2Behave: AnimationPlayer
#controle de estado
var isFusion: bool = false
var state: Enums.GlobalEffectState 
var currentDigimon: Digimon
var endDigivolve: String
#banco de dados de texturas
var textureDB: Dictionary = {
	"Evolution" : "res://assets/sprites/vfx/special effects/EvolutionVFX.png",
	"newDigimon" : null,
	"Fusion" : "res://assets/sprites/vfx/special effects/FusionVFX.png"
}
#banco de frases em relação ao karma
var karmaText: Dictionary = {
	0 : "KarmaEvolution0",
	1 : "KarmaEvolution1",
	2 : "KarmaEvolution2",
	3 : "KarmaEvolution3",
	4 : "KarmaEvolution4",
	5 : "KarmaEvolution5",
	6 : "KarmaEvolution6",
	7 : "KarmaEvolution7",
	8 : "KarmaEvolution8",
	9 : "KarmaEvolution9",
	10 : "KarmaEvolution10",
	11 : "KarmaEvolution11"
}
func _ready()->void:
	self.manageVisible(false)

func afterAction(animName: String): #finish animation do digimon
	if(animName == "action"):
		self.digimonBehave.play("idle")
		if(self.state == Enums.GlobalEffectState.EVOLVING):
			self.startEvolutionVFX()
		elif(self.state == Enums.GlobalEffectState.FINISHED):
			self.globalText.showMessage(self.endDigivolve)
			if(self.isFusion):
				self.isFusion = false
				self.fusionDigimon1.setGlitchEffect(false)
				self.fusionDigimon2.setGlitchEffect(false)

func afterFade() -> void:
	if(self.state == Enums.GlobalEffectState.EVOLVING):
		self.globalText.showMessage(karmaText[self.currentDigimon.tamer.tamerKarma])
	elif(self.state == Enums.GlobalEffectState.FINISHED):
		if(self.currentDigimon != null):
			self.manageVisible(false)
			if(self.currentDigimon != null):
				self.currentDigimon.visible = true
			self.currentDigimon.globalFeedback()

func startEvolutionVFX() -> void:
	if(self.isFusion):
		self.digimonSprite.visible = false
		self.digimonSprite.texture = self.textureDB["newDigimon"]
		self.digimonBehave.play("idle")
		self.sprite.texture = load(textureDB["Fusion"])
		self.sprite.hframes = 8
		self.sprite.vframes = 8
		self.anime.speed_scale = 1.0
		self.sprite.visible = true
		self.anime.play("fusion")
	else:
		self.sprite.texture = load(textureDB["Evolution"])
		self.sprite.hframes = 5
		self.sprite.vframes = 9
		self.anime.speed_scale = 1.0
		self.sprite.visible = true
		self.anime.play("evolution")

func afterSpecialVFX(animName: String):
	self.sprite.visible = false
	self.sprite.hframes = 1
	self.sprite.vframes = 1
	if(self.state == Enums.GlobalEffectState.EVOLVING):
		if(animName == "evolution" or animName == "fusion"):
			self.state = Enums.GlobalEffectState.FINISHED
			self.digimonBehave.play("action")
#a função abaixo desencaideia automarticamente a fusão e todas as suas camadas!
func startEvolution(oldDigimon: CompressedTexture2D, newDigimon: CompressedTexture2D, digimon: Digimon) -> void:
	self.currentDigimon = digimon
	self.manageVisible(true)
	self.state = Enums.GlobalEffectState.EVOLVING
	self.textureDB["newDigimon"] = newDigimon
	self.endDigivolve = tr(StringName(digimon.digimonName)) + tr(StringName("Digivolved")) 
	self.sprite.visible = false
	if(self.isFusion):
		self.digimonNode.visible = false
		self.fusionDigimons.visible = true
		self.fusionDigimon1.texture = oldDigimon
		self.fusionDigimon1.modulate.a = self.fade.fadeLimit
		self.fusionDigimon2.modulate.a = self.fade.fadeLimit
		self.digimon1Behave.play("idle")
		self.digimon2Behave.play("idle")
	else:
		self.digimonNode.visible = true
		self.fusionDigimons.visible = false
		self.digimonSprite.texture = oldDigimon
		self.digimonSprite.modulate.a = self.fade.fadeLimit
		self.digimonSprite.visible = true
		self.digimonBehave.play("idle")
	self.fade.isEvolution = true
	self.fade.startFade(true)

func changeSprite() -> void:
	self.endDigivolve += tr(StringName(currentDigimon.digimonName))
	if(self.textureDB["newDigimon"] != null):
		self.digimonSprite.texture = self.textureDB["newDigimon"]

func manageVisible(seeing: bool) -> void:
	self.visible = seeing
	self.canvas.visible = seeing

func digimonFade(fadeIn: bool, value: float) -> void:
	if(fadeIn):
		digimonSprite.modulate.a = min(1.0, digimonSprite.modulate.a + value)
	else:
		digimonSprite.modulate.a = max(self.fade.fadeLimit, digimonSprite.modulate.a - value)

func afterMessage() -> void:
	if(self.state == Enums.GlobalEffectState.EVOLVING):
		if(self.isFusion):
			self.digimon1Behave.play("action")
			self.digimon2Behave.play("action")
		else:
			self.digimonBehave.play("action")
	elif(self.state == Enums.GlobalEffectState.FINISHED):
		self.fade.startFade(false)

func setFusion(digi2Texture: CompressedTexture2D) ->void:
	self.isFusion = true
	self.fusionDigimon2.texture = digi2Texture

func afterFusionAction(animName: String) -> void:
	if(animName == "action"):
		self.fusionDigimon1.setGlitchEffect(true)
		self.fusionDigimon2.setGlitchEffect(true)
		self.digimon1Behave.play("idle")
		self.digimon2Behave.play("idle")
		self.startEvolutionVFX()
