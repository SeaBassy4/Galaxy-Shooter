extends Node2D

@export var game_stats: GameStats


@onready var ship: Node2D = $Ship
@onready var score_label: Label = $ScoreLabel
@onready var health_1: Sprite2D = $Health1
@onready var health_2: Sprite2D = $Health2
@onready var health_3: Sprite2D = $Health3
@onready var stats_component: StatsComponent = $Ship/StatsComponent

func _process(delta: float) -> void:
	if is_instance_valid(ship):
		update_health_display()
	


func _ready() -> void:
	randomize()
	update_score_label(game_stats.score)
	game_stats.score_changed.connect(update_score_label)
	
	ship.tree_exiting.connect(func(): 
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://menus/game_over.tscn")
		)

func update_health_display() -> void:
	var current_health = stats_component.health
	
	if current_health <= 2 and is_instance_valid(health_3):
		health_3.queue_free()
	if current_health <= 1 and is_instance_valid(health_2):
		health_2.queue_free()
	
func update_score_label(new_score: int) -> void:
	score_label.text = "Score: " + str(new_score)
