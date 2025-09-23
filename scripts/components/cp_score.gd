extends Component
class_name ScoreComponent

@export var score_modifier:int = 0

func modify_score():
	Global.score += score_modifier
