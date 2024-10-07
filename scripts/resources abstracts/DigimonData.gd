extends Resource

class_name DigimonData
#identificação
@export var digimonId: int
@export var digimonTier: Enums.Tier
@export var digimonType: Enums.Type
@export var element: Enums.Element
@export var texture: CompressedTexture2D

#atributos estáticos de nível.
@export var levelSTR: int
@export var levelINT: int
@export var levelAGI: int
@export var levelVIT: int
@export var levelWIS: int
@export var levelDEX: int
