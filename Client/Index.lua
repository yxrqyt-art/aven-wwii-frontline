local State = Package.Require("State.lua")
local HUD = Package.Require("HUD.lua")
local Network = Package.Require("Network.lua")
local InputController = Package.Require("InputController.lua")

State.Subscribe(HUD.SetState)
Network.Bind(WWII.Constants, State, HUD)
InputController.Bind(WWII.Constants)
