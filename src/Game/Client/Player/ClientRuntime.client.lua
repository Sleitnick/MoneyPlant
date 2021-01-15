local Knit = require(game:GetService("ReplicatedStorage").Knit)

Knit.Modules = script.Parent.Modules

Knit.AddControllers(script.Parent.Controllers)

Knit.Start():Catch(warn)