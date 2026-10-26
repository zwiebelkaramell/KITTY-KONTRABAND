extends Node


####### GLOBALS #######
# snake_case for constants, PascalCase for variables

var fail_num = 3
var base_speed = 100
var base_catnum = 30
var base_quota = 10
var last_level = 3

var CatNum = base_catnum
var Quota = base_quota
var PKGList = []

var Speed = 100
var IsXray = false
var IsKnife = false
var IsStetho = false
var IsTuna = false

var VolMaster = 0.5
var VolSFX = 1
var VolMusic = 1

var Level = 0
var Tutorial = true
# using this to pass values between scenes cause doing it in the transition is a pain in the ass
var ResFails = 0
var ResFailNonCat = false

func reset():
	self.Level = 0
	self.CatNum = base_catnum
	self.Quota = base_quota
	self.PKGList = []
	self.Speed = 100
	self.IsXray = false
	self.IsKnife = false
	self.IsStetho = false
	self.IsTuna = false
	self.ResFails = 0
	self.ResFailNonCat = false
