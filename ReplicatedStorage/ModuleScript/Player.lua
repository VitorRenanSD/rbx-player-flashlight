local Player = {}
Player.__index = Player

-- Constructor
function Player.new(player)
	local self = setmetatable({}, Player)
	
	self.player = player
	
	return self
end


function Player:createFlashlight(brightness, range, angle)
	
	local character = self.player.Character or self.player.CharacterAdded:Wait()
	local head = character:WaitForChild("Head")
	
	-- Create the object Part to weld the flashlight 
	local lightPart = Instance.new("Part", character)
	lightPart.CanCollide = false
	lightPart.Transparency = 1
	lightPart.CFrame = head.CFrame
	lightPart.Name = "Flashlight"
	
	-- Create the object SpotLight, will be used as a light
	local light = Instance.new("SpotLight", lightPart)
	light.Brightness = brightness
	light.Range = range
	light.Angle = angle
	light.Color = Color3.fromRGB(0, 251, 255)
	
	
	-- Attachments to align the flashlight to the head
	local lightAttachment = Instance.new("Attachment", lightPart)
	local alignPosition = Instance.new("AlignPosition", lightPart)
	alignPosition.Attachment0 = lightAttachment
	alignPosition.Attachment1 = head:WaitForChild("FaceCenterAttachment")
	alignPosition.Responsiveness = 200

	local alignOrientation = Instance.new("AlignOrientation", lightPart)
	alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
	alignOrientation.Attachment0 = lightAttachment
	alignOrientation.Responsiveness = 200
	
	
	-- Updates the lightning by the position of the camera
	local camera = workspace.CurrentCamera
	local connection = camera:GetPropertyChangedSignal("CFrame"):Connect(function()
		alignOrientation.CFrame = camera.CFrame.Rotation
	end)
	
end

return Player
