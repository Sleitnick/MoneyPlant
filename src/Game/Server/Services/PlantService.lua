local Knit = require(game:GetService("ReplicatedStorage").Knit)

local PlantService = Knit.CreateService {
	Name = "PlantService";
	Client = {};
}


function PlantService.Client:RequestPlant(player, position)
	print(player.Name .. " requested to plant something at", position)
	local p = Instance.new("Part")
	p.Anchored = true
	p.Size = Vector3.new(1, 1, 1)
	p.CFrame = CFrame.new(position) * CFrame.new(0, p.Size.Y / 2, 0)
	p.Parent = workspace
end


function PlantService:KnitStart()
	
end


function PlantService:KnitInit()
	print("PlantService initialized")
end


return PlantService