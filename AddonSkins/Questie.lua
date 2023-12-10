local _, aObj = ...
if not aObj:isAddonEnabled("Questie") then return end
local _G = _G

aObj.addonsToSkin.Questie = function(self) -- v 8.10.6/9.0.4

	local qMods = _G.QuestieLoader._modules

	if self.modBtns then
		self:SecureHook(qMods.WorldMapButton, "Initialize", function(this)
			_G.Questie.WorldMap.Button.Border:SetTexture(nil)
			self:skinStdButton{obj=_G.Questie.WorldMap.Button}

			self:Unhook(this, "Initialize")
		end)
		self:SecureHook(qMods.QuestieOptions, "OpenConfigWindow", function(this)
			self:skinStdButton{obj=self:getLastChild(_G.QuestieConfigFrame.frame)}

			self:Unhook(this, "Initialize")
		end)
		self:SecureHook(qMods.TrackerLinePool, "Initialize", function(this)
			-- TODO skin TrackedQuests expandQuest buttons
			for i = 1, _G.C_QuestLog.GetMaxNumQuestsCanAccept() do
				self:addButtonBorder{obj=_G["Questie_ItemButton" .. i], sabt=true, clr="grey"}
			end

			self:Unhook(this, "Initialize")
		end)
	end

	if _G.Questie.IsWotlk
	and _G.GetCVar("questPOI") ~= nil
	and not _G.Questie.db.global.tutorialObjectiveTypeChosen
	then
		self:SecureHook(qMods.Tutorial, "CreateChooseObjectiveTypeFrame", function(this)
			self:skinObject("frame", {obj=_G.QuestieTutorialChooseObjectiveType})
			if self.modBtns then
				for _, child in _G.ipairs_reverse{_G.QuestieTutorialChooseObjectiveType:GetChildren()} do
					if child:IsObjectType("Button") then
						self:skinStdButton{obj=child}
					end
				end
			end

			self:Unhook(this, "CreateChooseObjectiveTypeFrame")
		end)
	end

	if qMods.QuestieDebugOffer then
		self:SecureHook(qMods.QuestieDebugOffer, "ShowOffer", function(this, _)
			self:skinObject("editbox", {obj=_G.QuestieDebugOffer.discordLinkEditBox})
			self:skinObject("frame", {obj=_G.QuestieDebugOfferFrame, kfs=true})
			if self.modBtns then
				self:skinStdButton{obj=_G.QuestieDebugOfferFrame.dismissButton}
			end

			self:Unhook(this, "ShowOffer")
		end)
	end

end
