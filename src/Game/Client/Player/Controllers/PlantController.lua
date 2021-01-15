local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Mouse = require(Knit.Modules.Mouse)

local PlantController = Knit.CreateController { Name = "PlantController" }


function PlantController:KnitStart()

	local PlantService = Knit.GetService("PlantService")

	local mouse = Mouse.new()

	mouse.LeftDown:Connect(function()
		print("Left click")
		mouse:Raycast():Match {
			Some = function(raycastResult)
				local position = raycastResult.Position
				PlantService:RequestPlant(position)
			end;
			None = function()
			end;
		}
	end)

end


function PlantController:KnitInit()
	
end


return PlantController