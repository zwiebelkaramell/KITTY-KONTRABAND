extends Node


####### GLOBALS #######
# snake_case for constants, PascalCase for variables

var fail_num = 3
var base_speed = 100

var CatNum = 30
var Quota = 10
var PKGList = []

var Speed = 100
var IsXray = false
var IsKnife = false
var IsStetho = false

var VolMaster = 0.5
var VolSFX = 1
var VolMusic = 1

# using this to pass values between scenes cause doing it in the transition is a pain in the ass
var ResFails = 0
var ResFailNonCat = false

func reset():
	self.CatNum = 30
	self.Quota = 10
	self.PKGList = []
	self.Speed = 100
	self.IsXray = false
	self.IsKnife = false
	self.IsStetho = false
	self.ResFails = 0
	self.ResFailNonCat = false
