extends EvolutionChart
#agumon evolution charts
class_name AgumonEC

func _init(digimon: Digimon) -> void:
	self.trigger = AgumonECT.new(self)
	self.setting(digimon)

func arrangeTriggers(digimon: Digimon) ->void:
	digimon.onActing.append(self.trigger)

func unsetting(digimon: Digimon)-> void:
	digimon.onActing.erase(self.trigger)
