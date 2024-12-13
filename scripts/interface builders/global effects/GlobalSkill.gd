extends Node2D

class_name GlobalSkill
#elementos de cena
@export var skillSprite: Sprite2D
@export var anime: AnimationPlayer
@export var globalEffect: GlobalVFX
@export var fade: Fade
#fonte da habilidade
var skillSpawner: SkillSpawner
var currentSkill: Skill
var relatedDigimon: Digimon

#função principal
func spawGlobalSkill(skill: Skill, newSpawner: SkillSpawner) -> void:
	self.globalEffect.manageVisible(true)
	#preparando a visibilidade
	self.globalEffect.sprite.visible = false
	self.globalEffect.globalText.visible = false
	self.globalEffect.digimonSprite.visible = false
	#anexação dos elementos dinâmicos
	skillSpawner = newSpawner
	relatedDigimon = newSpawner.relatedDigimon
	currentSkill = skill
	self.fade.isEvolution = false
	self.fade.startFade(true)

func afterFading() -> void:
	skillSprite.hframes = currentSkill.textureRange
	skillSprite.vframes = 1
	skillSprite.texture = currentSkill.texture
	var animationCommand: String = "action" + str(currentSkill.textureRange)
	self.visible = true
	anime.play(animationCommand)

func onAnimeFinish(animeName: String) -> void:
	self.visible = false
	if("action" in animeName):
		self.fade.startFade(false)

func afterFadeOut() ->void:
	self.globalEffect.manageVisible(false)
	skillSpawner._onAnimationFinished("action")
