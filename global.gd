extends Node

var playerNAME = "jugador"

var playerAtkDmg = 1.0
var playerAtkDmgMulti = 1.0
var playerHealth = 100.0
var playerMaxHealth = 100.0

var mobHealth = 3.0
var mobExpValue = 12

var playerScore = 0
var scoreMulti = 1.0

var playerLEVEL = 1
var playerExp = 0
var expToLvlUp = 100

func ADD_EXP(amount):
	playerExp += amount
	print("experiencia = " , playerExp)
	if playerExp >= expToLvlUp:
		LVL_UP()
		

func LVL_UP():
	playerExp -= expToLvlUp
	playerLEVEL += 1
	expToLvlUp = round(expToLvlUp * 1.2)  # Incremento del 20% en cada nivel
	playerMaxHealth += 20 + (playerLEVEL * 5)
	playerAtkDmg += 1 + (playerLEVEL * 0.2)
	playerHealth = playerMaxHealth
	print("subio a nivel = " , playerLEVEL)
	print("VIDA SUBIO a" , playerMaxHealth)
	
	#SAVE DATA TOP PLAYERS
const SAVE_FILE = "user://highscores.json"
func save_high_score(player_name, score, level):
	var high_scores = load_high_scores()  # Cargar puntajes anteriores
	high_scores.append({"name": player_name, "score": score, "level": level})    
	# Ordenar por puntaje en orden descendente
	high_scores.sort_custom(func(a, b): return a["score"] > b["score"])    
	if high_scores.size() > 10:    # Mantener solo los 10 mejores
		high_scores = high_scores.slice(0, 10)
	# Guardar el archivo actualizado
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_string(JSON.stringify(high_scores))
	file.close()
	
func load_high_scores():
	if FileAccess.file_exists(SAVE_FILE):
		var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		file.close()
		if data is Array:
			return data
	return []  # Si no hay archivo, devuelve una lista vacía
