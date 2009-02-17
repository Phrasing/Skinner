
function Skinner:tektip()

	local lib = LibStub("tektip-1.0")
	
	local function skinTT(ttip)
	
		Skinner:SecureHookScript(ttip, "OnShow", function(this)
			Skinner:skinTooltip(ttip)
		end)
		if Skinner.db.profile.Tooltips.style == 3 then ttip:SetBackdrop(Skinner.backdrop) end
		
	end

	-- hook this to skin new tooltips
	self:RawHook(lib, "new", function(...)
		local ttip = self.hooks[lib].new(...)
		skinTT(ttip)
		return ttip
	end, true)
	
	-- skin existing tooltips
	for i = 1, UIParent:GetNumChildren() do
		local child = select(i, UIParent:GetChildren())
		if child:GetFrameStrata() == "TOOLTIP" and child.AddLine and child.Clear then skinTT(child) end
	end

end
