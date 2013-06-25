local FISH = {}FISH.ClassName = "angry_baby"FISH.Model = Model("models/props_c17/doll01.mdl")FISH.Base = "fishing_fish_base_swimming"FISH.Mass = 500FISH.Rareness = 0.5if SERVER then	-- hive mind	local target = NULL	timer.Create("fishing_angry_baby_think", 1, 0, function()		local tbl = ents.FindByClass(FISH.ClassName)		local count = #tbl		if count == 0 then return end		local baby = tbl[math.random(count)]		for key, ent in pairs(ents.FindInSphere(baby:GetPos(), 2000)) do			if ent.ClassName == FISH.ClassName then continue end			-- melons are a priority			if				ent:GetClass() == "prop_physics" and				ent:GetModel():find("melon")			then				target = ent				return			end			if ent:WaterLevel() > 0 then				if ent:IsPlayer() and ent:GetVelocity():Length() > 20 then					target = ent					return				end				if ent:GetVelocity():Length() > 20 then					target = ent				end			end		end	end)	function FISH:PreMove(phys)		if not target:IsValid() then return end		local mult = (self:WaterLevel() > 0 and phys:GetMass() or 1) * 0.5		phys:AddVelocity((target:GetPos() - self:GetPos()):GetNormalized() * mult * 0.25)		return true	end	function FISH:OnDeath()		self:EmitSound("ambient/creatures/teddy.wav", 100, math.random(90, 110) / self:GetSize())	endendfishing.RegisterFish(FISH)