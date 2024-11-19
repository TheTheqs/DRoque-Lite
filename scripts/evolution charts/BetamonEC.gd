extends EvolutionChart
#Betamon evolution charts
class_name BetamonEC

func _init(digimon: Digimon) -> void:
	self.trigger = BetamonECT.new(self)
	self.setting(digimon)

func arrangeTriggers(digimon: Digimon) ->void:
	digimon.onActing.append(self.trigger)
