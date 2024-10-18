extends Trigger

class_name StatusCheckTrigger

func checkContext(digimon: Digimon, context) -> bool:
	if(context == "TurnEnd"):
		for nstatus in digimon.statusEffect.values():
			if(nstatus.isExpirable):
				nstatus.duration -= 1
				if(nstatus.duration <= 0):
					digimon.statusToRemove.append(nstatus.statusId)
	return false
