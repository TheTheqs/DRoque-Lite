extends ItemEffect

class_name SkillLearner

func itemEffect(digimon: Digimon) -> void:
	if(self.relatedItem.relatedSkill != null):
		digimon.learnSkill(self.relatedItem.relatedSkill)
	else:
		digimon.tamer.showContent(tr(StringName("Fail")))
