if not Skinner:isAddonEnabled("AckisRecipeList") then return end

function Skinner:AckisRecipeList()
	if not self.db.profile.TradeSkillUI then return end

	local ARL = LibStub("AceAddon-3.0"):GetAddon("Ackis Recipe List", true)
	if not ARL then return end

	-- check version, if not a specified release or beta then don't skin it
	local vTab = {
		["1.0 2817"] = 1, -- release
		["1.0 @project-revision@"] = 2, -- beta
		["v1.1.0-beta2"] = 3, -- beta
		["2.0-rc1"] = 4, -- beta
		["2.0-rc2"] = 5, -- beta
	}
	local ver = GetAddOnMetadata("AckisRecipeList", "Version")
	ver = vTab[ver] or ver:sub(1, 10) > "2.0-rc2-10" and 6 -- handle alpha
	if not type(ver) == number then self:CustomPrint(1, 0, 0, "Unsupported ARL version") return end

	local function skinARL(frame)
		if ver < 4 then
			frame.backdrop:SetAlpha(0)
		end
		-- button in TLHC
		self:moveObject{obj=ver > 4 and frame.prof_button or frame.mode_button, x=6, y=-9}
		if ver < 3 then
			self:skinDropDown{obj=ARL_DD_Sort}
		end
		if ver == 1 then
			self:skinEditBox{obj=ARL_SearchText, regs={9}}
		else
			self:skinEditBox{obj=frame.search_editbox, regs={9}, noHeight=true}
			frame.search_editbox:SetHeight(18)
		end
		if ver > 2 then
			-- expand button frame
			local ebF = self:getChild(frame, 7)
			self:keepRegions(ebF, {ver == 1 and 6})
			self:moveObject{obj=ebF, y=6}
			self:skinButton{obj=frame.expand_all_button, mp=true, plus=true}
			self:SecureHookScript(frame.expand_all_button, "OnClick", function(this)
				self:checkTex(this)
			end)
		end
		if ver == 1 then
			self:skinScrollBar{obj=frame.scroll_frame}
		else
			self:skinSlider{obj=frame.scroll_frame.scroll_bar}
			frame.scroll_frame:SetBackdrop(nil)
		end
		--	minus/plus buttons
		for _, btn in pairs(frame.scroll_frame.state_buttons) do
			self:skinButton{obj=btn, mp2=true, plus=true}
			if ver < 6 then btn.text:SetJustifyH("CENTER") end
		end
		-- progress bar
		self:glazeStatusBar(frame.progress_bar, 0)
		frame.progress_bar:SetBackdrop(nil)
		self:removeRegions(frame.progress_bar, {ver > 3 and 2 or 6})
		-- skin the frame
		local x1, y1, x2, y2 = 6, -9, 2, -3
		if ver > 3 then
			x1, y1, x2, y2 = 10, -11, -33, 74
		end
		self:addSkinFrame{obj=frame, kfs=true, x1=x1, y1=y1, x2=x2, y2=y2}

-->>-- Tabs
		if ver > 2 then
			for i = 1, #frame.tabs do
				local tabObj = frame.tabs[i]
				self:keepRegions(tabObj, {4, 5}) -- N.B. region 4 is highlight, 5 is text
				local tabSF = self:addSkinFrame{obj=tabObj, ft=ftype, noBdr=self.isTT, x1=6, y1=0, x2=-6, y2=2}
				if i == 3 then
					if self.isTT then self:setActiveTab(tabSF) end
				else
					if self.isTT then self:setInactiveTab(tabSF) end
				end
				if self.isTT then
					self:SecureHookScript(tabObj, "OnClick", function(this)
						for i, tab in ipairs(frame.tabs) do
							local tabSF = self.skinFrame[tab]
							if tab == this then self:setActiveTab(tabSF)
							else self:setInactiveTab(tabSF) end
						end
					end)
				end
			end
		end

-->>-- Filter Menu
		-- hook this to handle frame size change when filter button is clicked
		self:SecureHook(frame, "ToggleState", function(this)
--			self:Debug("ARL_TS: [%s, %s]", this, this.is_expanded)
			local xOfs, yOfs = 2, -3
			if ver > 3 then
				yOfs = 74
				if this.is_expanded then xOfs = -87
				else xOfs = -33 end
			end
			self.skinFrame[frame]:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", xOfs, yOfs)
		end)
		if ver < 4 then
			self:addSkinFrame{obj=frame.filter_menu, kfs=true, bg=true} -- separate Flyaway panel
		else
			self:getRegion(frame.filter_menu.misc, 1):SetTextColor(self.BTr, self.BTg, self.BTb) -- filter text
		end
		local function changeTextColour(frame)

			for _, child in ipairs{frame:GetChildren()} do
				if child:IsObjectType("CheckButton") then
					if child.text then child.text:SetTextColor(self.BTr, self.BTg, self.BTb) end
				elseif child:IsObjectType("Frame") then
					changeTextColour(child)
				end
			end

		end
		-- change the text colour of the filter text
		changeTextColour(frame.filter_menu)

	end

	if ver > 2 then
		self:SecureHookScript(ARL_MainPanel, "OnShow", function(this)
			skinARL(this)
			self:Unhook(ARL_MainPanel, "OnShow")
		end)
	else
		local hookfunc = ARL.DisplayFrame and "DisplayFrame" or "CreateFrame"
		self:SecureHook(ARL, hookfunc, function()
			skinARL(ARL.Frame)
			self:Unhook(ARL, hookfunc)
		end)
	end

	-- TextDump frame
	self:skinScrollBar{obj=ARLCopyScroll}
	self:addSkinFrame{obj=ARLCopyFrame}

	-- button on Tradeskill frame
	self:skinButton{obj=ARL.scan_button}

-->>-- Tooltip
	if self.db.profile.Tooltips.skin then
		if self.db.profile.Tooltips.style == 3 then arlSpellTooltip:SetBackdrop(self.Backdrop[1]) end
		self:SecureHookScript(arlSpellTooltip, "OnShow", function(this)
			self:skinTooltip(this)
		end)
	end

end
