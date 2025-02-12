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
	expToLvlUp += 50
	playerMaxHealth += 25.0
	playerAtkDmg += 1
	print("subio a nivel = " , playerLEVEL)
	print("VIDA SUBIO a" , playerMaxHealth)
	
	
