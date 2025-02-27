extends Resource

class_name DamageData
#essa classe não será usada de forma estática para armazenamento de dados, e sim de forma dinâmica
#os recursos DamageData são criados dinamicamente para interpretação de dano quando ele é recebido.
#para mais detalhes veja as funções que lidam como o dano dado e recebido dos digimons
var relatedSkill: DamageSkill
var damageType: Enums.DamageType
var damageSubType: Enums.DamageSubType
var damageElement: Enums.Element
var atackerType: Enums.Type
var damageValue: float
var isCritic: bool

func buildData(nRelatedSkill: DamageSkill, ndamageType: Enums.DamageType, ndamageSubType: Enums.DamageSubType,ndamageElement: Enums.Element, natackerType: Enums.Type, ndamageValue: float, nisCrtic: bool):
	self.relatedSkill = nRelatedSkill
	self.damageType = ndamageType
	self.damageSubType = ndamageSubType
	self.damageElement = ndamageElement
	self.atackerType = natackerType
	self.damageValue = ndamageValue
	self.isCritic = nisCrtic
