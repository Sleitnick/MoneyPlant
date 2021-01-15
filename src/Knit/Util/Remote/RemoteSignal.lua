-- RemoteSignal
-- Stephen Leitnick
-- January 07, 2021

--[[

	remoteSignal = RemoteSignal.new()

	remoteSignal:Connect(handler: (player: Player, ...args: any) -> void): RBXScriptConnection
	remoteSignal:Fire(player: Player, ...args: any): void
	remoteSignal:FireAll(...args: any): void
	remoteSignal:FireExcept(player: Player, ...args: any): void
	remoteSignal:Wait(): (...any)
	remoteSignal:Destroy(): void

--]]


local IS_SERVER = game:GetService("RunService"):IsServer()

local Players = game:GetService("Players")
local Ser = require(script.Parent.Parent.Ser)

local RemoteSignal = {}
RemoteSignal.__index = RemoteSignal


function RemoteSignal.Is(object)
	return (type(object) == "table" and getmetatable(object) == RemoteSignal)
end


function RemoteSignal.new()
	assert(IS_SERVER, "RemoteSignal can only be created on the server")
	local self = setmetatable({
		_remote = Instance.new("RemoteEvent");
	}, RemoteSignal)
	return self
end


function RemoteSignal:Fire(player, ...)
	self._remote:FireClient(player, Ser.SerializeArgsAndUnpack(...))
end


function RemoteSignal:FireAll(...)
	self._remote:FireAllClients(Ser.SerializeArgsAndUnpack(...))
end


function RemoteSignal:FireExcept(player, ...)
	local args = Ser.SerializeArgs(...)
	for _,plr in ipairs(Players:GetPlayers()) do
		if (plr ~= player) then
			self._remote:FireClient(plr, Ser.UnpackArgs(args))
		end
	end
end


function RemoteSignal:Wait()
	return self._remote.OnServerEvent:Wait()
end


function RemoteSignal:Connect(handler)
	return self._remote.OnServerEvent:Connect(function(player, ...)
		handler(player, Ser.DeserializeArgsAndUnpack(...))
	end)
end


function RemoteSignal:Destroy()
	self._remote:Destroy()
	self._remote = nil
end


return RemoteSignal
