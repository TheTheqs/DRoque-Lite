extends Trigger

class_name StickyNetTrigger

func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageData and context.relatedSkill is StickyNet):
		var agiDebuffValue: int = int(context.damageValue*0.2)
		if(agiDebuffValue > 0):
			digimon.enemy.applyStatus(AgiMinus.new(agiDebuffValue))
	return false
