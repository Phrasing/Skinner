if not Skinner:isAddonEnabled("BasicChatMods") then return end

function Skinner:BasicChatMods()

	local function skinBCMCopyFrame()
		
		self:skinScrollBar{obj=BCMCopyScroll}
		self:addSkinFrame{obj=BCMCopyFrame}
		
		for i = 1, NUM_CHAT_WINDOWS do
			self:Unhook(_G["BCMButtonCF"..i], "OnClick")
		end
	end

	for i = 1, NUM_CHAT_WINDOWS do
		self:SecureHookScript(_G["BCMButtonCF"..i], "OnClick", function(this)
			skinBCMCopyFrame()
		end)
	end
	
end
