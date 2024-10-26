extends Tamer

class_name Player

#scene elements
@export var buttonPanel : ButtonPanel

func _ready() -> void:
	self.tamerName = "Player"
	#setando o damage shower
	turnFrame.visible = false
	summonDigimon(Util.random(0,5))
	#teste de habilidades ativas.
	digimon.learnSkill(BasicAtack.new())
	digimon.learnSkill(CureI.new())
	digimon.learnSkill(WindsOverTheIceBarrier.new())
	digimon.learnSkill(OpressTheWeak.new())
	digimon.learnSkill(LimiterRemoval.new())
	#teste de habilidades passivas
	digimon.learnSkill(EfficientCasting.new())
	digimon.learnSkill(AGlacialHeart.new())
	#teste de status effect
	#atualização da interface. Sempre a última coisa a se fazer!
	HUDD.updateValues()
	buttonPanel.setButtons()
	buttonPanel.updateButtons()
	judge.gettingStarted()

func onFrameAnimation(anim_name: String):
	if(anim_name == "blinkFrame"):
		self.canAct = true
		BM.showMessage(tr(StringName("BattleMessage2a")))

func actionsAnimation(anim_name: String) -> void:
	if(anim_name == "blinkActions"):
		actionsDisplay.visible = true
