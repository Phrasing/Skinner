-- thanks to pompachomp for the updates

function Skinner:AckisRecipeList()
	if not self.db.profile.TradeSkillUI then return end

	local ARL = LibStub("AceAddon-3.0"):GetAddon("Ackis Recipe List", true)
	if not ARL then return end

	local hookfunc = ARL.DisplayFrame and "DisplayFrame" or "CreateFrame"

	self:SecureHook(ARL, hookfunc, function()
		if not self.skinFrame[ARL.Frame] then
			local bgTex = ARL.bgTexture or ARL.Frame.backdrop -- ARL.Frame.backdrop is the new name of the old ARL.bgTexture in an arl alpha
			bgTex:SetAlpha(0)
			self:moveObject{obj=ARL_SwitcherButton or ARL.Frame.mode_button, y=-9} -- ARL.Frame.mode_button is the new name of the switcherbutton in an arl alpha
			self:skinDropDown{obj=ARL_DD_Sort}
			self:skinEditBox{obj=ARL_SearchText, regs={9}}
			self:skinScrollBar{obj=ARL_RecipeScrollFrame or ARL.Frame.scroll_frame} -- ARL.Frame.scroll_frame is the new name of the old ARL.RecipeScrollFrame in an arl alpha}
			self:glazeStatusBar(ARL_ProgressBar or ARL.Frame.progress_bar, 0) -- ARL.Frame.progress_bar is the new name of the old ARL.ProgressBar in an arl alpha
			self:addSkinFrame{obj=ARL.Frame, y1=-9, x2=2, y2=-4}
			-- Flyaway frame (used when Filters button is clicked)
			self:addSkinFrame{obj=ARL.Flyaway or ARL.Frame.filter_menu, kfs=true, bg=true, x2=2} -- ARL.Frame.filter_menu is the new name of the old ARL.Flyaway in an arl alpha
			-- buttons
			self:skinAllButtons(ARL.Frame)
			--	minus/plus buttons
			local button_list = ARL.Frame.waterfall_buttons or ARL.Frame.scroll_frame.state_buttons -- ARL.Frame.scroll_frame.state_buttons is the new name of the old ARL.Frame.waterfall_buttons in an arl alpha
			for i = 1, #button_list do
				self:skinButton{obj=button_list[i], mp2=true, plus=true, tx=-3, ty=0}
			end
		end
		self:Unhook(ARL, hookfunc)
	end)

	-- TextDump frame
	self:skinScrollBar{obj=ARLCopyScroll}
	self:skinAllButtons(ARLCopyFrame)
	self:addSkinFrame{obj=ARLCopyFrame}

	-- button on Tradeskill frame
	self:skinButton{obj=ARL_ScanButton or ARL.scan_button, ty=0} -- ARL.scan_button is the new name of the old ARL_ScanButton in an arl alpha

-->>-- Tooltip
	if self.db.profile.Tooltips.skin then
		if self.db.profile.Tooltips.style == 3 then arlSpellTooltip:SetBackdrop(self.Backdrop[1]) end
		self:SecureHookScript(arlSpellTooltip, "OnShow", function(this)
			self:skinTooltip(this)
		end)
	end

end
