local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Maid = require(Knit.Util.Maid)
local Signal = require(Knit.Util.Signal)
local Option = require(Knit.Util.Option)

local UserInputService = game:GetService("UserInputService")

local DISTANCE = 2000

local camera = workspace.CurrentCamera

local Mouse = {}
Mouse.__index = Mouse


function Mouse.new()

	local self = setmetatable({}, Mouse)

	self._maid = Maid.new()

	self.LeftDown = Signal.new(self._maid)
	self.LeftUp = Signal.new(self._maid)
	self.RightDown = Signal.new(self._maid)
	self.RightUp = Signal.new(self._maid)

	self._maid:GiveTask(UserInputService.InputBegan:Connect(function(input, processed)
		if (processed) then return end
		if (input.UserInputType == Enum.UserInputType.MouseButton1) then
			self.LeftDown:Fire()
		elseif (input.UserInputType == Enum.UserInputType.MouseButton2) then
			self.RightDown:Fire()
		end
	end))

	self._maid:GiveTask(UserInputService.InputEnded:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1) then
			self.LeftUp:Fire()
		elseif (input.UserInputType == Enum.UserInputType.MouseButton2) then
			self.RightUp:Fire()
		end
	end))

	return self

end


function Mouse:Raycast(raycastParams)
	local mouseLocation = UserInputService:GetMouseLocation()
	local mouseRay = camera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y)
	local result = workspace:Raycast(mouseRay.Origin, mouseRay.Direction * DISTANCE, raycastParams)
	if (result) then
		return Option.Some(result)
	else
		return Option.None
	end
end


function Mouse:Destroy()
	self._maid:Destroy()
end


return Mouse