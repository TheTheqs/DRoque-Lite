extends EvolutionChart
#Veemon evolution charts
class_name WormmonEC

func _init(digimon: Digimon) -> void:
	self.trigger = WormmonECT.new(self)
	self.setting(digimon)

func arrangeTriggers(digimon: Digimon) ->void:
	digimon.onTurnStart.append(self.trigger)
