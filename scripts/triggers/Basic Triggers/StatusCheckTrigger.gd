extends Trigger

class_name StatusCheckTrigger

func checkContext(digimon: Digimon, context) -> bool:
	if(context == "TurnEnd"):
		for nstatus in digimon.statusEffect.values():
			if(nstatus.isExpirable):
				if(nstatus.canCount):
					nstatus.duration -= 1
					if(nstatus.duration <= 0):
						digimon.statusToRemove.append(nstatus.statusId)
				else:
					nstatus.canCount = true
	return false
