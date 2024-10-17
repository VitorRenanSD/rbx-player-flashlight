local PlayerClass = require(game:GetService("ReplicatedStorage").Classes.Player)
local localPlayer = game.Players.LocalPlayer


local player = PlayerClass.new(localPlayer)

-- Here how to use this method
-- brightness = 1
-- range = 25
-- angle = 50

player:createFlashlight(1, 25, 50)
