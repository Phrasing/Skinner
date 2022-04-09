local _, aObj = ...

local _G = _G

local ftype = "u"

aObj.blizzFrames[ftype].AddonList = function(self)
	if not self.prdb.AddonList or self.initialized.AddonList then return end
	self.initialized.AddonList = true

	self:SecureHookScript(_G.AddonList, "OnShow", function(this)
		self:removeMagicBtnTex(this.CancelButton)
		self:removeMagicBtnTex(this.OkayButton)
		self:removeMagicBtnTex(this.EnableAllButton)
		self:removeMagicBtnTex(this.DisableAllButton)
		for i = 1, _G.MAX_ADDONS_DISPLAYED do
			if self.modBtns then
				self:skinStdButton{obj=_G["AddonListEntry" .. i .. "Load"]}
			end
			if self.modChkBtns then
				self:skinCheckButton{obj=_G["AddonListEntry" .. i .. "Enabled"]}
			end
		end
		self:skinObject("slider", {obj=_G.AddonListScrollFrame.ScrollBar, fType=ftype, rpTex="background"})
		self:skinObject("dropdown", {obj=_G.AddonCharacterDropDown, fType=ftype, x2=109})
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, ri=true, rns=true, cb=true, x2=self.isClscBC and 1})
		if self.modBtns then
			self:skinStdButton{obj=this.CancelButton}
			self:skinStdButton{obj=this.OkayButton}
			self:skinStdButton{obj=this.EnableAllButton}
			self:skinStdButton{obj=this.DisableAllButton}
		end
		if self.modChkBtns then
			self:skinCheckButton{obj=_G.AddonListForceLoad}
		end

		self:Unhook(this, "OnShow")
	end)

end

aObj.blizzFrames[ftype].AutoComplete = function(self)
	if not self.prdb.AutoComplete or self.initialized.AutoComplete then return end
	self.initialized.AutoComplete = true

	-- tooltip
	_G.C_Timer.After(0.1, function()
		self:add2Table(self.ttList, _G.AutoCompleteBox)
	end)

end

aObj.blizzLoDFrames[ftype].BattlefieldMap = function(self)
	if not self.prdb.BattlefieldMap or self.initialized.BattlefieldMap then return end
	self.initialized.BattlefieldMap = true

	self:SecureHookScript(_G.BattlefieldMapFrame, "OnShow", function(this)
		self:skinObject("frame", {obj=_G.BattlefieldMapTab, fType=ftype, kfs=true, noBdr=self.isTT, y1=-7, y2=-7})
		self:skinObject("frame", {obj=this.BorderFrame, fType=ftype, kfs=true, cb=true, fb=true, ofs=4, y1=6, x2=2, y2=2})

		-- change the skinFrame's opacity as required
		self:SecureHook(this, "RefreshAlpha", function(fObj)
			local alpha = 1.0 - _G.BattlefieldMapOptions.opacity
			alpha = (alpha >= 0.15) and alpha - 0.15 or alpha
			fObj.BorderFrame.sf:SetAlpha(alpha)
		end)

		if _G.IsAddOnLoaded("Capping") then
			if _G.type(self["Capping_ModMap"]) == "function" then self:Capping_ModMap() end
		end

		if _G.IsAddOnLoaded("Mapster") then
			local mBM = _G.LibStub:GetLibrary("AceAddon-3.0", true):GetAddon("Mapster", true):GetModule("BattleMap", true)
			if mBM then
				local function updBMVisibility(db)
					if db.hideTextures then
						this.BorderFrame.sf:Hide()
					else
						this.BorderFrame.sf:Show()
					end
				end
				-- change visibility as required
				updBMVisibility(mBM.db.profile)
				self:SecureHook(mBM, "UpdateTextureVisibility", function(fObj)
					updBMVisibility(fObj.db.profile)
				end)
			end
		end

		self:Unhook(this, "OnShow")
	end)
	self:checkShown(_G.BattlefieldMapFrame)

end

aObj.blizzLoDFrames[ftype].BindingUI = function(self)
	if not self.prdb.BindingUI or self.initialized.BindingUI then return end
	self.initialized.BindingUI = true

	self:SecureHookScript(_G.KeyBindingFrame, "OnShow", function(this)
		if self.isRtl then
			self:removeNineSlice(this.BG)
		end
		self:skinObject("frame", {obj=this.categoryList, fType=ftype, kfs=true, fb=true})
		self:skinObject("frame", {obj=this.bindingsContainer, fType=ftype, kfs=true, fb=true})
		self:skinObject("slider", {obj=this.scrollFrame.ScrollBar, rpTex={"background", "border"}})
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, hdr=true})
		if self.modBtns then
			for _, row in _G.pairs(this.keyBindingRows) do
				self:skinStdButton{obj=row.key1Button}
				self:skinStdButton{obj=row.key2Button}
				row.key1Button.sb:SetAlpha(row.key1Button:GetAlpha())
				row.key2Button.sb:SetAlpha(row.key2Button:GetAlpha())
				if not aObj.isClsc then
					self:SecureHook(row, "Update", function(fObj)
						self:clrBtnBdr(fObj.key2Button)
						fObj.key1Button.sb:SetAlpha(fObj.key1Button:GetAlpha())
						fObj.key2Button.sb:SetAlpha(fObj.key2Button:GetAlpha())
					end)
				end
			end
			self:skinStdButton{obj=this.unbindButton}
			self:skinStdButton{obj=this.okayButton}
			self:skinStdButton{obj=this.cancelButton}
			self:skinStdButton{obj=this.defaultsButton}
			-- hook this to handle custom buttons (e.g. Voice Chat: Push to Talk)
			self:SecureHook("BindingButtonTemplate_SetupBindingButton", function(_, button)
				if button.GetCustomBindingType then
					self:skinStdButton{obj=button}
				end
			end)
			if self.isClsc then
				self:SecureHook("KeyBindingFrame_Update", function()
					for _, row in _G.pairs(_G.KeyBindingFrame.keyBindingRows) do
						self:clrBtnBdr(row.key2Button)
						row.key1Button.sb:SetAlpha(row.key1Button:GetAlpha())
						row.key2Button.sb:SetAlpha(row.key2Button:GetAlpha())
					end
				end)
				self:SecureHook("KeyBindingFrame_UpdateUnbindKey", function()
					self:clrBtnBdr(_G.KeyBindingFrame.unbindButton)
				end)
			else
				self:skinStdButton{obj=this.quickKeybindButton}
				self:SecureHook(this, "UpdateUnbindKey", function(fObj)
					self:clrBtnBdr(fObj.unbindButton)
				end)
				self:skinStdButton{obj=this.clickCastingButton, fType=ftype}
			end
		end
		if self.modChkBtns then
			self:skinCheckButton{obj=this.characterSpecificButton}
		end

		self:Unhook(this, "OnShow")
	end)

	if not self.isClsc then
		self:SecureHookScript(_G.QuickKeybindFrame, "OnShow", function(this)
			self:removeNineSlice(this.BG)
			this.BG.Bg:SetTexture(nil)
			self:skinObject("frame", {obj=this, fType=ftype, kfs=true, hdr=true, ofs=0})
			if self.modBtns then
				self:skinStdButton{obj=this.defaultsButton}
				self:skinStdButton{obj=this.cancelButton}
				self:skinStdButton{obj=this.okayButton}
			end
			if self.modChkBtns then
				self:skinCheckButton{obj=this.characterSpecificButton}
			end

			self:Unhook(this, "OnShow")
		end)
		-- tooltip
		_G.C_Timer.After(0.1, function()
			self:add2Table(self.ttList, _G.QuickKeybindTooltip)
		end)
	end

end

aObj.blizzFrames[ftype].BNFrames = function(self)
	if not self.prdb.BNFrames or self.initialized.BNFrames then return end
	self.initialized.BNFrames = true

	self:SecureHookScript(_G.BNToastFrame, "OnShow", function(this)
		self:skinObject("frame", {obj=this, fType=ftype, ofs=0})
		if self.modBtns then
			self:skinCloseButton{obj=this.CloseButton, font=self.fontSBX, noSkin=true}
			this.CloseButton.cb = this.CloseButton.sb
		end
		self:hookSocialToastFuncs(this)
		self:skinObject("frame", {obj=this.TooltipFrame, fType=ftype, kfs=true})
		this.TooltipFrame:SetScript("OnLoad", nil)

		self:Unhook(this, "OnShow")
	end)

	self:SecureHookScript(_G.TimeAlertFrame, "OnShow", function(this)
		self:skinObject("frame", {obj=this, fType=ftype, ofs=0})
		if self.modBtns then
			self:skinCloseButton{obj=this.CloseButton, font=self.fontSBX, noSkin=true}
			this.CloseButton.cb = this.CloseButton.sb
		end
		self:hookSocialToastFuncs(this)

	self:Unhook(this, "OnShow")
	end)

end

aObj.blizzFrames[ftype].ChatBubbles = function(self)
	if not self.prdb.ChatBubbles.skin or self.initialized.ChatBubbles then return end
	self.initialized.ChatBubbles = true

	-- N.B. ChatBubbles in Raids, Dungeons and Garrisons are forbidden and can't be skinned
	local function skinChatBubbles()
		_G.C_Timer.After(0.1, function()
			-- get all ChatBubbles NOT including Forbidden ones
			for _, cBubble in _G.pairs(_G.C_ChatBubbles.GetAllChatBubbles()) do
				cBubble = aObj:getChild(cBubble, 1)
				aObj:skinObject("frame", {obj=cBubble, fType=ftype, kfs=true, ba=aObj.prdb.ChatBubbles.alpha, ng=true, ofs=-8, clr="grey"})
				-- make text visible
				if cBubble.String then
					cBubble.String:SetParent(cBubble.sf)
				elseif cBubble:GetNumRegions() == 2 then
					aObj:getRegion(cBubble, 2):SetParent(cBubble.sf)
				end
			end
		end)
	end
	 -- events which create chat bubbles
	local evtTab = {"CHAT_MSG_SAY", "CHAT_MSG_YELL", "CHAT_MSG_MONSTER_SAY", "CHAT_MSG_MONSTER_YELL", "CINEMATIC_START"}
	local function registerEvents()
		for _, event in _G.pairs(evtTab) do
			self:RegisterEvent(event, skinChatBubbles)
		end
	end
	local function unRegisterEvents()
		for _, event in _G.pairs(evtTab) do
			self:UnregisterEvent(event)
		end
	end
	-- if any chat bubbles options turned on
	if _G.C_CVar.GetCVarBool("chatBubbles")
	or _G.C_CVar.GetCVarBool("chatBubblesParty")
	then
		-- skin any existing ones
		registerEvents()
		skinChatBubbles()
	end
	-- hook this to handle changes
	self:SecureHook("InterfaceOptionsDisplayPanelChatBubblesDropDown_SetValue", function(_, value)
		-- unregister events
		unRegisterEvents()
		if value ~= 2 then -- either All or ExcludeParty
			registerEvents()
			skinChatBubbles()
		end
	end)

end

aObj.blizzFrames[ftype].ChatConfig = function(self)
	if not self.prdb.ChatConfig or self.initialized.ChatConfig then return end
	self.initialized.ChatConfig = true

	self:SecureHookScript(_G.ChatConfigFrame, "OnShow", function(this)
		if self.isRtl then
			self:removeNineSlice(this.Border)
		end
		self:skinObject("frame", {obj=_G.ChatConfigCategoryFrame, fType=ftype, kfs=true, rns=true, fb=true, ofs=0})
		self:skinObject("frame", {obj=_G.ChatConfigBackgroundFrame, fType=ftype, kfs=true, rns=true, fb=true, ofs=0})
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, hdr=true, ofs=-4, y1=0})
		if self.modBtns then
			self:skinStdButton{obj=this.DefaultButton}
			self:skinStdButton{obj=this.RedockButton}
			self:skinStdButton{obj=_G.CombatLogDefaultButton}
			self:skinStdButton{obj=this.ToggleChatButton}
			if self.isRtl
			or self.isClscBC
			or self.isClscERAPTR
			then
				self:skinStdButton{obj=_G.TextToSpeechDefaultButton, fType=ftype}
			end
			self:skinStdButton{obj=_G.ChatConfigFrameCancelButton}
			self:skinStdButton{obj=_G.ChatConfigFrameOkayButton}
		end
		if self.modChkBtns
		and self.isRtl
		or self.isClscBC
		or self.isClscERAPTR
		then
			self:skinCheckButton{obj=_G.TextToSpeechCharacterSpecificButton, fType=ftype}
		end
		-- ChatTabManager
		local setTabState
		if self.isTT then
			function setTabState(tab)
				if tab:GetID() == _G.CURRENT_CHAT_FRAME_ID then
					aObj:setActiveTab(tab.sf)
				else
					aObj:setInactiveTab(tab.sf)
				end
				tab.sf:Show()
			end
		else
			function setTabState(tab)
				tab:SetAlpha(1)
				tab:SetFrameLevel(21)
				tab.sf:SetFrameLevel(20)
				tab.sf:Show()
			end
		end
		local tabSkin = self.skinTPLs.new("tabs", {obj=this.ChatTabManager, tabs={}, fType=ftype, upwards=true, ignoreHLTex=false, offsets={x1=4, y1=self.isTT and -10 or -12, x2=-4, y2=self.isTT and -5 or 0}, regions={8, 9, 10, 11}, noCheck=true, func=setTabState})
		local function skinTabs(ctm)
			tabSkin.tabs = {}
			for tab in ctm.tabPool:EnumerateActive() do
				aObj:add2Table(tabSkin.tabs, tab)
				if tab:GetID() == _G.CURRENT_CHAT_FRAME_ID then
					tab:GetFontString():SetTextColor(1, 1, 1)
				else
					tab:GetFontString():SetTextColor(_G.NORMAL_FONT_COLOR.r, _G.NORMAL_FONT_COLOR.g, _G.NORMAL_FONT_COLOR.b)
				end
			end
			aObj:skinObject(tabSkin)
		end
		skinTabs(this.ChatTabManager)
		self:SecureHook(this.ChatTabManager, "OnShow", function(fObj)
			skinTabs(fObj)
		end)
		self:SecureHook(this.ChatTabManager, "UpdateSelection", function(fObj, _)
			skinTabs(fObj)
		end)
		local function skinCB(cBox)
			if aObj.isClsc
			and _G[cBox].NineSlice
			then
				aObj:removeNineSlice(_G[cBox].NineSlice)
			else
				aObj:removeBackdrop(_G[cBox])
			end
			if aObj.modChkBtns then
				local box
				for _, suffix in _G.pairs{"", "Check", "ColorSwatch"} do
					box = _G[cBox .. suffix]
					if box
					and box:IsObjectType("CheckButton")
					then
						aObj:skinCheckButton{obj=box}
					end
				end
			end
		end
		--	Chat Settings
		self:skinObject("frame", {obj=_G.ChatConfigChatSettingsLeft, fType=ftype, kfs=true, rns=true, fb=true})
		if self.modChkBtns then
			for i = 1, #_G.CHAT_CONFIG_CHAT_LEFT do
				skinCB("ChatConfigChatSettingsLeftCheckBox" .. i)
			end
		end
		--	Channel Settings
		self:skinObject("frame", {obj=_G.ChatConfigChannelSettingsLeft, fType=ftype, kfs=true, rns=true, fb=true})
		if self.modChkBtns
		and self.isRtl
		then
			self:SecureHookScript(_G.ChatConfigChannelSettings, "OnShow", function(fObj)
				for i = 1, #_G.CHAT_CONFIG_CHANNEL_LIST do
					skinCB("ChatConfigChannelSettingsLeftCheckBox" .. i)
				end

				self:Unhook(fObj, "OnShow")
			end)
		else
			self:skinObject("frame", {obj=_G.ChatConfigChannelSettingsAvailable, fType=ftype, kfs=true, rns=true, fb=true})
			self:SecureHook("ChatConfig_CreateCheckboxes", function(frame, _)
				local box
				for i = 1, #frame.checkBoxTable do
					box = _G[frame:GetName() .. "CheckBox" .. i]
					if aObj.isClsc
					and box.NineSlice
					then
						aObj:removeNineSlice(box.NineSlice)
					else
						aObj:removeBackdrop(box)
					end
					if self.modChkBtns then
						 self:skinCheckButton{obj=box.CheckButton}
					end
				end
			end)
			self:SecureHook("ChatConfig_CreateBoxes", function(frame, _)
				local box
				for i = 1, #frame.boxTable do
					box = _G[frame:GetName() .. "Box" .. i]
					if aObj.isClsc
					and box.NineSlice
					then
						aObj:removeNineSlice(box.NineSlice)
					else
						aObj:removeBackdrop(box)
					end
					if self.modBtns then
						self:skinStdButton{obj=box.Button, ofs=0}
					end
				end
			end)
		end
		--	Other Settings
		for i = 1, #_G.CHAT_CONFIG_OTHER_COMBAT do
			skinCB("ChatConfigOtherSettingsCombatCheckBox" .. i)
		end
		self:skinObject("frame", {obj=_G.ChatConfigOtherSettingsCombat, fType=ftype, kfs=true, rns=true, fb=true})
		for i = 1, #_G.CHAT_CONFIG_OTHER_PVP do
			skinCB("ChatConfigOtherSettingsPVPCheckBox" .. i)
		end
		self:skinObject("frame", {obj=_G.ChatConfigOtherSettingsPVP, fType=ftype, kfs=true, rns=true, fb=true})
		for i = 1, #_G.CHAT_CONFIG_OTHER_SYSTEM do
			skinCB("ChatConfigOtherSettingsSystemCheckBox" .. i)
		end
		self:skinObject("frame", {obj=_G.ChatConfigOtherSettingsSystem, fType=ftype, kfs=true, rns=true, fb=true})
		for i = 1, #_G.CHAT_CONFIG_CHAT_CREATURE_LEFT do
			skinCB("ChatConfigOtherSettingsCreatureCheckBox" .. i)
		end
		self:skinObject("frame", {obj=_G.ChatConfigOtherSettingsCreature, fType=ftype, kfs=true, rns=true, fb=true})
		-- TextToSpeechSettings
		-- N.B. TextToSpeechFrame is skinned separately
		if self.modChkBtns
		and self.isRtl
		or self.isClscBC
		or self.isClscERAPTR
		then
			self:SecureHook("TextToSpeechFrame_UpdateMessageCheckboxes", function(frame)
				for i = 1, #frame.checkBoxTable do
					self:skinCheckButton{obj=_G[frame:GetName() .. "CheckBox" .. i], fType=ftype}
				end

				self:Unhook("TextToSpeechFrame_UpdateMessageCheckboxes")
			end)
		end
		if self.isRtl
		or self.isClscBC
		or self.isClscERAPTR
		then
			self:SecureHookScript(_G.ChatConfigTextToSpeechChannelSettings, "OnShow", function(fObj)
				self:skinObject("frame", {obj=_G.ChatConfigTextToSpeechChannelSettingsLeft, fType=ftype, kfs=true, rns=true, fb=true})
				for i = 1, #_G.CHAT_CONFIG_TEXT_TO_SPEECH_CHANNEL_LIST do
					skinCB("ChatConfigTextToSpeechChannelSettingsLeftCheckBox" .. i)
				end

				self:Unhook(fObj, "OnShow")
			end)
		end
		--	Combat Settings
		-- Filters
		_G.ChatConfigCombatSettingsFiltersScrollFrameScrollBarBorder:Hide()
		self:skinObject("slider", {obj=_G.ChatConfigCombatSettingsFiltersScrollFrameScrollBar, fType=ftype})
		if self.modBtns then
			self:skinStdButton{obj=_G.ChatConfigCombatSettingsFiltersDeleteButton}
			self:skinStdButton{obj=_G.ChatConfigCombatSettingsFiltersAddFilterButton}
			self:skinStdButton{obj=_G.ChatConfigCombatSettingsFiltersCopyFilterButton}
		end
		if self.modBtnBs then
			self:addButtonBorder{obj=_G.ChatConfigMoveFilterUpButton, es=12, ofs=-5, x2=-6, y2=7, clr="grey"}
			self:addButtonBorder{obj=_G.ChatConfigMoveFilterDownButton, es=12, ofs=-5, x2=-6, y2=7, clr="grey"}
		end
		self:skinObject("frame", {obj=_G.ChatConfigCombatSettingsFilters, fType=ftype, kfs=true, rns=true, fb=true, ofs=0})
		_G.LowerFrameLevel(_G.ChatConfigCombatSettingsFilters) -- make frame appear below tab texture
		-- Message Sources
		for i = 1, #_G.COMBAT_CONFIG_MESSAGESOURCES_BY do
			skinCB("CombatConfigMessageSourcesDoneByCheckBox" .. i)
		end
		self:skinObject("frame", {obj=_G.CombatConfigMessageSourcesDoneBy, fType=ftype, kfs=true, rns=true, fb=true})
		for i = 1, #_G.COMBAT_CONFIG_MESSAGESOURCES_TO do
			skinCB("CombatConfigMessageSourcesDoneToCheckBox" .. i)
		end
		self:skinObject("frame", {obj=_G.CombatConfigMessageSourcesDoneTo, fType=ftype, kfs=true, rns=true, fb=true})
		-- Message Type
		for i, val in _G.ipairs(_G.COMBAT_CONFIG_MESSAGETYPES_LEFT) do
			skinCB("CombatConfigMessageTypesLeftCheckBox" .. i)
			if val.subTypes then
				for k, _ in _G.pairs(val.subTypes) do
					skinCB("CombatConfigMessageTypesLeftCheckBox" .. i .. "_" .. k)
				end
			end
		end
		for i, val in _G.ipairs(_G.COMBAT_CONFIG_MESSAGETYPES_RIGHT) do
			skinCB("CombatConfigMessageTypesRightCheckBox" .. i)
			if val.subTypes then
				for k, _ in _G.pairs(val.subTypes) do
					skinCB("CombatConfigMessageTypesRightCheckBox" .. i .. "_" .. k)
				end
			end
		end
		for i, val in _G.ipairs(_G.COMBAT_CONFIG_MESSAGETYPES_MISC) do
			skinCB("CombatConfigMessageTypesMiscCheckBox" .. i)
			if val.subTypes then
				for k, _ in _G.pairs(val.subTypes) do
					skinCB("CombatConfigMessageTypesMiscCheckBox" .. i .. "_" .. k)
				end
			end
		end
		-- Colors
		for i = 1, #_G.COMBAT_CONFIG_UNIT_COLORS do
			if self.isClsc
			and _G["CombatConfigColorsUnitColorsSwatch" .. i].NineSlice
			then
				self:removeNineSlice(_G["CombatConfigColorsUnitColorsSwatch" .. i].NineSlice)
			else
				self:removeBackdrop(_G["CombatConfigColorsUnitColorsSwatch" .. i])
			end
		end
		self:skinObject("frame", {obj=_G.CombatConfigColorsUnitColors, fType=ftype, kfs=true, rns=true, fb=true})
		self:skinObject("frame", {obj=_G.CombatConfigColorsHighlighting, fType=ftype, kfs=true, rns=true, fb=true})
		self:skinObject("frame", {obj=_G.CombatConfigColorsColorizeUnitName, fType=ftype, kfs=true, rns=true, fb=true})
		self:skinObject("frame", {obj=_G.CombatConfigColorsColorizeSpellNames, fType=ftype, kfs=true, rns=true, fb=true})
		self:skinObject("frame", {obj=_G.CombatConfigColorsColorizeDamageNumber, fType=ftype, kfs=true, rns=true, fb=true})
		self:skinObject("frame", {obj=_G.CombatConfigColorsColorizeDamageSchool, fType=ftype, kfs=true, rns=true, fb=true})
		self:skinObject("frame", {obj=_G.CombatConfigColorsColorizeEntireLine, fType=ftype, kfs=true, rns=true, fb=true})
		if self.modChkBtns then
			self:skinCheckButton{obj=_G.CombatConfigColorsHighlightingLine}
			self:skinCheckButton{obj=_G.CombatConfigColorsHighlightingAbility}
			self:skinCheckButton{obj=_G.CombatConfigColorsHighlightingDamage}
			self:skinCheckButton{obj=_G.CombatConfigColorsHighlightingSchool}
			self:skinCheckButton{obj=_G.CombatConfigColorsColorizeUnitNameCheck}
			self:skinCheckButton{obj=_G.CombatConfigColorsColorizeSpellNamesCheck}
			self:skinCheckButton{obj=_G.CombatConfigColorsColorizeSpellNamesSchoolColoring}
			self:skinCheckButton{obj=_G.CombatConfigColorsColorizeDamageNumberCheck}
			self:skinCheckButton{obj=_G.CombatConfigColorsColorizeDamageNumberSchoolColoring}
			self:skinCheckButton{obj=_G.CombatConfigColorsColorizeDamageSchoolCheck}
			self:skinCheckButton{obj=_G.CombatConfigColorsColorizeEntireLineCheck}
		end
		-- Formatting
		if self.modChkBtns then
			self:skinCheckButton{obj=_G.CombatConfigFormattingShowTimeStamp}
			self:skinCheckButton{obj=_G.CombatConfigFormattingFullText}
			if not self.isClscERA then
				self:skinCheckButton{obj=_G.CombatConfigFormattingShowBraces}
				self:skinCheckButton{obj=_G.CombatConfigFormattingUnitNames}
				self:skinCheckButton{obj=_G.CombatConfigFormattingSpellNames}
				self:skinCheckButton{obj=_G.CombatConfigFormattingItemNames}
			end
		end
		-- Settings
		self:skinObject("editbox", {obj=_G.CombatConfigSettingsNameEditBox, fType=ftype})
		if self.modBtns then
			self:skinStdButton{obj=_G.CombatConfigSettingsSaveButton, fType=ftype}
		end
		if self.modChkBtns then
			self:skinCheckButton{obj=_G.CombatConfigSettingsShowQuickButton, fType=ftype}
			self:skinCheckButton{obj=_G.CombatConfigSettingsSolo, fType=ftype}
			self:skinCheckButton{obj=_G.CombatConfigSettingsParty, fType=ftype}
			self:skinCheckButton{obj=_G.CombatConfigSettingsRaid, fType=ftype}
		end
		self:skinObject("tabs", {obj=_G.ChatConfigCombatSettings, prefix="CombatConfig", numTabs=#_G.COMBAT_CONFIG_TABS, fType=ftype, lod=self.isTT and true, upwards=true, offsets={x1=2, y1=-8, x2=-2, y2=self.isTT and -5 or 0}, regions={4, 5}, track=false})
		if self.isTT then
			self:SecureHook("ChatConfig_UpdateCombatTabs", function(selectedTabID)
				local tab
				for i = 1, #_G.COMBAT_CONFIG_TABS do
					tab = _G[_G.CHAT_CONFIG_COMBAT_TAB_NAME .. i]
					if i == selectedTabID then
						self:setActiveTab(tab.sf)
					else
						self:setInactiveTab(tab.sf)
					end
				end
			end)
		end

		self:Unhook(this, "OnShow")
	end)

end

aObj.blizzFrames[ftype].ChatEditBox = function(self)
	if not self.prdb.ChatEditBox.skin or self.initialized.ChatEditBox then return end
	self.initialized.ChatEditBox = true

	if _G.IsAddOnLoaded("NeonChat")
	or _G.IsAddOnLoaded("Chatter")
	or _G.IsAddOnLoaded("Prat-3.0")
	then
		self.blizzFrames[ftype].ChatEditBox = nil
		return
	end

	local function skinChatEB(obj)
		aObj:keepFontStrings(obj)
		aObj:getRegion(obj, 2):SetAlpha(1) -- cursor texture
		if aObj.prdb.ChatEditBox.style == 1 then -- Frame
			aObj:skinObject("frame", {obj=obj, fType=ftype, ofs=-2})
		elseif aObj.prdb.ChatEditBox.style == 2 then -- Editbox
			aObj:skinObject("editbox", {obj=obj, fType=ftype, regions={}, ofs=-4})
		else -- Borderless
			aObj:skinObject("frame", {obj=obj, fType=ftype, noBdr=true, ofs=-5, y=2})
		end
		obj.sf:SetAlpha(obj:GetAlpha())
	end
	for i = 1, _G.NUM_CHAT_WINDOWS do
		skinChatEB(_G["ChatFrame" .. i].editBox)
	end
	-- if editBox has a skin frame then hook these to manage its Alpha setting
	if self.prdb.ChatEditBox.style ~= 2 then
		local function setAlpha(eBox)
			if eBox
			and eBox.sf
			then
				eBox.sf:SetAlpha(eBox:GetAlpha())
			end
		end
		self:SecureHook("ChatEdit_ActivateChat", function(editBox)
			setAlpha(editBox)
		end)
		self:SecureHook("ChatEdit_DeactivateChat", function(editBox)
			setAlpha(editBox)
		end)
	end

end

aObj.blizzFrames[ftype].ChatFrames = function(self)
	if not self.prdb.ChatFrames or self.initialized.ChatFrames then return end
	self.initialized.ChatFrames = true

	for i = 1, _G.NUM_CHAT_WINDOWS do
		self:skinObject("frame", {obj=_G["ChatFrame" .. i], fType=ftype, ofs=6, y1=_G["ChatFrame" .. i] == _G.COMBATLOG and 30, x2=27, y2=-9})
	end

	-- CombatLog Quick Button Frame & Progress Bar
	if self.prdb.CombatLogQBF then
		if _G.CombatLogQuickButtonFrame_Custom then
			_G.CombatLogQuickButtonFrame_Custom:DisableDrawLayer("BACKGROUND")
			self:skinObject("frame", {obj=_G.CombatLogQuickButtonFrame_Custom, fType=ftype, ofs=0, x1=-3, x2=3})
			self:adjHeight{obj=_G.CombatLogQuickButtonFrame_Custom, adj=4}
			self:skinStatusBar{obj=_G.CombatLogQuickButtonFrame_CustomProgressBar, fi=0, bgTex=_G.CombatLogQuickButtonFrame_CustomTexture}
		else
			self:skinStatusBar{obj=_G.CombatLogQuickButtonFrameProgressBar, fi=0, bgTex=_G.CombatLogQuickButtonFrameTexture}
		end
	end

end

aObj.blizzFrames[ftype].ChatMenus = function(self)
	if not self.prdb.ChatMenus or self.initialized.ChatMenus then return end
	self.initialized.ChatMenus = true

	self:skinObject("frame", {obj=_G.ChatMenu, fType=ftype, rns=true, ofs=0})
	self:skinObject("frame", {obj=_G.EmoteMenu, fType=ftype, rns=true, ofs=0})
	self:skinObject("frame", {obj=_G.LanguageMenu, fType=ftype, rns=true, ofs=0})
	self:skinObject("frame", {obj=_G.VoiceMacroMenu, fType=ftype, rns=true, ofs=0})
	self:skinObject("frame", {obj=_G.GeneralDockManagerOverflowButtonList, fType=ftype, rns=true, ofs=0})

end

aObj.blizzFrames[ftype].ChatTabs = function(self)
	if not self.prdb.ChatTabs or self.initialized.ChatTabs then return end
	self.initialized.ChatTabs = true

	local fcfTabs = {}
	for i = 1, _G.NUM_CHAT_WINDOWS do
		self:add2Table(fcfTabs, _G["ChatFrame" .. i .. "Tab"])
		self:SecureHook(_G["ChatFrame" .. i .. "Tab"], "SetParent", function(this, parent)
			if parent == _G.GeneralDockManager.scrollFrame.child then
				this.sf:SetParent(_G.GeneralDockManager)
			else
				this.sf:SetParent(this)
				this.sf:SetFrameLevel(1) -- reset frame level so that the texture is behind text etc
			end
		end)
		-- hook this to manage alpha changes when chat frame fades in and out
		self:SecureHook(_G["ChatFrame" .. i .. "Tab"], "SetAlpha", function(this, alpha)
			this.sf:SetAlpha(alpha)
		end)
	end
	local xOfs = 4
	if aObj.isClscBC then
		xOfs = 1
	end
	self:skinObject("tabs", {obj=_G.FloatingChatFrameManager, tabs=fcfTabs, fType=ftype, lod=self.isTT and true, upwards=true, ignoreHLTex=false, regions={7, 8, 9, 10, 11}, offsets={x1=xOfs, y1=self.isTT and -10 or -12, x2=xOfs * -1, y2=self.isTT and -3 or -1}, track=false, func=function(tab) tab.sf:SetAlpha(tab:GetAlpha()) tab.sf:Hide() end})
	if self.isTT then
		self:SecureHook("FCF_Tab_OnClick", function(this, _)
			for i = 1, _G.NUM_CHAT_WINDOWS do
				self:setInactiveTab(_G["ChatFrame" .. i .. "Tab"].sf)
			end
			self:setActiveTab(this.sf)
		end)
	end

	if self.prdb.ChatTabsFade then
		-- hook this to show/hide the skin frame
		self:SecureHook("FCFTab_UpdateColors", function(this, selected)
			if this.sf then
				this.sf:SetShown(selected)
			end
		end)
		_G.ChatFrame1Tab.sf:Show()
	end

end

aObj.blizzFrames[ftype].CinematicFrame = function(self)
	if not self.prdb.CinematicFrame or self.initialized.CinematicFrame then return end
	self.initialized.CinematicFrame = true

	self:SecureHookScript(_G.CinematicFrame, "OnShow", function(this)
		if self.isRtl then
			self:removeNineSlice(this.closeDialog.Border)
		end
		-- raidBossEmoteFrame ?
		self:skinObject("frame", {obj=this.closeDialog, fType=ftype})
		if self.modBtns then
			self:skinStdButton{obj=_G.CinematicFrameCloseDialogConfirmButton}
			self:skinStdButton{obj=_G.CinematicFrameCloseDialogResumeButton}
		end

		self:Unhook(this, "OnShow")
	end)

end

aObj.blizzFrames[ftype].CoinPickup = function(self)
	if not self.prdb.CoinPickup or self.initialized.CoinPickup then return end
	self.initialized.CoinPickup = true

	self:SecureHookScript(_G.CoinPickupFrame, "OnShow", function(this)
		self:addSkinFrame{obj=this, ft=ftype, kfs=true, x1=9, y1=-12, x2=-6, y2=12}

		self:Unhook(this, "OnShow")
	end)

end

aObj.blizzFrames[ftype].ColorPicker = function(self)
	if not self.prdb.ColorPicker or self.initialized.ColorPicker then return end
	self.initialized.ColorPicker = true

	self:SecureHookScript(_G.ColorPickerFrame, "OnShow", function(this)
		if self.isRtl then
			self:removeNineSlice(this.Border)
		end
		self:skinObject("slider", {obj=_G.OpacitySliderFrame, fType=ftype})
		self:skinObject("frame", {obj=this, fType=ftype, hdr=true, ofs=0})
		if self.modBtns then
			self:skinStdButton{obj=_G.ColorPickerOkayButton}
			self:skinStdButton{obj=_G.ColorPickerCancelButton}
		end

		self:Unhook(this, "OnShow")
	end)

	self:SecureHookScript(_G.OpacityFrame, "OnShow", function(this)
		-- used by BattlefieldMinimap amongst others
		self:removeNineSlice(this.Border)
		self:skinObject("slider", {obj=_G.OpacityFrameSlider, fType=ftype})
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, ofs=0, y1=-1})

		self:Unhook(this, "OnShow")
	end)

end

aObj.blizzLoDFrames[ftype].DebugTools = function(self)
	if not self.prdb.DebugTools or self.initialized.DebugTools then return end
	self.initialized.DebugTools = true

	local function skinTAD(frame)
		aObj:skinObject("editbox", {obj=frame.FilterBox, fType=ftype, si=true})
		aObj:skinObject("slider", {obj=frame.LinesScrollFrame.ScrollBar, fType=ftype})
		aObj:skinObject("frame", {obj=frame.ScrollFrameArt, fType=ftype, rns=true, fb=true})
		aObj:skinObject("frame", {obj=frame, fType=ftype, kfs=true, cb=true, ofs=-2, x1=5, x2=-1})
		if aObj.modBtns then
			aObj:skinOtherButton{obj=frame.OpenParentButton, font=aObj.fontS, disfont=aObj.fontDS, text=aObj.uparrow}
			aObj:skinOtherButton{obj=frame.NavigateBackwardButton, font=aObj.fontS, disfont=aObj.fontDS, text="x", size=32}
			aObj:skinOtherButton{obj=frame.NavigateForwardButton, font=aObj.fontS, disfont=aObj.fontDS, text="x", size=32}
			aObj:skinOtherButton{obj=frame.DuplicateButton, font=aObj.fontS, text=aObj.nearrow}
			aObj:clrBtnBdr(frame.NavigateBackwardButton)
			aObj:clrBtnBdr(frame.NavigateForwardButton)
			aObj:SecureHook(frame, "InspectTable", function(_, _)
				if frame.OpenParentButton:IsEnabled() then
					frame.OpenParentButton:SetText(aObj.uparrow)
				else
					frame.OpenParentButton:SetText("x")
				end
				aObj:clrBtnBdr(frame.OpenParentButton)
			end)
			aObj:SecureHook(frame, "UpdateTableNavigation", function(_, _)
				if frame.NavigateBackwardButton:IsEnabled() then
					frame.NavigateBackwardButton:SetText(aObj.larrow)
				else
					frame.NavigateBackwardButton:SetText("x")
				end
				if frame.NavigateForwardButton:IsEnabled() then
					frame.NavigateForwardButton:SetText(aObj.rarrow)
				else
					frame.NavigateForwardButton:SetText("x")
				end
				aObj:clrBtnBdr(frame.NavigateBackwardButton)
				aObj:clrBtnBdr(frame.NavigateForwardButton)
			end)
		end
		if aObj.modChkBtns then
			aObj:skinCheckButton{obj=frame.VisibilityButton}
			aObj:skinCheckButton{obj=frame.HighlightButton}
			aObj:skinCheckButton{obj=frame.DynamicUpdateButton}
		end
	end
	self:SecureHookScript(_G.TableAttributeDisplay, "OnShow", function(this)
		skinTAD(this)
		self:RawHook("DisplayTableInspectorWindow", function(...)
			local frame = self.hooks.DisplayTableInspectorWindow(...)
			skinTAD(frame)
			return frame
		end, true)

		self:Unhook(this, "OnShow")
	end)

	-- tooltips
	_G.C_Timer.After(0.1, function()
		self:add2Table(self.ttList, _G.FrameStackTooltip)
		_G.FrameStackTooltip:SetFrameLevel(20)
	end)

end

aObj.blizzLoDFrames[ftype].EventTrace = function(self)
	if not self.prdb.EventTrace or self.initialized.EventTrace then return end
	self.initialized.EventTrace = true

	local function skinMenuBtn(btn)
		aObj:skinStdButton{obj=btn, fType=ftype, y1=2, y2=-3}
		aObj.modUIBtns:chgHLTex(btn, btn.MouseoverOverlay)
	end
	aObj:SecureHookScript(_G.EventTrace, "OnShow", function(this)
		aObj:skinObject("editbox", {obj=this.Log.Bar.SearchBox, fType=ftype, si=true})
		aObj:skinObject("scrollbar", {obj=this.Log.Events.ScrollBar, fType=ftype, x1=0, x2=0})
		aObj:skinObject("scrollbar", {obj=this.Log.Search.ScrollBar, fType=ftype, x1=0, x2=0})
		aObj:skinObject("scrollbar", {obj=this.Filter.ScrollBar, fType=ftype, x1=0, x2=0})
		aObj:skinObject("frame", {obj=this, fType=ftype, kfs=true, ri=true, rns=true, cb=true, x2=aObj.isRtl and 3 or 1})
		if aObj.modBtns then
			skinMenuBtn(this.SubtitleBar.ViewLog)
			skinMenuBtn(this.SubtitleBar.ViewFilter)
			aObj:skinStdButton{obj=this.SubtitleBar.OptionsDropDown, fType=ftype, clr="grey"}
			skinMenuBtn(this.Log.Bar.MarkButton)
			skinMenuBtn(this.Log.Bar.PlaybackButton)
			skinMenuBtn(this.Log.Bar.DiscardAllButton)
			skinMenuBtn(this.Filter.Bar.CheckAllButton)
			skinMenuBtn(this.Filter.Bar.UncheckAllButton)
			skinMenuBtn(this.Filter.Bar.DiscardAllButton)
		end

		aObj:Unhook(this, "OnShow")
	end)
	if aObj.modBtns
	or aObj.modChkBtns
	then
		aObj:SecureHook(_G.EventTraceLogEventButtonMixin, "Init", function(this, _)
			if aObj.modBtns then
				aObj:skinCloseButton{obj=this.HideButton, fType=ftype, noSkin=true}
			end
		end)
		aObj:SecureHook(_G.EventTraceFilterButtonMixin, "Init", function(this, _)
			if aObj.modBtns then
				aObj:skinCloseButton{obj=this.HideButton, fType=ftype, noSkin=true}
			end
			if aObj.modChkBtns then
				aObj:skinCheckButton{obj=this.CheckButton, fType=ftype, ofs=-1}
			end
		end)
	end
	self:checkShown(_G.EventTrace)

	-- tooltip
	_G.C_Timer.After(0.1, function()
		self:add2Table(self.ttList, _G.EventTraceTooltip)
	end)

end

aObj.blizzLoDFrames[ftype].GMChatUI = function(self)
	if not self.prdb.GMChatUI or self.initialized.GMChatUI then return end
	self.initialized.GMChatUI = true

	self:SecureHookScript(_G.GMChatFrame, "OnShow", function(this)
		self:addSkinFrame{obj=_G.GMChatTab, ft=ftype, kfs=true, noBdr=self.isTT, y2=-4}
		if self.prdb.ChatFrames then
			self:addSkinFrame{obj=this, ft=ftype, x1=-4, y1=4, x2=4, y2=-8}
		end
		if self.modBtns then
			self:skinCloseButton{obj=_G.GMChatFrameCloseButton}
		end
		this:DisableDrawLayer("BORDER")
		if self.prdb.ChatEditBox.skin then
			if self.prdb.ChatEditBox.style == 1 then -- Frame
				local kRegions = _G.CopyTable(self.ebRgns)
				aObj:add2Table(kRegions, 12)
				self:keepRegions(this.editBox, kRegions)
				self:addSkinFrame{obj=this.editBox, ft=ftype, x1=2, y1=-2, x2=-2}
			elseif self.prdb.ChatEditBox.style == 2 then -- Editbox
				self:skinEditBox{obj=this.editBox, regs={12}, noHeight=true}
			else -- Borderless
				self:removeRegions(this.editBox, {6, 7, 8})
				self:addSkinFrame{obj=this.editBox, ft=ftype, noBdr=true, x1=5, y1=-4, x2=-5, y2=2}
			end
		end

		self:Unhook(this, "OnShow")
	end)

	self:SecureHookScript(_G.GMChatStatusFrame, "OnShow", function(this)
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, rns=true})

		self:Unhook(this, "OnShow")
	end)

end

aObj.blizzLoDFrames[ftype].GuildBankUI = function(self)
	if not self.prdb.GuildBankUI or self.initialized.GuildBankUI then return end
	self.initialized.GuildBankUI = true

	self:SecureHookScript(_G.GuildBankFrame, "OnShow", function(this)
		this.Emblem:Hide()
		for _, col in _G.pairs(this.Columns) do
			col:DisableDrawLayer("BACKGROUND")
			if self.modBtnBs then
				for _, btn in _G.pairs(col.Buttons) do
					self:addButtonBorder{obj=btn, ibt=true, clr="grey", ca=0.85}
				end
			end
		end
		if self.isRtl then
			self:skinObject("editbox", {obj=_G.GuildItemSearchBox, fType=ftype, si=true})
			this.MoneyFrameBG:DisableDrawLayer("BACKGROUND")
		end
		self:skinObject("tabs", {obj=this, prefix=this:GetName(), fType=ftype, lod=self.isTT and true, offsets={x1=9, y1=self.isTT and 2 or -3, x2=-9, y2=2}})
		-- Tabs (side)
		for _, tab in _G.pairs(this.BankTabs) do
			tab:DisableDrawLayer("BACKGROUND")
			if self.modBtnBs then
				 self:addButtonBorder{obj=tab.Button, relTo=tab.Button.IconTexture, ofs=3, x2=2}
			end
		end
		self:skinObject("slider", {obj=this.Log.TransactionsScrollFrame.ScrollBar, fType=ftype, rpTex="artwork"})
		self:skinObject("slider", {obj=this.Info.ScrollFrame.ScrollBar, fType=ftype, rpTex="artwork"})
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, hdr=true, cb=true, y1=self.isClscBC and -11, x2=self.isClscBC and 1, y2=self.isClscBC and 3 or -3})
		if self.modBtns then
			if self.isClscBC then
				self:skinCloseButton{obj=self:getChild(this, 11), fType=ftype}
			end
			self:skinStdButton{obj=this.DepositButton, x1=0} -- don't overlap withdraw button
			self:skinStdButton{obj=this.WithdrawButton, x2=0} -- don't overlap deposit button
			self:SecureHook(this.WithdrawButton, "Disable", function(bObj, _)
				self:clrBtnBdr(bObj)
			end)
			self:SecureHook(this.WithdrawButton, "Enable", function(bObj, _)
				self:clrBtnBdr(bObj)
			end)
			self:skinStdButton{obj=this.BuyInfo.PurchaseButton}
			self:SecureHook(this.BuyInfo.PurchaseButton, "Disable", function(bObj, _)
				self:clrBtnBdr(bObj)
			end)
			self:SecureHook(this.BuyInfo.PurchaseButton, "Enable", function(bObj, _)
				self:clrBtnBdr(bObj)
			end)
			self:skinStdButton{obj=this.Info.SaveButton}
		end

		self:Unhook(this, "OnShow")
	end)

	self:SecureHookScript(_G.GuildBankPopupFrame, "OnShow", function(this)
		self:adjHeight{obj=this, adj=20}
		if self.isClsc then
			self:removeRegions(_G.BorderBox, {1, 2, 3, 4, 5, 6, 7, 8})
		else
			self:removeRegions(this.BorderBox, {1, 2, 3, 4, 5, 6, 7, 8})
		end
		self:skinObject("editbox", {obj=this.EditBox, fType=ftype})
		self:adjHeight{obj=this.ScrollFrame, adj=20} -- stretch to bottom of scroll area
		self:skinSlider{obj=this.ScrollFrame.ScrollBar, rt="background"}
		for _, btn in _G.pairs(this.Buttons) do
			btn:DisableDrawLayer("BACKGROUND")
			if self.modBtnBs then
				self:addButtonBorder{obj=btn, relTo=btn.Icon, clr="grey"}
			end
		end
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, hdr=true, ofs=-6})
		if self.modBtns then
			self:skinStdButton{obj=this.CancelButton}
			self:skinStdButton{obj=this.OkayButton}
		end

		self:Unhook(this, "OnShow")
	end)

end

aObj.blizzFrames[ftype].HelpFrame = function(self)
	if not self.prdb.HelpFrame or self.initialized.HelpFrame then return end
	self.initialized.HelpFrame = true

	self:SecureHookScript(_G.HelpFrame, "OnShow", function(this)
		self:removeInset(this.Browser.BrowserInset)
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, hdr=true, ri=true, rns=true, cb=true, x1=self.isClsc and 0, x2=self.isClsc and 1 or 3})

		self:Unhook(this, "OnShow")
	end)

	self:SecureHookScript(_G.BrowserSettingsTooltip, "OnShow", function(this)
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true})
		if self.modBtns then
			self:skinStdButton{obj=_G.this.CookiesButton}
		end

		self:Unhook(this, "OnShow")
	end)

	self:SecureHookScript(_G.TicketStatusFrame, "OnShow", function(this)
		self:skinObject("frame", {obj=_G.TicketStatusFrameButton, fType=ftype})

		self:Unhook(this, "OnShow")
	end)
	self:checkShown(_G.TicketStatusFrame)

	self:SecureHookScript(_G.ReportCheatingDialog, "OnShow", function(this)
		this.Border.Bg:SetTexture(nil)
		self:removeNineSlice(this.Border)
		self:skinObject("frame", {obj=this.CommentFrame, fType=ftype, kfs=true, fb=true})
		self:skinObject("frame", {obj=this, fType=ftype, ofs=0})
		if self.modBtns then
			self:skinStdButton{obj=this.reportButton}
			self:skinStdButton{obj=_G.ReportCheatingDialogCancelButton}
			self:SecureHookScript(this.CommentFrame.EditBox, "OnTextChanged", function(ebObj)
				self:clrBtnBdr(ebObj:GetParent():GetParent().reportButton)
			end)
		end

		self:Unhook(this, "OnShow")
	end)

end

-- These functions are used by the InterfaceOptions & SystemOptions functions
local checkChild, skinKids, cName
function checkChild(child, frameType)
	cName = child:GetName()
	if aObj:isDropDown(child) then
		aObj:skinObject("dropdown", {obj=child, fType=frameType, x2=aObj.iofDD[cName]})
	elseif child:IsObjectType("Slider") then
		aObj:skinObject("slider", {obj=child, fType=frameType})
	elseif child:IsObjectType("CheckButton")
	and aObj.modChkBtns
	then
		aObj:skinCheckButton{obj=child, fType=frameType, hf=true} -- handle hide/show
	elseif child:IsObjectType("EditBox") then
		aObj:skinObject("editbox", {obj=child, fType=frameType})
	elseif child:IsObjectType("Button")
	and aObj.modBtns
	and not aObj.iofBtn[child]
	then
		aObj:skinStdButton{obj=child, fType=ftype}
	end
end
function skinKids(obj, frameType)
	-- wait for all objects to be created
	_G.C_Timer.After(0.1, function()
		for _, child in _G.ipairs{obj:GetChildren()} do
			checkChild(child, frameType)
		end
	end)
end
aObj.blizzFrames[ftype].InterfaceOptions = function(self)
	if not self.prdb.InterfaceOptions or self.initialized.InterfaceOptions then return end
	self.initialized.InterfaceOptions = true

	-- Interface
	self:SecureHookScript(_G.InterfaceOptionsFrame, "OnShow", function(this)
		if self.isRtl then
			self:removeNineSlice(this.Border)
		end
		self:skinObject("tabs", {obj=this, prefix=this:GetName(), fType=ftype, lod=self.isTT and true, upwards=true, offsets={x1=9, y1=self.isTT and 0 or -4, x2=-9, y2=self.isTT and -5 or 0}})
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, hdr=true})
		if self.modBtns then
			self:skinStdButton{obj=_G.InterfaceOptionsFrameCancel, fType=ftype}
			self:skinStdButton{obj=_G.InterfaceOptionsFrameOkay, fType=ftype}
			self:skinStdButton{obj=_G.InterfaceOptionsFrameDefaults, fType=ftype}
		end
		-- LHS panel (Game Tab)
		self:SecureHookScript(_G.InterfaceOptionsFrameCategories, "OnShow", function(fObj)
			self:skinObject("slider", {obj=_G.InterfaceOptionsFrameCategoriesListScrollBar, fType=ftype, x1=4, x2=-5})
			self:skinObject("frame", {obj=fObj, fType=ftype, kfs=true, rns=true, fb=true, ofs=-1})

			self:Unhook(fObj, "OnShow")
		end)
		self:checkShown(_G.InterfaceOptionsFrameCategories)
		-- LHS panel (AddOns tab)
		self:SecureHookScript(_G.InterfaceOptionsFrameAddOns, "OnShow", function(fObj)
			self:skinObject("slider", {obj=_G.InterfaceOptionsFrameAddOnsListScrollBar, fType=ftype, x1=4, x2=-5})
			self:skinObject("frame", {obj=fObj, fType=ftype, kfs=true, rns=true, fb=true, ofs=-1})
			if self.modBtns then
				-- skin toggle buttons
				for _, btn in _G.pairs(_G.InterfaceOptionsFrameAddOns.buttons) do
					self:skinExpandButton{obj=btn.toggle, fType=ftype, onSB=true, noHook=true}
					self:checkTex{obj=btn.toggle}
				end
				self:SecureHook("InterfaceAddOnsList_Update", function()
					for _, btn in _G.pairs(_G.InterfaceOptionsFrameAddOns.buttons) do
						self:checkTex{obj=btn.toggle}
					end
				end)
			end

			self:Unhook(fObj, "OnShow")
		end)
		self:checkShown(_G.InterfaceOptionsFrameAddOns)
		-- RHS Panel
		self:skinObject("frame", {obj=_G.InterfaceOptionsFramePanelContainer, fType=ftype, kfs=true, rns=true, fb=true, ofs=-1, y2=0})
		-- Social Browser Frame (Twitter integration)
		self:SecureHookScript(_G.SocialBrowserFrame, "OnShow", function(fObj)
			self:skinObject("frame", {obj=fObj, fType=ftype, kfs=true, cb=true, x2=1})

			self:Unhook(fObj, "OnShow")
		end)
		if self.modBtns then
			self:SecureHook(_G.InterfaceOptionsSocialPanel.EnableTwitter, "setFunc", function(_)
				-- N.B. gets called when panel not skinned
				if _G.InterfaceOptionsSocialPanel.TwitterLoginButton.sb then
					self:clrBtnBdr(_G.InterfaceOptionsSocialPanel.TwitterLoginButton)
				end
			end)
			if self.isRtl
			or self.isClscBC
			or self.isClscERAPTR
			then
				self:SecureHook(_G.InterfaceOptionsAccessibilityPanelConfigureTextToSpeech, "SetEnabled", function(bObj)
					self:clrBtnBdr(bObj)
				end)
				self:SecureHook(_G.InterfaceOptionsAccessibilityPanelRemoteTextToSpeechVoicePlaySample, "SetEnabled", function(bObj)
					self:clrBtnBdr(bObj)
				end)
			end
		end

		self:Unhook(this, "OnShow")
	end)

	-- skin extra elements
	self.RegisterMessage("IONP", "IOFPanel_After_Skinning", function(_, panel)
		if panel ~= _G.InterfaceOptionsNamesPanel then return end
		skinKids(_G.InterfaceOptionsNamesPanelFriendly, ftype)
		skinKids(_G.InterfaceOptionsNamesPanelEnemy, ftype)
		skinKids(_G.InterfaceOptionsNamesPanelUnitNameplates, ftype)

		self.UnregisterMessage("IONP", "IOFPanel_After_Skinning")
	end)

	self.RegisterMessage("CUFP", "IOFPanel_After_Skinning", function(_, panel)
		if panel ~= _G.CompactUnitFrameProfiles then
			return
		end
		if self.isRtl then
			self:removeNineSlice(_G.CompactUnitFrameProfiles.newProfileDialog.Border)
			self:removeNineSlice(_G.CompactUnitFrameProfiles.deleteProfileDialog.Border)
			self:removeNineSlice(_G.CompactUnitFrameProfiles.unsavedProfileDialog.Border)
		end
		skinKids(_G.CompactUnitFrameProfiles.newProfileDialog, ftype)
		self:skinObject("frame", {obj=_G.CompactUnitFrameProfiles.newProfileDialog, fType=ftype, ofs=0})
		skinKids(_G.CompactUnitFrameProfiles.deleteProfileDialog, ftype)
		self:skinObject("frame", {obj=_G.CompactUnitFrameProfiles.deleteProfileDialog, fType=ftype, ofs=0})
		skinKids(_G.CompactUnitFrameProfiles.unsavedProfileDialog, ftype)
		self:skinObject("frame", {obj=_G.CompactUnitFrameProfiles.unsavedProfileDialog, fType=ftype, ofs=0})
		skinKids(_G.CompactUnitFrameProfiles.optionsFrame, ftype)
		if self.modBtns then
			self:skinStdButton{obj=_G.CompactUnitFrameProfilesDeleteButton, fType=ftype}
			self:skinStdButton{obj=_G.CompactUnitFrameProfilesSaveButton, fType=ftype}
			self:SecureHook("CompactUnitFrameProfiles_UpdateManagementButtons", function()
				self:clrBtnBdr(_G.CompactUnitFrameProfilesDeleteButton)
				self:clrBtnBdr(_G.CompactUnitFrameProfilesSaveButton)
			end)
			self:SecureHook("CompactUnitFrameProfiles_UpdateNewProfileCreateButton", function()
				self:clrBtnBdr(_G.CompactUnitFrameProfiles.newProfileDialog.createButton)
			end)
		end
		_G.CompactUnitFrameProfiles.optionsFrame.autoActivateBG:SetTexture(nil)

		self.UnregisterMessage("CUFP", "IOFPanel_After_Skinning")
	end)

	-- hook this to skin Interface Option panels
	self:SecureHook("InterfaceOptionsList_DisplayPanel", function(panel)

		-- let AddOn skins know when IOF panel is going to be skinned
		self:SendMessage("IOFPanel_Before_Skinning", panel)
		self.callbacks:Fire("IOFPanel_Before_Skinning", panel)

		-- don't skin a panel twice
		if not self.iofSkinnedPanels[panel] then
			skinKids(panel, panel.GetName and panel:GetName() and panel:GetName():find("InterfaceOptions") and ftype)
			self.iofSkinnedPanels[panel] = true
		end

		-- let AddOn skins know when IOF panel has been skinned
		self:SendMessage("IOFPanel_After_Skinning", panel)
		self.callbacks:Fire("IOFPanel_After_Skinning", panel)

	end)

end

aObj.blizzFrames[ftype].ItemText = function(self)
	if not self.prdb.ItemText or self.initialized.ItemText then return end
	self.initialized.ItemText = true

	local function skinITFrame(frame)
		aObj:skinObject("slider", {obj=_G.ItemTextScrollFrame.ScrollBar, fType=ftype, rpTex=aObj.isClsc and {"background", "artwork"} or nil})
		aObj:skinStatusBar{obj=_G.ItemTextStatusBar, fi=0}
		if not aObj.isPTR then
			aObj:moveObject{obj=_G.ItemTextPrevPageButton, x=-55}
		end
		if not aObj.isClsc then
			aObj:skinObject("frame", {obj=frame, fType=ftype, kfs=true, ri=true, rns=true, cb=true, x2=3})
		else
			aObj:skinObject("frame", {obj=frame, fType=ftype, kfs=true, x1=10, y1=-12, x2=-31, y2=60})
			if aObj.modBtns then
				aObj:skinCloseButton{obj=_G.ItemTextCloseButton}
			end
		end
		if aObj.modBtnBs then
			-- N.B. page buttons are hidden or shown as required
			aObj:addButtonBorder{obj=_G.ItemTextPrevPageButton, ofs=-2, x1=1, clr="gold"}
			aObj:addButtonBorder{obj=_G.ItemTextNextPageButton, ofs=-2, x1=1, clr="gold"}
		end
		skinITFrame = nil
	end
	self:SecureHookScript(_G.ItemTextFrame, "OnShow", function(this)
		_G.ItemTextPageText:SetTextColor(self.BT:GetRGB())
		_G.ItemTextPageText:SetTextColor("P", self.BT:GetRGB())
		_G.ItemTextPageText:SetTextColor("H1", self.HT:GetRGB())
		_G.ItemTextPageText:SetTextColor("H2", self.HT:GetRGB())
		_G.ItemTextPageText:SetTextColor("H3", self.HT:GetRGB())
		if skinITFrame then
			skinITFrame(this)
		end
	end)

end

aObj.blizzLoDFrames[ftype].MacroUI = function(self)
	if not self.prdb.MacroUI or self.initialized.MacroUI then return end
	self.initialized.MacroUI = true

	self:SecureHookScript(_G.MacroFrame, "OnShow", function(this)
		self:skinObject("tabs", {obj=this, prefix=this:GetName(), fType=ftype, lod=self.isTT and true, upwards=true, offsets={x1=1, y1=-6, x2=-1, y2=self.isTT and -2 or 3}, func=function(tab) tab:SetFrameLevel(20) end})
		self:skinObject("frame", {obj=_G.MacroButtonScrollFrame, fType=ftype, kfs=true, fb=true, ofs=12, y1=10, x2=31})
		self:skinObject("slider", {obj=_G.MacroButtonScrollFrame.ScrollBar, fType=ftype, rpTex="artwork"})
		self:skinObject("slider", {obj=_G.MacroFrameScrollFrame.ScrollBar, fType=ftype})
		self:skinObject("frame", {obj=_G.MacroFrameTextBackground, fType=ftype, kfs=true, rns=true, fb=true, ofs=0, x2=1})
		_G.MacroFrameSelectedMacroButton:DisableDrawLayer("BACKGROUND")
		for i = 1, _G.MAX_ACCOUNT_MACROS do
			_G["MacroButton" .. i]:DisableDrawLayer("BACKGROUND")
			if self.modBtnBs then
				self:addButtonBorder{obj=_G["MacroButton" .. i], relTo=_G["MacroButton" .. i .. "Icon"], reParent={_G["MacroButton" .. i .. "Name"]}, clr="grey", ca=0.85}
			end
		end
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, hdr=true, ri=true, rns=true, cb=true})
		if self.modBtns then
			self:skinStdButton{obj=_G.MacroEditButton}
			self:skinStdButton{obj=_G.MacroCancelButton}
			self:skinStdButton{obj=_G.MacroSaveButton}
			self:skinStdButton{obj=_G.MacroDeleteButton}
			self:skinStdButton{obj=_G.MacroNewButton, x2=-2}
			self:skinStdButton{obj=_G.MacroExitButton, x1=2}
			for _, btn in _G.pairs{_G.MacroEditButton, _G.MacroDeleteButton, _G.MacroNewButton} do
				self:SecureHook(btn, "Disable", function(bObj, _)
					self:clrBtnBdr(bObj)
				end)
				self:SecureHook(btn, "Enable", function(bObj, _)
					self:clrBtnBdr(bObj)
				end)
			end
		end
		if self.modBtnBs then
			self:addButtonBorder{obj=_G.MacroFrameSelectedMacroButton, relTo=_G.MacroFrameSelectedMacroButtonIcon, clr="grey", ca=0.85}
		end

		self:Unhook(this, "OnShow")
	end)

	self:SecureHookScript(_G.MacroPopupFrame, "OnShow", function(this)
		self:adjHeight{obj=this, adj=20} -- so buttons don't overlay icons
		self:removeRegions(this.BorderBox, {1, 2, 3, 4, 5, 6, 7, 8})
		self:skinObject("editbox", {obj=_G.MacroPopupEditBox, fType=ftype})
		self:adjHeight{obj=_G.MacroPopupScrollFrame, adj=20} -- stretch to bottom of scroll area
		self:skinObject("slider", {obj=_G.MacroPopupScrollFrame.ScrollBar, fType=ftype, rpTex="background"})
		if self.isClscBC then
			self:skinObject("frame", {obj=this, fType=ftype, kfs=true, x2=-2, y2=4})
		else
			self:skinObject("frame", {obj=this, fType=ftype, kfs=true, ofs=2, y2=4})
		end
		if self.modBtns then
			self:skinStdButton{obj=this.BorderBox.CancelButton}
			self:skinStdButton{obj=this.BorderBox.OkayButton}
			self:SecureHook("MacroPopupOkayButton_Update", function()
				self:clrBtnBdr(this.BorderBox.OkayButton)
			end)
		end
		for i = 1, _G.NUM_MACRO_ICONS_SHOWN do
			_G["MacroPopupButton" .. i]:DisableDrawLayer("BACKGROUND")
			if self.modBtnBs then
				self:addButtonBorder{obj=_G["MacroPopupButton" .. i], relTo=_G["MacroPopupButton" .. i .. "Icon"], reParent={_G["MacroPopupButton" .. i .. "Name"]}, clr="grey", ca=0.85}
			end
		end

		self:Unhook(this, "OnShow")
	end)

end

aObj.blizzFrames[ftype].MailFrame = function(self)
	if not self.prdb.MailFrame or self.initialized.MailFrame then return end
	self.initialized.MailFrame = true

	self:SecureHookScript(_G.MailFrame, "OnShow", function(this)
		self:skinObject("tabs", {obj=this, prefix=this:GetName(), fType=ftype, offsets={x1=7, y1=self.isTT and 2 or -3, x2=-7, y2=2}})
		self:addSkinFrame{obj=this, ft=ftype, kfs=true, ri=true, x2=self.isClsc and 1 or 3}
		--	Inbox Frame
		for i = 1, _G.INBOXITEMS_TO_DISPLAY do
			self:keepFontStrings(_G["MailItem" .. i])
			_G["MailItem" .. i].Button:DisableDrawLayer("BACKGROUND")
			if self.modBtnBs then
				self:addButtonBorder{obj=_G["MailItem" .. i].Button, relTo=_G["MailItem" .. i].Button.Icon, reParent={_G["MailItem" .. i .. "ButtonCount"]}}
			end
		end
		self:moveObject{obj=_G.InboxTooMuchMail, y=-24} -- move icon down
		self:removeRegions(_G.InboxFrame, {1}) -- background texture
		if self.modBtns then
			self:skinStdButton{obj=_G.OpenAllMail}
			self:SecureHook(_G.OpenAllMail, "Disable", function(bObj, _)
				self:clrBtnBdr(bObj)
			end)
			self:SecureHook(_G.OpenAllMail, "Enable", function(bObj, _)
				self:clrBtnBdr(bObj)
			end)
		end
		if self.modBtnBs then
			self:addButtonBorder{obj=_G.InboxPrevPageButton, ofs=-2, y1=-3, x2=-3}
			self:addButtonBorder{obj=_G.InboxNextPageButton, ofs=-2, y1=-3, x2=-3}
			self:SecureHook("InboxFrame_Update", function(_)
				for i = 1, _G.INBOXITEMS_TO_DISPLAY do
					self:clrButtonFromBorder(_G["MailItem" .. i].Button)
				end
				self:clrPNBtns("Inbox")
			end)
		end
		--	Send Mail Frame
		self:keepFontStrings(_G.SendMailFrame)
		if self.isClscBC
		or self.isClscERAPTR
		then
			_G.MailEditBox.ScrollBox.EditBox:SetTextColor(self.BT:GetRGB())
			_G.MailEditBox:DisableDrawLayer("BACKGROUND")
			self:skinObject("scrollbar", {obj=_G.MailEditBoxScrollBar, fType=ftype, rpTex="background", x1=1, y1=-1, x2=5, y2=1})
		else
			self:skinSlider{obj=_G.SendMailScrollFrame.ScrollBar, rt={"background", "artwork"}}
			self:skinEditBox{obj=_G.SendMailBodyEditBox, noSkin=true}
			_G.SendMailBodyEditBox:SetTextColor(self.prdb.BodyText.r, self.prdb.BodyText.g, self.prdb.BodyText.b)
		end
		for i = 1, _G.ATTACHMENTS_MAX_SEND do
			if not self.modBtnBs then
				self:resizeEmptyTexture(self:getRegion(_G["SendMailAttachment" .. i], 1))
			else
				_G["SendMailAttachment" .. i]:DisableDrawLayer("BACKGROUND")
				self:addButtonBorder{obj=_G["SendMailAttachment" .. i], reParent={_G["SendMailAttachment" .. i].Count}}
			end
		end
		self:skinEditBox{obj=_G.SendMailNameEditBox, regs={3}, noWidth=true} -- N.B. region 3 is text
		self:skinEditBox{obj=_G.SendMailSubjectEditBox, regs={3}, noWidth=true} -- N.B. region 3 is text
		self:skinObject("moneyframe", {obj=_G.SendMailMoney, moveIcon=true, moveGEB=true, moveSEB=true})
		self:removeInset(_G.SendMailMoneyInset)
		_G.SendMailMoneyBg:DisableDrawLayer("BACKGROUND")
		if self.modBtns then
			self:skinStdButton{obj=_G.SendMailMailButton}
			self:skinStdButton{obj=_G.SendMailCancelButton}
			self:SecureHook(_G.SendMailMailButton, "Disable", function(bObj, _)
				self:clrBtnBdr(bObj)
			end)
			self:SecureHook(_G.SendMailMailButton, "Enable", function(bObj, _)
				self:clrBtnBdr(bObj)
			end)
		end
		--	Open Mail Frame
		_G.OpenMailScrollFrame:DisableDrawLayer("BACKGROUND")
		self:skinSlider{obj=_G.OpenMailScrollFrame.ScrollBar, rt="overlay"}
		_G.OpenMailBodyText:SetTextColor(self.BT:GetRGB())
		self:addSkinFrame{obj=_G.OpenMailFrame, ft=ftype, kfs=true, ri=true}
		if self.modBtns then
			self:skinStdButton{obj=_G.OpenMailReportSpamButton}
			self:skinStdButton{obj=_G.OpenMailCancelButton}
			self:skinStdButton{obj=_G.OpenMailDeleteButton}
			self:skinStdButton{obj=_G.OpenMailReplyButton}
			self:SecureHook("OpenMail_Update", function()
				self:clrBtnBdr(_G.OpenMailReportSpamButton)
				self:clrBtnBdr(_G.OpenMailReplyButton)
			end)

		end
		if self.modBtnBs then
			self:addButtonBorder{obj=_G.OpenMailLetterButton, ibt=true}
			self:addButtonBorder{obj=_G.OpenMailMoneyButton, ibt=true}
			for i = 1, _G.ATTACHMENTS_MAX_RECEIVE do
				self:addButtonBorder{obj=_G["OpenMailAttachmentButton" .. i], ibt=true}
			end
		end
		-- Invoice Frame Text fields
		local fields = {"ItemLabel", "Purchaser", "SalePrice", "Deposit", "HouseCut", "AmountReceived", "NotYetSent", "MoneyDelay"}
		if self.isClsc then
			self:add2Table(fields, "BuyMode")
		end
		for _, type in _G.pairs(fields) do
			_G["OpenMailInvoice" .. type]:SetTextColor(self.BT:GetRGB())
		end

		self:Unhook(this, "OnShow")
	end)

end

aObj.blizzFrames[ftype].MainMenuBarCommon = function(self)
	if self.initialized.MainMenuBarCommon then return end
	self.initialized.MainMenuBarCommon = true

	if _G.IsAddOnLoaded("Bartender4") then
		return
	end

	if self.prdb.MainMenuBar.skin then
		self:SecureHookScript(_G.StanceBarFrame, "OnShow", function(this)
			self:keepFontStrings(_G.StanceBarFrame)
			if self.modBtnBs then
				for _, btn in _G.pairs(_G.StanceBarFrame.StanceButtons) do
					self:addButtonBorder{obj=btn, abt=true, sft=true}
				end
			end

			self:Unhook(this, "OnShow")
		end)
		self:checkShown(_G.StanceBarFrame)

		-- TODO: change button references when PetActionButtonTemplate & ActionButtonTemplate are fixed
		self:SecureHookScript(_G.PetActionBarFrame, "OnShow", function(this)
			self:keepFontStrings(_G.PetActionBarFrame)
			if self.modBtnBs then
				local bName
				for i = 1, _G.NUM_PET_ACTION_SLOTS do
					bName = "PetActionButton" .. i
					self:addButtonBorder{obj=_G[bName], sft=true, reParent={_G[bName .. "AutoCastable"], _G[bName .. "SpellHighlightTexture"], _G[bName .. "Shine"]}, ofs=3, x2=2}
					_G[bName .. "NormalTexture"]:SetTexture(nil) -- $parentNormalTexture2 is the NormalTexture
				end
			end

			self:Unhook(this, "OnShow")
		end)
		self:checkShown(_G.PetActionBarFrame)
	end

end

aObj.blizzFrames[ftype].MenuFrames = function(self)
	if not self.prdb.MenuFrames or self.initialized.MenuFrames then return end
	self.initialized.MenuFrames = true

	self:SecureHookScript(_G.GameMenuFrame, "OnShow", function(this)
		if not self.isClsc then
			self:removeNineSlice(this.Border)
		end
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, hdr=true, ofs=0})
		if self.modBtns then
			for _, child in _G.ipairs{this:GetChildren()} do
				if child:IsObjectType("Button") then
					self:skinStdButton{obj=child, ofs=0}
				end
			end
		end

		self:Unhook(this, "OnShow")
	end)

	-- Rating Menu
	self:SecureHookScript(_G.RatingMenuFrame, "OnShow", function(this)
		if not self.isClsc then
			self:removeNineSlice(this.Border)
		end
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, hdr=true, ofs=0})
		if self.modBtns then
			self:skinStdButton{obj=_G.RatingMenuButtonOkay}
		end

		self:Unhook(this, "OnShow")
	end)

end

aObj.blizzFrames[ftype].Minimap = function(self)
	if not self.prdb.Minimap.skin or self.initialized.Minimap then return end
	self.initialized.Minimap = true

	if _G.IsAddOnLoaded("SexyMap")
	or _G.IsAddOnLoaded("BasicMinimap")
	then
		self.blizzFrames[ftype].Minimap = nil
		return
	end

	-- fix for Titan Panel moving MinimapCluster
	if _G.IsAddOnLoaded("Titan") then
		_G.TitanMovable_AddonAdjust("MinimapCluster", true)
	end

	-- hook this to handle Jostle Library
	if _G.LibStub:GetLibrary("LibJostle-3.0", true) then
		self:RawHook(_G.MinimapCluster, "SetPoint", function(this, point, relTo, relPoint, _)
			self.hooks[this].SetPoint(this, point, relTo, relPoint, -6, -18)
		end, true)
	end

	-- Cluster Frame
	_G.MinimapBorderTop:Hide()
	_G.MinimapZoneTextButton:ClearAllPoints()
	_G.MinimapZoneTextButton:SetPoint("BOTTOMLEFT", _G.Minimap, "TOPLEFT", 0, 5)
	_G.MinimapZoneTextButton:SetPoint("BOTTOMRIGHT", _G.Minimap, "TOPRIGHT", 0, 5)
	_G.MinimapZoneText:ClearAllPoints()
	_G.MinimapZoneText:SetPoint("CENTER")
	self:skinObject("button", {obj=_G.MinimapZoneTextButton, fType=ftype, x1=-5, x2=5})

	-- Minimap
	-- use file path for non Retail versions otherwise the minimap has a green overlay
	_G.Minimap:SetMaskTexture(self.isRtl and self.tFDIDs.w8x8 or [[Interface\Buttons\WHITE8X8]])
	-- use a backdrop with no Texture otherwise the map tiles are obscured
	self:skinObject("frame", {obj=_G.Minimap, fType=ftype, bd=8, ofs=5})
	if self.prdb.Minimap.gloss then
		_G.RaiseFrameLevel(_G.Minimap.sf)
	else
		_G.LowerFrameLevel(_G.Minimap.sf)
	end

	if self.isRtl then
		-- N.B. copied from SexyMap
		-- Removes the circular "waffle-like" texture that shows when using a non-circular minimap in the blue quest objective area.
		_G.Minimap:SetArchBlobRingScalar(0)
		_G.Minimap:SetArchBlobRingAlpha(0)
		_G.Minimap:SetQuestBlobRingScalar(0)
		_G.Minimap:SetQuestBlobRingAlpha(0)
		-- Difficulty indicators
		-- hook this to mamage MiniMapInstanceDifficulty texture
		self:SecureHook("MiniMapInstanceDifficulty_Update", function()
			local _, _, difficulty, _, maxPlayers, _, _ = _G.GetInstanceInfo()
			local _, _, isHeroic, _ = _G.GetDifficultyInfo(difficulty)
			local xOffset = 0
			if maxPlayers >= 10
			and maxPlayers <= 19
			then
				xOffset = -1
			end
			if isHeroic then
				_G.MiniMapInstanceDifficultyTexture:SetTexCoord(0.0, 0.25, 0.125, 0.5) -- remove top hanger texture
				_G.MiniMapInstanceDifficultyText:SetPoint("CENTER", xOffset, -1)
			else
				_G.MiniMapInstanceDifficultyTexture:SetTexCoord(0.0, 0.25, 0.625, 1) -- remove top hanger texture
				_G.MiniMapInstanceDifficultyText:SetPoint("CENTER", xOffset, 5)
			end
		end)
		self:moveObject{obj=_G.MiniMapInstanceDifficulty, x=6, y=-4}
		_G.GuildInstanceDifficultyHanger:SetAlpha(0)
		self:moveObject{obj=_G.GuildInstanceDifficulty, x=7}
		self:getRegion(_G.MiniMapChallengeMode, 1):SetTexCoord(0, 1, 0.27, 1.27) -- remove top hanger texture
		self:moveObject{obj=_G.MiniMapChallengeMode, x=6, y=-12}
	else
		if self.modBtns then
			_G.RaiseFrameLevelByTwo(_G.MinimapToggleButton)
			self:moveObject{obj=_G.MinimapToggleButton, x=-8, y=1}
			self:skinCloseButton{obj=_G.MinimapToggleButton, noSkin=true}
		end
	end

	self:keepFontStrings(_G.MinimapBackdrop)
	self:moveObject{obj=_G.BuffFrame, x=-40}

end

aObj.blizzFrames[ftype].MinimapButtons = function(self)
	if not self.prdb.MinimapButtons.skin or self.initialized.MinimapButtons then return end
	self.initialized.MinimapButtons = true

	if not self.modBtns then return end

	local ignBtn = {
		["GameTimeFrame"]                    = true,
		["GarrisonLandingPageMinimapButton"] = true,
		["MiniMapTracking"]                  = true,
		["MiniMapWorldMapButton"]            = true,
		["MinimapZoomIn"]                    = true,
		["MinimapZoomOut"]                   = true,
		["QueueStatusMinimapButton"]         = true,
		["OQ_MinimapButton"]                 = true,
	}
	local minBtn = self.prdb.MinimapButtons.style

	local function mmKids(mmObj)
		local objName, objType
		for _, obj in _G.ipairs{mmObj:GetChildren()} do
			objName, objType = obj:GetName(), obj:GetObjectType()
			if not ignBtn[obj]
			and obj ~= obj:GetParent().sf -- skinFrame
			and obj ~= obj:GetParent().sb -- skinButton
			and not obj.point -- TomTom waypoint
			and not obj.texture -- HandyNotes pin
			and objType == "Button"
			or (objType == "Frame" and objName == "MiniMapMailFrame")
			and not aObj:hasTextInName(objName, "SexyMap")
			then
				for _, reg in _G.ipairs{obj:GetRegions()} do
					if reg:GetObjectType() == "Texture" then
						-- change the DrawLayer to make the Icon show if required
						if aObj:hasAnyTextInName(reg, {"Icon", "icon"})
						or aObj:hasTextInTexture(reg, "Icon")
						then
							if reg:GetDrawLayer() == "BACKGROUND" then
								reg:SetDrawLayer("ARTWORK")
							end
							-- centre the icon
							reg:ClearAllPoints()
							reg:SetPoint("CENTER")
						elseif aObj:hasTextInName(reg, "Border")
						or aObj:hasTextInTexture(reg, "TrackingBorder")
						then
							reg:SetTexture(nil)
						elseif aObj:hasTextInTexture(reg, "Background") then
							reg:SetTexture(nil)
						end
					end
				end
				if not minBtn then
					if objType == "Button" then
						aObj:skinObject("button", {obj=obj, fType=ftype})
					else
						aObj:skinObject("frame", {obj=obj, fType=ftype})
					end
				end
			end
		end
	end
	local function makeBtnSquare(obj, x1, y1, x2, y2)
		obj:SetSize(26, 26)
		obj:GetNormalTexture():SetTexCoord(x1, y1, x2, y2)
		obj:GetPushedTexture():SetTexCoord(x1, y1, x2, y2)
		obj:SetHighlightTexture(aObj.tFDIDs.bHLS)
		obj:SetHitRectInsets(-5, -5, -5, -5)
		if not minBtn then
			aObj:skinObject("button", {obj=obj, fType=ftype, ng=true, bd=obj==_G.GameTimeFrame and 10 or 1, ofs=4})
		end
	end

	if not self.isClsc then
		-- Calendar button
		makeBtnSquare(_G.GameTimeFrame, 0.1, 0.31, 0.16, 0.6)
		-- MinimapBackdrop
		_G.MiniMapTrackingBackground:SetTexture(nil)
		_G.MiniMapTrackingButtonBorder:SetTexture(nil)
		if not minBtn then
			_G.MiniMapTracking:SetScale(0.9)
			self:skinObject("frame", {obj=_G.MiniMapTracking, fType=ftype})
		end
		_G.QueueStatusMinimapButtonBorder:SetTexture(nil)
		self:moveObject{obj=_G.QueueStatusMinimapButton, x=-16}
		if not minBtn then
			self:skinObject("button", {obj=_G.QueueStatusMinimapButton, fType=ftype, ofs=-1})
			_G.RaiseFrameLevelByTwo(_G.QueueStatusMinimapButton)
			_G.LowerFrameLevel(_G.QueueStatusMinimapButton.sb)
		end
		-- skin any moved Minimap buttons if required
		if _G.IsAddOnLoaded("MinimapButtonFrame") then
			mmKids(_G.MinimapButtonFrame)
		end
		-- show the Bongos minimap icon if required
		if _G.IsAddOnLoaded("Bongos") then
			_G.Bongos3MinimapButton.icon:SetDrawLayer("ARTWORK")
		end
	else
		-- remove ring from GameTimeFrame texture
		self:RawHook(_G.GameTimeTexture, "SetTexCoord", function(this, minx, maxx, miny, maxy)
			self.hooks[this].SetTexCoord(this, minx + 0.075, maxx - 0.075, miny + 0.175, maxy - 0.2)
		end, true)
		_G.C_Timer.After(0.25, function()
			_G.GameTimeFrame:SetSize(28, 28)
			self:moveObject{obj=_G.GameTimeFrame, x=-6, y=-2}
			_G.GameTimeFrame.timeOfDay = 0
			if not minBtn then
				self:skinObject("frame", {obj=_G.GameTimeFrame, fType=ftype, ng=true, ofs=4})
			end
			_G.GameTimeFrame_Update(_G.GameTimeFrame)
		end)
		_G.MiniMapTrackingBorder:SetTexture(nil)
		if not self.isClscBC then
			self:moveObject{obj=_G.MiniMapTrackingFrame, x=-15}
			if not minBtn then
				self:skinObject("frame", {obj=_G.MiniMapTrackingFrame, fType=ftype, bd=10, x1=4, y1=-3})
			end
		else
			self:moveObject{obj=_G.MiniMapTracking, x=-10}
			if not minBtn then
				self:skinObject("frame", {obj=_G.MiniMapTracking, fType=ftype})
			end
			_G.MiniMapBattlefieldFrame:SetSize(28, 28)
		end
		self:moveObject{obj=_G.MiniMapMailFrame, y=-4}
	end

	if self.isClsc then
		_G.MiniMapWorldBorder:SetTexture(nil)
	end
	_G.MiniMapWorldMapButton:ClearAllPoints()
	_G.MiniMapWorldMapButton:SetPoint("LEFT", _G.MinimapZoneTextButton, "RIGHT", -4, 0)
	self:skinOtherButton{obj=_G.MiniMapWorldMapButton, font=self.fontP, text="M", noSkin=minBtn}
	if _G.IsAddOnLoaded("SexyMap")
	or self.isClscBC
	then
		_G.MiniMapWorldMapButton:DisableDrawLayer("OVERLAY") -- border texture
	end
	_G.MiniMapMailIcon:SetTexture(self.tFDIDs.tMB)
	_G.MiniMapMailIcon:ClearAllPoints()
	_G.MiniMapMailIcon:SetPoint("CENTER", _G.MiniMapMailFrame)
	_G.MiniMapMailFrame:SetSize(26, 26)
	_G.TimeManagerClockButton:DisableDrawLayer("BORDER")
	_G.TimeManagerClockButton:SetSize(36, 14)
	if not _G.IsAddOnLoaded("SexyMap") then
		self:moveObject{obj=_G.TimeManagerClockTicker, x=-3, y=-1}
	end

	-- Zoom Buttons
	local btn, txt, xOfs, yOfs
	for _, btnName in _G.pairs{"In", "Out"} do
		if btnName == "In" then
			btn = _G.MinimapZoomIn
			txt = self.modUIBtns.plus
			if not self.isClsc then
				xOfs, yOfs = 14, -12
			else
				xOfs, yOfs = 9, -24
			end
		else
			btn = _G.MinimapZoomOut
			txt = self.modUIBtns.minus
			if not self.isClsc then
				xOfs, yOfs = 20, -10
			else
				xOfs, yOfs = 19, -12
			end
		end
		self:moveObject{obj=btn, x=xOfs, y=yOfs}
		self:skinOtherButton{obj=btn, text=txt, aso={bbclr=btn:IsEnabled() and "gold" or "disabled"}, noSkin=minBtn}
		if not minBtn then
			local function clrZoomBtns()
				for _, bName in _G.pairs{"In", "Out"} do
					btn = bName == "In" and _G.MinimapZoomIn or _G.MinimapZoomOut
					aObj:clrBBC(btn.sb, btn:IsEnabled() and "gold" or "disabled")
				end
			end
			self:SecureHookScript(btn, "OnClick", function(_)
				clrZoomBtns()
			end)
			self:RegisterEvent("MINIMAP_UPDATE_ZOOM", clrZoomBtns)
		end
	end

	-- skin Minimap children, allow for delayed addons to be loaded (e.g. Baggins)
	_G.C_Timer.After(0.5, function()
		mmKids(_G.Minimap)
	end)

	-- skin other minimap buttons
	local function skinMMBtn(_, mmBtn, _)
		for _, reg in _G.ipairs{mmBtn:GetRegions()} do
			if reg:GetObjectType() == "Texture" then
				if aObj:hasTextInName(reg, "Border")
				or aObj:hasTextInTexture(reg, "TrackingBorder")
				or aObj:hasTextInTexture(reg, "136430") -- file ID for Border texture
				or aObj:hasTextInTexture(reg, "136467") -- file ID for Background texture
				then
					reg:SetTexture(nil)
				end
			end
		end
		if not minBtn then
			aObj:skinObject("button", {obj=mmBtn})
		end
	end
	-- wait until all AddOn skins have been loaded
	_G.C_Timer.After(1.0, function()
		for addon, obj in _G.pairs(self.mmButs) do
			if _G.IsAddOnLoaded(addon) then
				skinMMBtn("Loaded Addons btns", obj)
			end
		end
	end)

	local function skinDBI(_, dbiBtn, name)
		dbiBtn:SetSize(24, 24)
		aObj:moveObject{obj=dbiBtn.icon, x=-3, y=3}
		skinMMBtn("LibDBIcon btn", dbiBtn, name)
	end
	self.DBIcon:RegisterCallback("LibDBIcon_IconCreated", skinDBI)
	for name, button in _G.pairs(self.DBIcon.objects) do
		skinDBI(nil, button, name)
	end

	-- Garrison Landing Page Minimap button
	if not self.isClsc then
		local anchor = _G.AnchorUtil.CreateAnchor("TOPLEFT", "MinimapBackdrop", "TOPLEFT", 32, -140)
		local function skinGLPM(mBtn)
			if _G.C_Garrison.GetLandingPageGarrisonType() == _G.Enum.GarrisonType.Type_9_0
			and _G.C_Covenants.GetCovenantData(_G.C_Covenants.GetActiveCovenantID())
			then
				makeBtnSquare(mBtn, 0.2, 0.76, 0.2, 0.76)
			elseif _G.select(4, _G.GetBuildInfo()) > 79999 then -- BfA
				makeBtnSquare(mBtn, 0.30, 0.70, 0.26, 0.70)
			else
				makeBtnSquare(mBtn, 0.25, 0.76, 0.32, 0.685)
			end
			anchor:SetPoint(mBtn, true)
		end
		skinGLPM(_G.GarrisonLandingPageMinimapButton)
		self:SecureHook("GarrisonLandingPageMinimapButton_UpdateIcon", function(this)
			skinGLPM(this)
		end)
		_G.GarrisonLandingPageMinimapButton.AlertBG:SetTexture(nil)
	end

end

aObj.blizzLoDFrames[ftype].MovePad = function(self)
	if not self.prdb.MovePad or self.initialized.MovePad then return end
	self.initialized.MovePad = true

	self:SecureHookScript(_G.MovePadFrame, "OnShow", function(this)
		_G.MovePadRotateLeft.icon:SetTexture(self.tFDIDs.rB)
		_G.MovePadRotateRight.icon:SetTexture(self.tFDIDs.rB)
		_G.MovePadRotateRight.icon:SetTexCoord(1, 0, 0, 1) -- flip texture horizontally
		self:addSkinFrame{obj=this, ft=ftype}
		if self.modBtns then
			self:skinStdButton{obj=_G.MovePadForward}
			self:skinStdButton{obj=_G.MovePadJump}
			self:skinStdButton{obj=_G.MovePadRotateLeft}
			self:skinStdButton{obj=_G.MovePadRotateRight}
			self:skinStdButton{obj=_G.MovePadBackward}
			self:skinStdButton{obj=_G.MovePadStrafeLeft}
			self:skinStdButton{obj=_G.MovePadStrafeRight}
			-- Lock button, change texture
			local tex = _G.MovePadLock:GetNormalTexture()
			tex:SetTexture(self.tFDIDs.gAOI)
			tex:SetTexCoord(0, 0.25, 0, 1.0)
			tex:SetAlpha(1)
			tex = _G.MovePadLock:GetPushedTexture()
			tex:SetTexture(self.tFDIDs.gAOI)
			tex:SetTexCoord(0.25, 0.5, 0, 1.0)
			tex:SetAlpha(0.75)
			tex = _G.MovePadLock:GetCheckedTexture()
			tex:SetTexture(self.tFDIDs.gAOI)
			tex:SetTexCoord(0.25, 0.5, 0, 1.0)
			tex:SetAlpha(1)
			self:moveObject{obj=_G.MovePadLock, x=-6, y=7} -- move it up and left
		end

		self:Unhook(this, "OnShow")
	end)
	self:checkShown(_G.MovePadFrame)

end

aObj.blizzFrames[ftype].MovieFrame = function(self)
	if not self.prdb.MovieFrame or self.initialized.MovieFrame then return end
	self.initialized.MovieFrame = true

	self:SecureHookScript(_G.MovieFrame, "OnShow", function(this)
		self:removeNineSlice(this.CloseDialog.Border)
		self:addSkinFrame{obj=this.CloseDialog, ft=ftype, nb=true}
		if self.modBtns then
			self:skinStdButton{obj=this.CloseDialog.ConfirmButton}
			self:skinStdButton{obj=this.CloseDialog.ResumeButton}
		end

		self:Unhook(this, "OnShow")
	end)

end

aObj.blizzFrames[ftype].Nameplates = function(self)
	if not self.prdb.Nameplates or self.initialized.Nameplates then return end
	self.initialized.Nameplates = true

	if _G.IsAddOnLoaded("Plater") then
		self.blizzFrames[ftype].Nameplates = nil
		return
	end

	local function skinNamePlate(frame)
		if not frame -- happens when called again after combat and frame doesn't exist any more
		or frame:IsForbidden()
		then
			return
		end
		if _G.InCombatLockdown() then
		    aObj:add2Table(aObj.oocTab, {skinNamePlate, {frame}})
		    return
		end
		local nP = frame.UnitFrame or aObj:getChild(frame, 1)
		if nP
		and nP.healthBar
		then
			local nHb, nCb = nP.healthBar, nP.castBar or nP.CastBar
			nHb.border:DisableDrawLayer("ARTWORK")
			if aObj.isRtl then
				aObj:skinObject("statusbar", {obj=nHb, fi=0, bg=nHb.background, other={nHb.myHealPrediction, nHb.otherHealPrediction}})
				if nCb then
					aObj:skinObject("statusbar", {obj=nCb, fi=0, bg=nCb.background})
				end
			else
				aObj:skinObject("statusbar", {obj=nHb, fi=0, bg=nHb.background})
				if aObj.isClscBC then
					aObj:skinObject("statusbar", {obj=nCb, fi=0, bg=aObj:getRegion(nCb, 1)})
					aObj:nilTexture(nCb.Border, true)
					aObj:nilTexture(nCb.BorderShield, true)
				end
			end
			-- N.B. WidgetContainer objects managed in UIWidgets code
		end
	end
	self:SecureHook(_G.NamePlateDriverFrame, "OnNamePlateAdded", function(_, namePlateUnitToken)
		skinNamePlate(_G.C_NamePlate.GetNamePlateForUnit(namePlateUnitToken, _G.issecure()))
	end)
	for _, frame in _G.ipairs(_G.C_NamePlate.GetNamePlates(_G.issecure())) do
		skinNamePlate(frame)
	end

	-- Class Nameplate Frames
	if self.isRtl then
		local mF = _G.ClassNameplateManaBarFrame
		if mF then
			self:skinObject("statusbar", {obj=mF, fi=0, other={mF.ManaCostPredictionBar, mF.FeedbackFrame.BarTexture}})
		end
		-- DeathKnight (nothing to skin)
		-- Mage (nothing to skin)
		-- Monk
		for i = 1, #_G.ClassNameplateBarWindwalkerMonkFrame.Chi do
			_G.ClassNameplateBarWindwalkerMonkFrame.Chi[i]:DisableDrawLayer("BACKGROUND")
		end
		self:skinObject("statusbar", {obj=_G.ClassNameplateBrewmasterBarFrame, fi=0})
		-- Paladin
		for i = 1, #_G.ClassNameplateBarPaladinFrame.Runes do
			_G.ClassNameplateBarPaladinFrame.Runes[i].OffTexture:SetTexture(nil)
		end
		-- Rogue/Druid
		for i = 1, #_G.ClassNameplateBarRogueDruidFrame.ComboPoints do
			_G.ClassNameplateBarRogueDruidFrame.ComboPoints[i]:DisableDrawLayer("BACKGROUND")
		end
		-- Warlock
		for i = 1, #_G.ClassNameplateBarWarlockFrame.Shards do
			_G.ClassNameplateBarWarlockFrame.Shards[i].ShardOff:SetTexture(nil)
		end
	end

	-- tooltip
	_G.C_Timer.After(0.1, function()
		self:add2Table(self.ttList, _G.NamePlateTooltip)
	end)

end

-- PTR Feedback Tool
if _G.PTR_IssueReporter then
	aObj.blizzFrames[ftype].PTRFeedback = function(self)
		if not self.prdb.PTRFeedback or self.initialized.PTRFeedback then return end
		self.initialized.PTRFeedback = true

		local function skinFrame(frame, ofs, border)
			if frame.Border then
				aObj:removeBackdrop(frame.Border)
			end
			aObj:skinObject("frame", {obj=frame, fType=ftype, kfs=not border and true, ofs=ofs or 4, clr="blue"})
		end
		skinFrame(_G.PTR_IssueReporter)
		for _, name in _G.pairs{"Confused", "ReportBug"} do
			_G.PTR_IssueReporter[name]:SetPushedTexture(nil)
			self:removeBackdrop(_G.PTR_IssueReporter[name].Border)
			self:skinObject("button", {obj=_G.PTR_IssueReporter[name], fType=ftype, clr="blue"})
		end

		self:SecureHook(_G.PTR_IssueReporter, "GetStandaloneSurveyFrame", function(_)
			skinFrame(_G.PTR_IssueReporter.StandaloneSurvey, 2) -- header frame
			skinFrame(_G.PTR_IssueReporter.StandaloneSurvey.SurveyFrame)
			if self.modBtns then
				self:skinCloseButton{obj=self:getChild(_G.PTR_IssueReporter.StandaloneSurvey.SurveyFrame, 2), noSkin=true}
				self:skinStdButton{obj=self:getChild(_G.PTR_IssueReporter.StandaloneSurvey.SurveyFrame, 3), ofs=-1, clr="blue"}
			end

			self:Unhook(_G.PTR_IssueReporter, "GetStandaloneSurveyFrame")
		end)

		self:SecureHook(_G.PTR_IssueReporter, "BuildSurveyFrameFromSurveyData", function(surveyFrame, _)
			skinFrame(surveyFrame)
			for _, frame in _G.pairs(surveyFrame.FrameComponents) do
				skinFrame(frame, 2, true)
				if frame.FrameType == "MultipleChoice"
				and self.modChkBtns then
					for _, checkBox in _G.pairs(frame.Checkboxes) do
						self:skinCheckButton{obj=checkBox}
					end
				-- elseif frame.FrameType == "StandaloneQuestion" then
				-- elseif frame.FrameType == "ModelViewer" then
				-- elseif frame.FrameType == "IconViewer" then
				end
			end
		end)

	end
end

aObj.blizzFrames[ftype].SharedBasicControls = function(self)
	if not self.prdb.SharedBasicControls or self.initialized.SharedBasicControls then return end
	self.initialized.SharedBasicControls = true

	self:SecureHookScript(_G.BasicMessageDialog, "OnShow", function(this)
		self:removeNineSlice(this.Border)
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, ofs=0})
		if self.modBtns then
			self:skinStdButton{obj=_G.BasicMessageDialogButton, fType=ftype}
		end

		self:Unhook(this, "OnShow")
	end)

	self:SecureHookScript(_G.ScriptErrorsFrame, "OnShow", function(this)
		self:skinObject("slider", {obj=this.ScrollFrame.ScrollBar, fType=ftype})
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, ofs=-1, y1=-2})
		if self.modBtns then
			self:skinCloseButton{obj=_G.ScriptErrorsFrameClose}
			self:skinStdButton{obj=this.Reload}
			self:skinStdButton{obj=this.Close}
		end
		if self.modBtnBs then
			self:addButtonBorder{obj=this.PreviousError, ofs=-3, x1=2, clr="gold"}
			self:addButtonBorder{obj=this.NextError, ofs=-3, x1=2, clr="gold"}
			self:SecureHook(this, "UpdateButtons", function(fObj)
				self:clrBtnBdr(fObj.PreviousError,"gold")
				self:clrBtnBdr(fObj.NextError, "gold")
			end)
		end

		self:Unhook(this, "OnShow")
	end)
	self:checkShown(_G.ScriptErrorsFrame)

end

--> N.B. The following frame can't be skinned, as the XML has a ScopedModifier element saying forbidden="true"
	-- SocialUI

aObj.blizzFrames[ftype].StackSplit = function(self)
	if not self.prdb.StackSplit or self.initialized.StackSplit then return end
	self.initialized.StackSplit = true

	self:SecureHookScript(_G.StackSplitFrame, "OnShow", function(this)
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, ofs=-10, x2=-8})
		if self.modBtns then
			if self.isRtl then
				self:skinStdButton{obj=_G.StackSplitFrame.OkayButton, fType=ftype}
				self:skinStdButton{obj=_G.StackSplitFrame.CancelButton, fType=ftype}
			else
				self:skinStdButton{obj=_G.StackSplitOkayButton, fType=ftype}
				self:skinStdButton{obj=_G.StackSplitCancelButton, fType=ftype}
			end
		end
		self:SendMessage("StackSplit_skinned")

		self:Unhook(this, "OnShow")
	end)

end

aObj.blizzFrames[ftype].StaticPopups = function(self)
	if not self.prdb.StaticPopups or self.initialized.StaticPopups then return end
	self.initialized.StaticPopups = true

	if self.modBtns then
		-- hook this to handle close button texture changes
		self:SecureHook("StaticPopup_Show", function(_)
			local nTex
			for i = 1, _G.STATICPOPUP_NUMDIALOGS do
				nTex = _G["StaticPopup" .. i .. "CloseButton"]:GetNormalTexture()
				if self:hasTextInTexture(nTex, "HideButton") then
					_G["StaticPopup" .. i .. "CloseButton"]:SetText(self.modUIBtns.minus)
				elseif self:hasTextInTexture(nTex, "MinimizeButton") then
					_G["StaticPopup" .. i .. "CloseButton"]:SetText(self.modUIBtns.mult)
				end
			end
		end)
	end

	for i = 1, _G.STATICPOPUP_NUMDIALOGS do
		self:SecureHookScript(_G["StaticPopup" .. i], "OnShow", function(this)
			if self.isRtl then
				self:removeNineSlice(this.Border)
			end
			this.Separator:SetTexture(nil)
			local objName = this:GetName()
			self:skinObject("editbox", {obj=_G[objName .. "EditBox"], fType=ftype, ofs=0, y1=-4, y2=4})
			self:skinObject("moneyframe", {obj=_G[objName .. "MoneyInputFrame"]})
			_G[objName .. "ItemFrameNameFrame"]:SetTexture(nil)
			self:skinObject("frame", {obj=this, fType=ftype, ofs=-6})
			if self.modBtns then
				self:skinStdButton{obj=this.button1, y1=2}
				self:SecureHook(this.button1, "Disable", function(bObj, _)
					self:clrBtnBdr(bObj)
				end)
				self:SecureHook(this.button1, "Enable", function(bObj, _)
					self:clrBtnBdr(bObj)
				end)
				self:SecureHook(this.button1, "SetEnabled", function(bObj)
					self:clrBtnBdr(bObj)
				end)
				self:skinStdButton{obj=this.button2, y1=2}
				self:SecureHook(this.button2, "Disable", function(bObj, _)
					self:clrBtnBdr(bObj)
				end)
				self:SecureHook(this.button2, "Enable", function(bObj, _)
					self:clrBtnBdr(bObj)
				end)
				self:SecureHook(this.button2, "SetEnabled", function(bObj)
					self:clrBtnBdr(bObj)
				end)
				self:skinStdButton{obj=this.button3, y1=2}
				self:SecureHook(this.button3, "Disable", function(bObj, _)
					self:clrBtnBdr(bObj)
				end)
				self:SecureHook(this.button3, "SetEnabled", function(bObj)
					self:clrBtnBdr(bObj)
				end)
				self:skinStdButton{obj=this.button4, y1=2}
				self:SecureHook(this.button4, "Disable", function(bObj, _)
					self:clrBtnBdr(bObj)
				end)
				self:SecureHook(this.button4, "Enable", function(bObj, _)
					self:clrBtnBdr(bObj)
				end)
				self:skinStdButton{obj=this.extraButton, y1=2}
				self:SecureHook(this.extraButton, "Disable", function(bObj, _)
					self:clrBtnBdr(bObj)
				end)
				self:SecureHook(this.extraButton, "Enable", function(bObj, _)
					self:clrBtnBdr(bObj)
				end)
			end
			if self.modBtnBs then
				self:addButtonBorder{obj=_G[objName .. "ItemFrame"], ibt=true}
			end
			-- prevent FrameLevel from being changed (LibRock does this)
			this.sf.SetFrameLevel = _G.nop

			self:Unhook(this, "OnShow")
		end)
		-- check to see if already being shown
		self:checkShown(_G["StaticPopup" .. i])
	end

	local function skinReportFrame(frame)
		aObj:skinObject("frame", {obj=frame.Comment, fType=ftype, kfs=true, fb=true})
		aObj:skinObject("frame", {obj=frame, fType=ftype, kfs=true})
		if aObj.modBtns then
			aObj:skinStdButton{obj=frame.ReportButton}
			aObj:skinStdButton{obj=frame.CancelButton}
		end
	end
	if not self.isClsc then
		self:SecureHookScript(_G.PetBattleQueueReadyFrame, "OnShow", function(this)
			self:removeNineSlice(this.Border)
			self:skinObject("frame", {obj=this, fType=ftype, kfs=true})
			if self.modBtns then
				self:skinStdButton{obj=this.AcceptButton}
				self:skinStdButton{obj=this.DeclineButton}
			end

			self:Unhook(this, "OnShow")
		end)
		self:SecureHook(_G.PlayerReportFrame, "ShowReportDialog", function(this, _)
			self:removeNineSlice(this.Border)
			skinReportFrame(this)

			self:Unhook(this, "ShowReportDialog")
		end)
		self:SecureHook(_G.ClubFinderReportFrame, "ShowReportDialog", function(this, _)
			self:removeNineSlice(this.Border)
			skinReportFrame(this)

			self:Unhook(this, "ShowReportDialog")
		end)
	else
		self:SecureHook(_G.PlayerReportFrame, "InitiateReport", function(this, _)
			skinReportFrame(this)

			self:Unhook(this, "InitiateReport")
		end)
	end

end

aObj.blizzFrames[ftype].SystemOptions = function(self)
	if not self.prdb.SystemOptions or self.initialized.SystemOptions then return end
	self.initialized.SystemOptions = true

	self:SecureHookScript(_G.VideoOptionsFrame, "OnShow", function(this)
		if self.isRtl then
			self:removeNineSlice(this.Border)
		end
		self:skinObject("frame", {obj=_G.VideoOptionsFrameCategoryFrame, fType=ftype, kfs=true, rns=true, fb=true})
		self:skinObject("slider", {obj=_G.VideoOptionsFrameCategoryFrameListScrollBar, fType=ftype, x1=4, x2=-5})
		self:skinObject("frame", {obj=_G.VideoOptionsFramePanelContainer, fType=ftype, kfs=true, rns=true, fb=true})
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, hdr=true})
		_G.VideoOptionsFrameApply:SetFrameLevel(2) -- make it appear above the PanelContainer
		if self.modBtns then
			self:skinStdButton{obj=_G.VideoOptionsFrameApply, fType=ftype}
			self:skinStdButton{obj=_G.VideoOptionsFrameCancel, fType=ftype}
			self:skinStdButton{obj=_G.VideoOptionsFrameOkay, fType=ftype}
			self:skinStdButton{obj=_G.VideoOptionsFrameDefaults, fType=ftype}
			if self.isClsc then
				self:skinStdButton{obj=_G.VideoOptionsFrameClassic, fType=ftype}
			end
			self:SecureHook(_G.VideoOptionsFrameApply, "Disable", function(bObj)
				self:clrBtnBdr(bObj)
			end)
			self:SecureHook(_G.VideoOptionsFrameApply, "Enable", function(bObj)
				self:clrBtnBdr(bObj)
			end)
		end
		self:skinObject("tabs", {obj=_G.Display_, tabs={_G.GraphicsButton, _G.RaidButton}, fType=ftype, upwards=true, offsets={x1=4, y1=0, x2=0, y2=self.isTT and -3 or 2}, track=false, func=function(tab) tab:SetFrameLevel(20) tab.SetFrameLevel = _G.nop end})
		if self.isTT then
			self:SecureHook("GraphicsOptions_SelectBase", function()
				self:setActiveTab(_G.GraphicsButton.sf)
				self:setInactiveTab(_G.RaidButton.sf)
			end)
			self:SecureHook("GraphicsOptions_SelectRaid", function()
				if _G.Display_RaidSettingsEnabledCheckBox:GetChecked() then
					self:setActiveTab(_G.RaidButton.sf)
					self:setInactiveTab(_G.GraphicsButton.sf)
				end
			end)
		end
		skinKids(_G.Display_, ftype)
		self:skinObject("frame", {obj=_G.Display_, fType=ftype, kfs=true, rns=true, fb=true})
		skinKids(_G.Graphics_, ftype)
		self:skinObject("frame", {obj=_G.Graphics_, fType=ftype, kfs=true, rns=true, fb=true})
		skinKids(_G.RaidGraphics_, ftype)
		self:skinObject("frame", {obj=_G.RaidGraphics_, fType=ftype, kfs=true, rns=true, fb=true})

		self:Unhook(this, "OnShow")
	end)
	if self.isClsc then
		self:SecureHook("VideoOptionsDropDownMenu_DisableDropDown", function(dropDown)
			self:checkDisabledDD(dropDown)
		end)
		self:SecureHook("VideoOptionsDropDownMenu_EnableDropDown", function(dropDown)
			self:checkDisabledDD(dropDown)
		end)
	end

	-- Advanced
	self:SecureHookScript(_G.Advanced_, "OnShow", function(this)
		skinKids(this, ftype)

		self:Unhook(this, "OnShow")
	end)
	-- Network
	self:SecureHookScript(_G.NetworkOptionsPanel, "OnShow", function(this)
		skinKids(this, ftype)

		self:Unhook(this, "OnShow")
	end)
	-- Languages
	self:SecureHookScript(_G.InterfaceOptionsLanguagesPanel, "OnShow", function(this)
		skinKids(this, ftype)

		self:Unhook(this, "OnShow")
	end)
	-- Keyboard
	self:SecureHookScript(_G.MacKeyboardOptionsPanel, "OnShow", function(this)
		-- Languages
		skinKids(this, ftype)

		self:Unhook(this, "OnShow")
	end)
	-- Sound
	self:SecureHookScript(_G.AudioOptionsSoundPanel, "OnShow", function(this)
		skinKids(this, ftype)
		self:skinObject("frame", {obj=_G.AudioOptionsSoundPanelPlayback, fType=ftype, kfs=true, rns=true, fb=true})
		self:skinObject("frame", {obj=_G.AudioOptionsSoundPanelHardware, fType=ftype, kfs=true, rns=true, fb=true})
		self:skinObject("frame", {obj=_G.AudioOptionsSoundPanelVolume, fType=ftype, kfs=true, rns=true, fb=true})

		self:Unhook(this, "OnShow")
	end)
	-- Voice
	self:SecureHookScript(_G.AudioOptionsVoicePanel, "OnShow", function(this)
		self.iofBtn[this.PushToTalkKeybindButton] = true
		skinKids(this, ftype)
		this.TestInputDevice.ToggleTest:DisableDrawLayer("BACKGROUND")
		self:skinObject("frame", {obj=this.TestInputDevice.VUMeter, fType=ftype, kfs=true, rns=true, fb=true})
		if self.modBtnBs then
			self:addButtonBorder{obj=this.TestInputDevice.ToggleTest, fType=ftype, ofs=0, y2=-2}
			self:skinStdButton{obj=this.PushToTalkKeybindButton, fType=ftype}
			this.PushToTalkKeybindButton.KeyLabel:SetDrawLayer("ARTWORK")
			if not self.isClsc then
				self:skinStdButton{obj=this.MacMicrophoneAccessWarning.OpenAccessButton, fType=ftype}
			end
		end

		self:Unhook(this, "OnShow")
	end)

end

if aObj.isRtl
or aObj.isClscBC
or aObj.isClscERAPTR
then
	aObj.blizzFrames[ftype].TextToSpeechFrame = function(self)
		if not self.prdb.TextToSpeechFrame or self.initialized.TextToSpeechFrame then return end
		self.initialized.TextToSpeechFrame = true

		self:SecureHookScript(_G.TextToSpeechFrame, "OnShow", function(this)
			self:skinObject("dropdown", {obj=_G.TextToSpeechFrameTtsVoiceDropdown, fType=ftype})
			self:removeNineSlice(self:getChild(_G.TextToSpeechFrameTtsVoicePicker, 1).NineSlice)
			self:skinObject("scrollbar", {obj=_G.TextToSpeechFrameTtsVoicePicker.ScrollBar, fType=ftype, rpTex="background"})
			self:skinObject("dropdown", {obj=_G.TextToSpeechFrameTtsVoiceAlternateDropdown, fType=ftype})
			self:SecureHook("TextToSpeechFrame_UpdateAlternate", function()
				self:checkDisabledDD(_G.TextToSpeechFrameTtsVoiceAlternateDropdown)
			end)
			self:removeNineSlice(self:getChild(_G.TextToSpeechFrameTtsVoiceAlternatePicker, 1).NineSlice)
			self:skinObject("scrollbar", {obj=_G.TextToSpeechFrameTtsVoiceAlternatePicker.ScrollBar, fType=ftype, rpTex="background"})
			self:skinObject("slider", {obj=_G.TextToSpeechFrameAdjustRateSlider, fType=ftype})
			self:skinObject("slider", {obj=_G.TextToSpeechFrameAdjustVolumeSlider, fType=ftype})
			if self.modBtns then
				self:skinStdButton{obj=_G.TextToSpeechFramePlaySampleButton, fType=ftype}
				self:skinStdButton{obj=_G.TextToSpeechFramePlaySampleAlternateButton, fType=ftype}
				self:SecureHook(_G.TextToSpeechFramePlaySampleAlternateButton, "SetEnabled", function(bObj)
					self:clrBtnBdr(bObj)
				end)
			end
			if self.modChkBtns then
				self:skinCheckButton{obj=_G.TextToSpeechFramePanelContainer.PlaySoundSeparatingChatLinesCheckButton, fType=ftype}
				self:skinCheckButton{obj=_G.TextToSpeechFramePanelContainer.AddCharacterNameToSpeechCheckButton, fType=ftype}
				self:skinCheckButton{obj=_G.TextToSpeechFramePanelContainer.NarrateMyMessagesCheckButton, fType=ftype}
				self:skinCheckButton{obj=_G.TextToSpeechFramePanelContainer.PlayActivitySoundWhenNotFocusedCheckButton, fType=ftype}
				self:skinCheckButton{obj=_G.TextToSpeechFramePanelContainer.UseAlternateVoiceForSystemMessagesCheckButton, fType=ftype}
			end

			self:Unhook(this, "OnShow")
		end)

	end
end

aObj.blizzFrames[ftype].TimeManager = function(self)
	if not self.prdb.TimeManager or self.initialized.TimeManager then return end
	self.initialized.TimeManager = true

	-- Time Manager Frame
	self:SecureHookScript(_G.TimeManagerFrame, "OnShow", function(this)
		_G.TimeManagerFrameTicker:Hide()
		self:keepFontStrings(_G.TimeManagerStopwatchFrame)
		self:skinObject("dropdown", {obj=_G.TimeManagerAlarmHourDropDown, fType=ftype, x2=-6})
		self:skinObject("dropdown", {obj=_G.TimeManagerAlarmMinuteDropDown, fType=ftype, x2=-6})
		self:skinObject("dropdown", {obj=_G.TimeManagerAlarmAMPMDropDown, fType=ftype, x2=-6})
		self:skinObject("editbox", {obj=_G.TimeManagerAlarmMessageEditBox, fType=ftype})
		self:removeRegions(_G.TimeManagerAlarmEnabledButton, {6, 7})
		self:skinObject("frame", {obj=this, fType=ftype, kfs=true, ri=true, rns=true, cb=true, x2=self.isClsc and 1 or 3})
		if self.modBtnBs then
			self:addButtonBorder{obj=_G.TimeManagerStopwatchCheck, y1=2, y2=-4}
		end
		if self.modChkBtns then
			self:skinCheckButton{obj=_G.TimeManagerAlarmEnabledButton, fType=ftype}
			self:skinCheckButton{obj=_G.TimeManagerMilitaryTimeCheck, fType=ftype}
			self:skinCheckButton{obj=_G.TimeManagerLocalTimeCheck, fType=ftype}
		end
		-- Stopwatch Frame
		self:keepFontStrings(_G.StopwatchTabFrame)
		self:skinObject("frame", {obj=_G.StopwatchFrame, fType=ftype, kfs=true, y1=-16, x2=-1, y2=2})
		if self.modBtns then
			self:skinCloseButton{obj=_G.StopwatchCloseButton, fType=ftype, noSkin=true}
		end
		if self.modBtnBs then
			self:addButtonBorder{obj=_G.StopwatchPlayPauseButton, ofs=-1, x1=0, clr="gold"}
			self:addButtonBorder{obj=_G.StopwatchResetButton, ofs=-1, x1=0, clr="gold"}
		end

		self:Unhook(this, "OnShow")
	end)

end

aObj.blizzFrames[ftype].Tooltips = function(self)
	if not self.prdb.Tooltips.skin or self.initialized.Tooltips then return end
	self.initialized.Tooltips = true

	if _G.IsAddOnLoaded("TinyTooltip")
	and not self.prdb.DisabledSkins["TinyTooltip"]
	then
		_G.setmetatable(self.ttList, {__newindex = function(_, _, tTip)
			tTip = _G.type(tTip) == "string" and _G[tTip] or tTip
			self:SendMessage("Tooltip_Setup", tTip, "init")
		end})
		return
	end

	-- using a metatable to manage tooltips when they are added in different functions
	_G.setmetatable(self.ttList, {__newindex = function(tab, _, tTip)
		-- get object reference for tooltip, handle either strings or objects being passed
		tTip = _G.type(tTip) == "string" and _G[tTip] or tTip
		-- store using tooltip object as the key
		_G.rawset(tab, tTip, true)
		-- skin here so tooltip initially skinned
		self:skinObject("tooltip", {obj=tTip, ftype=tTip.ftype})
		-- hook this to prevent Gradient overlay when tooltip reshown
		self:HookScript(tTip, "OnUpdate", function(this)
			self:applyTooltipGradient(this.sf)
		end)
		-- hook Show function for tooltips which don't get Updated
		if self.ttHook[tTip] then
			self:SecureHookScript(tTip, "OnShow", function(this)
				self:applyTooltipGradient(this.sf)
			end)
		end
		-- if it has an ItemTooltip then add a button border
		if tTip.ItemTooltip
		and self.modBtnBs
		then
			self:addButtonBorder{obj=tTip.ItemTooltip, relTo=tTip.ItemTooltip.Icon, reParent={tTip.ItemTooltip.Count}}
		end
		-- glaze the Status bar(s) if required
		if self.prdb.Tooltips.glazesb then
			if tTip.GetName -- named tooltips only
			and tTip:GetName()
			then
				local ttSB = _G[tTip:GetName() .. "StatusBar"]
				if ttSB
				and not ttSB.Bar then -- ignore ReputationParagonTooltip
					self:skinObject("statusbar", {obj=ttSB, fi=0})
				end
			end
			if tTip.statusBar2 then
				self:skinObject("statusbar", {obj=tTip.statusBar2, fi=0})
			end
		end
	end})

	-- add tooltips to table
	local function addTooltip(tTip)
		tTip:DisableDrawLayer("OVERLAY")
		tTip.ftype = ftype
		aObj:add2Table(aObj.ttList, tTip)
	end
	for _, tTip in _G.pairs{_G.GameTooltip, _G.EmbeddedItemTooltip, _G.GameNoHeaderTooltip, _G.GameSmallHeaderTooltip,  _G.ItemRefTooltip, _G.SmallTextTooltip} do
		addTooltip(tTip)
		if tTip.shoppingTooltips then
			for _, tip in _G.pairs(tTip.shoppingTooltips) do
				if not _G.rawget(self.ttList, tip) then
					addTooltip(tip)
				end
			end
		end
	end

	self:SecureHookScript(_G.ItemRefTooltip, "OnShow", function(this)
		-- ensure it gets updated
		self.ttHook[_G.ItemRefTooltip] = true
		if self.modBtns then
			self:skinCloseButton{obj=self.isClsc and _G.ItemRefCloseButton or this.CloseButton, noSkin=true}
		end

		self:Unhook(this, "OnShow")
	end)

	if self.prdb.Tooltips.glazesb then
		self:SecureHook("GameTooltip_AddStatusBar", function(this, _)
			for statusBar in this.statusBarPool:EnumerateActive() do
				self:skinObject("statusbar", {obj=statusBar, regions={2}, fi=0})
			end
		end)
		self:SecureHook("GameTooltip_AddProgressBar", function(this, _)
			for progressBar in this.progressBarPool:EnumerateActive() do
				self:skinObject("statusbar", {obj=progressBar.Bar, regions={1, 2, 3, 4, 5}, fi=0, bg=self:getRegion(progressBar.Bar, 7)})
			end
		end)
	end

	-- AceConfigDialog tooltip
	addTooltip(self.ACD.tooltip)

	-- SexyMapZoneTextTooltip
	if not self.isClsc then
		if _G.IsAddOnLoaded("SexyMap") then
			self:add2Table(self.ttList, "SexyMapZoneTextTooltip")
		end
	end

end

aObj.blizzFrames[ftype].UIDropDownMenu = function(self)
	if not self.prdb.UIDropDownMenu or self.initialized.UIDropDownMenu then return end
	self.initialized.UIDropDownMenu = true

	local function skinDDList(frame)
		local fName = frame:GetName()
		if self.isRtl then
			self:keepFontStrings(frame.Border)
		end
		if self.isClsc
		or _G.IsAddOnLoaded("TipTac")
		then
			aObj:removeBackdrop(_G[fName .. "Backdrop"])
		end
		aObj:removeBackdrop(_G[fName .. "MenuBackdrop"])
		aObj:removeNineSlice(_G[fName .. "MenuBackdrop"].NineSlice)
		aObj:skinObject("frame", {obj=frame, fType=ftype, kfs=true, ofs=-4})
	end

	for i = 1, _G.UIDROPDOWNMENU_MAXLEVELS do
		self:SecureHookScript(_G["DropDownList" .. i], "OnShow", function(this)
			skinDDList(this)

			self:Unhook(this, "OnShow")
		end)
	end

	self:SecureHook("UIDropDownMenu_CreateFrames", function(_)
		if not _G["DropDownList" .. _G.UIDROPDOWNMENU_MAXLEVELS].sf then
			skinDDList(_G["DropDownList" .. _G.UIDROPDOWNMENU_MAXLEVELS])
		end
	end)

end

aObj.blizzFrames[ftype].UIWidgets = function(self)
	if not self.prdb.UIWidgets or self.initialized.UIWidgets then return end
	self.initialized.UIWidgets = true

	local function setTextColor(textObject)
		self:rawHook(textObject, "SetTextColor", function(this, r, g, b, a)
			local tcr, tcg, tcb = aObj:round2(r, 2), aObj:round2(g, 2), aObj:round2(b, 2)
			if (tcr == 0.41 or tcr == 0.28 and tcg == 0.02 and tcb == 0.02) -- Red
			or (tcr == 0.08 and tcg == 0.17 or tcg == 0.16 and tcb == 0.37) -- Blue
			-- or (tcr == 0.19 and tcg == 0.05 and tcb == 0.01) -- WarboardUI
			then
				self.hooks[this].SetTextColor(this, aObj.BT:GetRGBA())
			else
				self.hooks[this].SetTextColor(this, r, g, b, a)
			end
			return tcr
		end, true)
		return textObject:SetTextColor(textObject:GetTextColor())
	end
	-- Documentation in UIWidgetManagerSharedDocumentation.lua (UIWidgetVisualizationType)
	local function skinWidget(wFrame, wInfo)
		-- handle in combat
		if _G.InCombatLockdown() then
		    aObj:add2Table(aObj.oocTab, {skinWidget, {wFrame, wInfo}})
		    return
		end
		-- aObj:Debug("skinWidget: [%s, %s, %s, %s, %s, %s, %s]", wFrame, wFrame:GetDebugName(), wFrame.widgetType, wFrame.widgetTag, wFrame.widgetSetID, wFrame.widgetID, wInfo)

		-- luacheck: ignore 542 ((W542) empty if branch)
		if wFrame.widgetType == 0 then -- IconAndText (World State: ICONS at TOP)
			-- N.B. DON'T add buttonborder to Icon(s)
		elseif wFrame.widgetType == 1 then -- CaptureBar (World State: Capture bar on RHS)
			-- DON'T change textures as it doesn't really improve it
		elseif wFrame.widgetType == 2 then -- StatusBar
			local regs
			-- background & border textures
			if aObj.isRtl then
				regs = {2, 3, 4, 8, 9, 10}
			else
				regs = {1, 2, 3, 5, 6 ,7}
			end
			aObj:skinObject("statusbar", {obj=wFrame.Bar, regions=regs, fi=0, nilFuncs=true})
			if aObj:getChild(wFrame.Bar, 1) then
				aObj:removeRegions(aObj:getChild(wFrame.Bar, 1), {1})
			end
		elseif wFrame.widgetType == 3 then -- DoubleStatusBar (Island Expeditions)
			aObj:skinObject("statusbar", {obj=wFrame.LeftBar, regions={2, 3, 4}, fi=0, bg=wFrame.LeftBar.BG, nilFuncs=true})
			aObj:skinObject("statusbar", {obj=wFrame.RightBar, regions={2, 3, 4}, fi=0, bg=wFrame.RightBar.BG, nilFuncs=true})
		elseif wFrame.widgetType == 4 then -- IconTextAndBackground (Island Expedition Totals)
		elseif wFrame.widgetType == 5 then -- DoubleIconAndText
			if aObj.modBtnBs then
				aObj:addButtonBorder{obj=wFrame.Left, relTo=wFrame.Left.Icon}
				aObj:addButtonBorder{obj=wFrame.Right, relTo=wFrame.Right.Icon}
			end
		elseif wFrame.widgetType == 6 then -- StackedResourceTracker
			for resourceFrame in wFrame.resourcePool:EnumerateActive() do
				resourceFrame:SetFontColor(self.BT)
			end
		elseif wFrame.widgetType == 7 then -- IconTextAndCurrencies
			if aObj.modBtnBs then
				aObj:addButtonBorder{obj=wFrame, relTo=wFrame.Icon}
				if wInfo.visInfoDataFunction(wFrame.widgetID) then
					self:clrBtnBdr(wFrame, "grey")
				else
					self:clrBtnBdr(wFrame)
				end
			end
		elseif wFrame.widgetType == 8 then -- TextWithState
			setTextColor(wFrame.Text)
		elseif wFrame.widgetType == 9 then -- HorizontalCurrencies
			for currencyFrame in wFrame.currencyPool:EnumerateActive() do
				setTextColor(currencyFrame.Text)
				setTextColor(currencyFrame.LeadingText)
			end
		elseif wFrame.widgetType == 10 then -- BulletTextList
			for lineFrame in wFrame.linePool:EnumerateActive() do
				setTextColor(lineFrame.Text)
			end
		elseif wFrame.widgetType == 11 then -- ScenarioHeaderCurrenciesAndBackground
			aObj:nilTexture(wFrame.Frame, true)
		elseif wFrame.widgetType == 12 then -- TextureAndText
			-- .Background
			-- .Foreground
			setTextColor(wFrame.Text)
		-- N.B. Classic ONLY has 12 UIWidgets
		elseif wFrame.widgetType == 13 then -- SpellDisplay
			wFrame.Spell.Border:SetTexture(nil)
			local tcr = setTextColor(wFrame.Spell.Text)
			if aObj.modBtnBs then
				aObj:addButtonBorder{obj=wFrame.Spell, relTo=wFrame.Spell.Icon, reParent={wFrame.Spell.StackCount}}
				if tcr == 0.5 then
					aObj:clrBtnBdr(wFrame.Spell, "grey")
				end
			end
		elseif wFrame.widgetType == 14 then -- DoubleStateIconRow
			-- TODO: add button borders if required
		elseif wFrame.widgetType == 15 then -- TextureAndTextRow
			for entryFrame in wFrame.entryPool:EnumerateActive() do
				-- .Background
				-- .Foreground
				setTextColor(entryFrame.Text)
			end
		elseif wFrame.widgetType == 16 then -- ZoneControl
		elseif wFrame.widgetType == 17 then -- CaptureZone
		elseif wFrame.widgetType == 18 then -- TextureWithAnimation
		elseif wFrame.widgetType == 19 then -- DiscreteProgressSteps
		elseif wFrame.widgetType == 20 then -- ScenarioHeaderTimer
			aObj:nilTexture(wFrame.Frame, true)
			aObj:skinObject("statusbar", {obj=wFrame.TimerBar, fi=0, bg=wFrame.TimerBar.BG})
			-- FIXME: uses partitionPool ??
		elseif wFrame.widgetType == 21 then -- TextColumnRow
		elseif wFrame.widgetType == 22 then -- Spacer
		elseif wFrame.widgetType == 23 then -- UnitPowerBar
		end
	end

	if self.isRtl then
		local function hookAndSkinWidgets(widgetContainer)
			-- aObj:Debug("hookAndSkinWidgets: [%s, %s, %s]", widgetContainer:IsForbidden(), widgetContainer:IsForbidden() or widgetContainer:GetDebugName())
			-- DON'T skin NamePlate[n].* widgets as they cause Clamping Errors
			if widgetContainer:IsForbidden()
			or widgetContainer:GetDebugName():find("^NamePlate%d+%.")
			then
				return
			end
			aObj:SecureHook(widgetContainer, "UpdateWidgetLayout", function(this)
				for widget in this.widgetPools:EnumerateActive() do
					skinWidget(widget, _G.UIWidgetManager:GetWidgetTypeInfo(widget.widgetType))
				end
			end)
			-- skin existing widgets
			for widget in widgetContainer.widgetPools:EnumerateActive() do
				skinWidget(widget, _G.UIWidgetManager:GetWidgetTypeInfo(widget.widgetType))
			end
		end
		-- hook this to skin new widgets
		self:SecureHook(_G.UIWidgetManager, "OnWidgetContainerRegistered", function(_, widgetContainer)
			hookAndSkinWidgets(widgetContainer)
		end)
		self:SecureHook(_G.UIWidgetManager, "OnWidgetContainerUnregistered", function(_, widgetContainer)
			self:Unhook(widgetContainer, "UpdateWidgetLayout")
		end)
		-- handle existing WidgetContainers
		for widgetContainer, _ in _G.pairs(_G.UIWidgetManager.registeredWidgetContainers) do
			hookAndSkinWidgets(widgetContainer)
		end
	else
		self:SecureHook(_G.UIWidgetManager, "CreateWidget", function(this, widgetID, _, widgetType)
			skinWidget(this.widgetIdToFrame[widgetID], this.widgetVisTypeInfo[widgetType].visInfoDataFunction(widgetID))
		end)
	end

end

aObj.blizzFrames[ftype].UnitPopup = function(self)
	if not self.prdb.UnitPopup or self.initialized.UnitPopup then return end
	self.initialized.UnitPopup = true

	self:skinSlider{obj=_G.UnitPopupVoiceSpeakerVolume.Slider}
	self:skinSlider{obj=_G.UnitPopupVoiceMicrophoneVolume.Slider}
	self:skinSlider{obj=_G.UnitPopupVoiceUserVolume.Slider}

end
