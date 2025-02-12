extends Node

var playerAtkDmg = 1.0
var playerAtkDmgMulti = 1.0
var playerHealth = 100.0
var playerMaxHealth = 100.0

var mobHealth = 3.0
var mobExpValue = 12

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
	
	
