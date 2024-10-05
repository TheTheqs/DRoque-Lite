extends Resource

class_name DamageSkillData

#Atributos de identificação
@export var skillId: int
@export var skillName: String
@export var skillIcon: CompressedTexture2D
@export_multiline var skillDescription: String

#atributos de valores e comportamento
@export var element: Enums.Element
@export var damageType: Enums.DamageType
@export var ratio: float
@export var manaCost: int
@export var coolDown: int
@export var hasEffect: bool

#elementos vfx
@export var skillTexture: CompressedTexture2D
@export var textureRange: int
