extends Resource

class_name DigimonData
#Data Base
@export var digimonId : int
@export var digimonName: String
@export var digimonTier: Enums.Tier
@export var digimonType: Enums.Type
@export var element: Enums.Element

#Scene Elements
@export var digimonTexture: CompressedTexture2D
