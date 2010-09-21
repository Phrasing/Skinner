local _G = _G
local ftype = "c"

function Skinner:FriendsFrame()
	if not self.db.profile.FriendsFrame or self.initialized.FriendsFrame then return end
	self.initialized.FriendsFrame = true

	self:add2Table(self.charKeys1, "FriendsFrame")

	-- hook this to manage textured tabs
	if self.isTT then
		self:SecureHook("FriendsFrame_ShowSubFrame", function(frameName)
			for i, v in pairs(FRIENDSFRAME_SUBFRAMES) do
				-- handle Friends and Ignore on the same Tab
				local j = ( i > 1 and i - 1 or i)
				-- handle Friends, Ignore and Pending on the same Tab
				j = ( j > 1 and j - 1 or j)
				-- handle additional Tabs with altered names or numbers
				local prefix = (v == "BadapplesFrame" and "Badapples" or "")
				local tabId = (v == "BadapplesFrame" and 6 or j)
				if v == "BlackListFrame" then tabId = 1 end -- handle the BlackListFrame
				local tabSF = self.skinFrame[_G[prefix.."FriendsFrameTab"..tabId]]
				-- ignore the IgnoreListFrame (also the PendingListFrame) (and the BlackListFrame)
 				if v ~= "IgnoreListFrame" and v ~= "PendingListFrame" and v ~= "BlackListFrame" then
					self:setInactiveTab(tabSF)
				end
				if v == frameName then
					self:setActiveTab(tabSF)
				end
			end
		end)
	end
-->>--	FriendsList Frame
	self:skinDropDown{obj=FriendsFrameStatusDropDown}
	FriendsFrameStatusDropDownStatus:SetAlpha(1) -- display status icon
	self:adjWidth{obj=_G["FriendsFrameStatusDropDownMiddle"], adj=4}
	-- Add a skin frame to include the icon at the front
	self:skinEditBox{obj=FriendsFrameBroadcastInput, regs={9, 10}, noSkin=true} -- region 10 is icon
	self:addSkinFrame{obj=FriendsFrameBroadcastInput, nb=true, aso={bd=self.Backdrop[3], ng=true, ebc=true}, x1=-24}
	self:skinFFToggleTabs("FriendsTabHeaderTab")
	self:moveObject{obj=FriendsTabHeaderTab1, y=-4}
	self:skinSlider{obj=FriendsFrameFriendsScrollFrameScrollBar, size=4}
	for i = 1, FRIENDS_FRIENDS_TO_DISPLAY do
		_G["FriendsFrameFriendsScrollFrameButton"..i].background:SetAlpha(0)
	end
	self:moveObject{obj=FriendsFrameAddFriendButton, x=3}
	-- Add Friend Frame
	self:addSkinFrame{obj=AddFriendFrame, kfs=true}
	self:skinEditBox{obj=AddFriendNameEditBox, regs={9}}
	self:addSkinFrame{obj=AddFriendNoteFrame, kfs=true}
	self:skinScrollBar{obj=AddFriendNoteFrameScrollFrame}
	self:addSkinFrame{obj=FriendsFrame, ft=ftype, kfs=true, bgen=2, x1=12, y1=-11, x2=-33, y2=71}
	-- Friends Tooltip
	self:addSkinFrame{obj=FriendsTooltip}
	-- FriendsFriends frame
	self:skinDropDown{obj=FriendsFriendsFrameDropDown}
	self:addSkinFrame{obj=FriendsFriendsList, ft=ftype}
	self:skinScrollBar{obj=FriendsFriendsScrollFrame}
	self:addSkinFrame{obj=FriendsFriendsNoteFrame, kfs=true, ft=ftype}
	self:addSkinFrame{obj=FriendsFriendsFrame, ft=ftype}

-->>--	IgnoreList Frame
	self:keepFontStrings(IgnoreListFrame)
	self:skinScrollBar{obj=FriendsFrameIgnoreScrollFrame}

-->>--	PendingList Frame
	self:keepFontStrings(PendingListFrame)
	self:skinDropDown{obj=PendingListFrameDropDown}
	self:skinScrollBar{obj=FriendsFramePendingScrollFrame}
	for i = 1, PENDING_INVITES_TO_DISPLAY do
		local ffpBtn = "FriendsFramePendingButton"..i
		self:applySkin{obj=_G[ffpBtn]}
		self:applySkin{obj=_G[ffpBtn.."AcceptButton"]}
		self:applySkin{obj=_G[ffpBtn.."DeclineButton"]}
	end

-->>--	Who Frame
	self:skinFFColHeads("WhoFrameColumnHeader")
	self:skinDropDown{obj=WhoFrameDropDown, noSkin=true}
	self:moveObject{obj=WhoFrameDropDownButton, x=5, y=1}
	self:skinScrollBar{obj=WhoListScrollFrame}
	self:skinEditBox{obj=WhoFrameEditBox, move=true}
	WhoFrameEditBox:SetWidth(WhoFrameEditBox:GetWidth() +  24)
	self:moveObject{obj=WhoFrameEditBox, x=12}

-->>--	Guild Frame
	if not self.isBeta then
	   self:keepFontStrings(GuildFrameLFGFrame)
	   self:skinFFColHeads("GuildFrameColumnHeader")
	   self:skinFFColHeads("GuildFrameGuildStatusColumnHeader")
	   self:skinScrollBar{obj=GuildListScrollFrame}
    	-- Guild Control Popup Frame
    	self:skinDropDown{obj=GuildControlPopupFrameDropDown}
    	self:skinButton{obj=GuildControlPopupFrameAddRankButton, mp2=true, plus=true}
    	self:skinButton{obj=GuildControlPopupFrameRemoveRankButton, mp2=true}
    	self:skinEditBox{obj=GuildControlWithdrawGoldEditBox, regs={9}}
    	self:skinEditBox{obj=GuildControlPopupFrameEditBox, regs={9}}
    	self:skinEditBox{obj=GuildControlWithdrawItemsEditBox, regs={9}}
    	self:addSkinFrame{obj=GuildControlPopupFrameTabPermissions, ft=ftype}
    	self:addSkinFrame{obj=GuildControlPopupFrame, ft=ftype, kfs=true, x1=3, y1=-6, x2=-28, y2=25}
    	for i = 1, MAX_GUILDBANK_TABS do
    		local gbtpt = _G["GuildBankTabPermissionsTab"..i]
    		self:addSkinFrame{obj=gbtpt, ft=ftype, kfs=true, y1=-8}
    	end
    -->>--	GuildInfo Frame
    	self:skinScrollBar{obj=GuildInfoFrameScrollFrame}
    	self:addSkinFrame{obj=GuildInfoTextBackground, ft=ftype}
    	self:addSkinFrame{obj=GuildInfoFrame, ft=ftype, kfs=true, x1=2, y1=-6, x2=-6}
    -->>--	GuildMemberDetail Frame
    	self:addSkinFrame{obj=GuildMemberNoteBackground, ft=ftype}
    	self:addSkinFrame{obj=GuildMemberOfficerNoteBackground, ft=ftype}
    	self:moveObject{obj=GuildMemberRemoveButton, x=-2}
    	self:addSkinFrame{obj=GuildMemberDetailFrame, ft=ftype, kfs=true, x1=2, y1=-6, x2=-6}
    -->>--	GuildEventLog Frame
    	self:addSkinFrame{obj=GuildEventFrame, ft=ftype}
    	self:skinScrollBar{obj=GuildEventLogScrollFrame}
    	self:addSkinFrame{obj=GuildEventLogFrame, ft=ftype, kfs=true, x1=2, y1=-6, x2=-6}
	end

-->>--	Channel Frame
	self:keepFontStrings(ChannelFrame)
	self:skinButton{obj=ChannelFrameNewButton}
	-- hook this to skin channel buttons
	self:SecureHook("ChannelList_Update", function()
		for i = 1, MAX_CHANNEL_BUTTONS do
			local cbnt = _G["ChannelButton"..i.."NormalTexture"]
			cbnt:SetAlpha(0)
		end
	end)
	ChannelFrameVerticalBar:Hide()
	self:skinScrollBar{obj=ChannelListScrollFrame}
	self:skinScrollBar{obj=ChannelRosterScrollFrame}
	-- Channel Pullout Tab & Frame
	self:keepRegions(ChannelPulloutTab, {4, 5}) -- N.B. region 4 is text, 5 is highlight
	self:addSkinFrame{obj=ChannelPulloutTab, ft=ftype}
	self:addSkinFrame{obj=ChannelPullout, ft=ftype}
-->>--	Daughter Frame
	self:skinEditBox{obj=ChannelFrameDaughterFrameChannelName, regs={9}, noWidth=true}
	self:skinEditBox{obj=ChannelFrameDaughterFrameChannelPassword, regs={9, 10}, noWidth=true}
	self:moveObject{obj=ChannelFrameDaughterFrameOkayButton, x=-2}
	self:addSkinFrame{obj=ChannelFrameDaughterFrame, ft=ftype, kfs=true, x1=2, y1=-6, x2=-5}
	self:skinDropDown{obj=ChannelListDropDown}
	self:skinDropDown{obj=ChannelRosterDropDown}

-->>--	Raid Frame
	self:moveObject{obj=RaidFrameConvertToRaidButton, x=-50}
	self:moveObject{obj=RaidFrameRaidInfoButton, x=50}

	if IsAddOnLoaded("Blizzard_RaidUI") then self:RaidUI() end

-->>--	RaidInfo Frame
	self:addSkinFrame{obj=RaidInfoInstanceLabel, kfs=true}
	self:addSkinFrame{obj=RaidInfoIDLabel, kfs=true}
	self:skinSlider{obj=RaidInfoScrollFrameScrollBar}
	self:addSkinFrame{obj=RaidInfoFrame, ft=ftype, kfs=true, hdr=true}

-->>--	Frame Tabs
	for i = 1, FriendsFrame.numTabs do
		local tabName = _G["FriendsFrameTab"..i]
		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is the Text, 8 is the highlight
		local tabSF = self:addSkinFrame{obj=tabName, ft=ftype, noBdr=self.isTT, x1=6, x2=-6, y2=2}
		if i == 1 then
			if self.isTT then self:setActiveTab(tabSF) end
		else
			if self.isTT then self:setInactiveTab(tabSF) end
		end
	end

end

function Skinner:TradeSkillUI() -- LoD
	if not self.db.profile.TradeSkillUI or self.initialized.TradeSkillUI then return end
	self.initialized.TradeSkillUI = true

	if self.modBtns then
		-- hook to manage changes to button textures
		self:SecureHook("TradeSkillFrame_Update", function()
			for i = 1, TRADE_SKILLS_DISPLAYED do
				self:checkTex(_G["TradeSkillSkill"..i])
			end
			self:checkTex(TradeSkillCollapseAllButton)
		end)
	end

	local bar = "TradeSkillRankFrame"
	_G[bar.."Border"]:SetAlpha(0)
	self:glazeStatusBar(_G[bar], 0, _G[bar.."Background"])
	self:moveObject{obj=_G[bar], x=-2}
	if not self.isBeta then
		self:skinEditBox{obj=TradeSkillFrameEditBox, regs={9}, x=1}
		self:moveObject{obj=TradeSkillFrameEditBox, x=-1}
	else
		-- Add a skin frame to include the icon at the front
		self:skinEditBox{obj=TradeSkillFrameSearchBox, regs={9}, noSkin=true} -- region 9 is icon
		self:addSkinFrame{obj=TradeSkillFrameSearchBox, nb=true, aso={bd=self.Backdrop[3], ng=true, ebc=true}, x1=-6}
		self:skinButton{obj=TradeSkillFilterButton}
	end
	self:removeRegions(TradeSkillExpandButtonFrame)
	self:skinButton{obj=TradeSkillCollapseAllButton, mp=true}
	if not self.isBeta then
		self:skinDropDown{obj=TradeSkillSubClassDropDown}
		self:skinDropDown{obj=TradeSkillInvSlotDropDown}
	end
	for i = 1, TRADE_SKILLS_DISPLAYED do
		self:skinButton{obj=_G["TradeSkillSkill"..i], mp=true}
	end
	self:skinScrollBar{obj=TradeSkillListScrollFrame}
	self:skinScrollBar{obj=TradeSkillDetailScrollFrame}
	self:keepFontStrings(TradeSkillDetailScrollChildFrame)
	self:skinEditBox{obj=TradeSkillInputBox, noHeight=true, x=-5}
	if not self.isBeta then
		self:addSkinFrame{obj=TradeSkillFrame, ft=ftype, kfs=true, x1=10, y1=-11, x2=-32, y2=71}
	else
		self:addSkinFrame{obj=TradeSkillFrame, ft=ftype, kfs=true, ri=true, x1=0, y1=2, x2=1, y2=-4}
		self:addSkinFrame{obj=TradeSkillGuildFrameContainer, ft=ftype}
		self:addSkinFrame{obj=TradeSkillGuildFrame, ft=ftype, kfs=true, x1=7, y1=-7, x2=-7, y2=7}
	end

	for i = 1, MAX_TRADE_SKILL_REAGENTS do
		_G["TradeSkillReagent"..i.."NameFrame"]:SetTexture(nil)
	end

	if self.modBtns then TradeSkillFrame_Update() end -- force update for button textures

end

function Skinner:TradeFrame()
	if not self.db.profile.TradeFrame or self.initialized.TradeFrame then return end
	self.initialized.TradeFrame = true

	self:add2Table(self.charKeys1, "TradeFrame")

	for i = 1, MAX_TRADE_ITEMS do
		_G["TradeRecipientItem"..i.."SlotTexture"]:SetTexture(self.esTex)
		_G["TradeRecipientItem"..i.."NameFrame"]:SetTexture(nil)
		_G["TradePlayerItem"..i.."SlotTexture"]:SetTexture(self.esTex)
		_G["TradePlayerItem"..i.."NameFrame"]:SetTexture(nil)
	end
	self:skinMoneyFrame{obj=TradePlayerInputMoneyFrame}
	self:addSkinFrame{obj=TradeFrame, ft=ftype, kfs=true, x1=10, y1=-11, x2=-28, y2=48}

end

function Skinner:QuestLog()
	if not self.db.profile.QuestLog or self.initialized.QuestLog then return end
	self.initialized.QuestLog = true

	self:add2Table(self.charKeys1, "QuestLog")

	self:keepFontStrings(QuestLogCount)
	self:keepFontStrings(EmptyQuestLogFrame)

	if self.modBtns then
		local function qlUpd()

			for i = 1, #QuestLogScrollFrame.buttons do
				Skinner:checkTex(QuestLogScrollFrame.buttons[i])
			end

		end
		-- hook to manage changes to button textures
		self:SecureHook("QuestLog_Update", function()
			qlUpd()
		end)
		-- hook this as well as it's a copy of QuestLog_Update
		self:SecureHook(QuestLogScrollFrame, "update", function()
			qlUpd()
		end)
	end
	-- skin minus/plus buttons
	for i = 1, #QuestLogScrollFrame.buttons do
		self:skinButton{obj=QuestLogScrollFrame.buttons[i], mp=true}
	end
	self:skinScrollBar{obj=QuestLogScrollFrame}
	self:skinAllButtons{obj=QuestLogControlPanel} -- Abandon/Push/Track
	self:addSkinFrame{obj=QuestLogFrame, ft=ftype, kfs=true, x1=10, y1=-11, x2=-1, y2=8}

-->>-- QuestLogDetail Frame
	QuestLogDetailTitleText:SetTextColor(self.HTr, self.HTg, self.HTb)
	self:skinScrollBar{obj=QuestLogDetailScrollFrame}
	self:addSkinFrame{obj=QuestLogDetailFrame, ft=ftype, kfs=true, x1=10, y1=-11, x2=1}

	self:QuestInfo()

end

function Skinner:RaidUI() -- LoD
	if not self.db.profile.RaidUI or self.initialized.RaidUI then return end
	self.initialized.RaidUI = true

	local function skinPulloutFrames()

		for i = 1, NUM_RAID_PULLOUT_FRAMES 	do
			local rp = _G["RaidPullout"..i]
			if not self.skinFrame[rp] then
				self:skinDropDown{obj=_G["RaidPullout"..i.."DropDown"]}
				_G["RaidPullout"..i.."MenuBackdrop"]:SetBackdrop(nil)
				self:addSkinFrame{obj=rp, ft=ftype, kfs=true, x1=3, y1=-1, x2=-1, y2=1}
			end
		end

	end
	-- hook this to skin the pullout group frames
	self:SecureHook("RaidPullout_GetFrame", function(...)
		skinPulloutFrames()
	end)
	-- hook this to skin the pullout character frames
	self:SecureHook("RaidPullout_Update", function(pullOutFrame)
		local pfName = pullOutFrame:GetName()
--		self:Debug("RP_U: [%s, %s]", pullOutFrame, pfName)
		for i = 1, pullOutFrame.numPulloutButtons do
			local pfBName = pfName.."Button"..i
			local pfBObj = _G[pfBName]
			if not self.skinFrame[pfBObj] then
				for _, v in pairs{"HealthBar", "ManaBar", "Target", "TargetTarget"} do
					local sBar = pfBName..v
					self:removeRegions(_G[sBar], {2})
					self:glazeStatusBar(_G[sBar], 0, _G[sBar.."Background"])
				end
				self:addSkinFrame{obj=_G[pfBName.."TargetTargetFrame"], ft=ftype, x1=4, x2=-4, y2=2}
				self:addSkinFrame{obj=pfBObj, ft=ftype, kfs=true, x1=-4, y1=-6, x2=4, y2=-6}
			end
		end
	end)

	self:moveObject{obj=RaidFrameRaidBrowserButton, x=-30}
	self:skinButton{obj=RaidFrameRaidBrowserButton}
	self:skinButton{obj=RaidFrameReadyCheckButton}
	self:moveObject{obj=RaidGroup1,x= 2}

	-- Raid Groups
	for i = 1, MAX_RAID_GROUPS do
		local rGrp = _G["RaidGroup"..i]
		self:addSkinFrame{obj=rGrp, ft=ftype, kfs=true}
	end
	-- Raid Group Buttons
	for i = 1, MAX_RAID_GROUPS * 5 do
		local rgBtn = _G["RaidGroupButton"..i]
		self:removeRegions(rgBtn, {4})
		self:addSkinFrame{obj=rgBtn, ft=ftype, aso={bd=self.Backdrop[5]}, y1=1, y2=-3}
	end
	-- Raid Class Tabs (side)
	for i = 1, MAX_RAID_CLASS_BUTTONS do
		local tabName = _G["RaidClassButton"..i]
		self:removeRegions(tabName, {1}) -- N.B. region 2 is the icon, 3 is the text
	end

	-- skin existing frames
	skinPulloutFrames()

end

function Skinner:ReadyCheck()
	if not self.db.profile.ReadyCheck or self.initialized.ReadyCheck then return end
	self.initialized.ReadyCheck = true

	self:add2Table(self.charKeys1, "ReadyCheck")

	self:addSkinFrame{obj=ReadyCheckListenerFrame, ft=ftype, kfs=true}

end

function Skinner:Buffs()
	if not self.db.profile.Buffs or self.initialized.Buffs then return end
	self.initialized.Buffs = true

	self:add2Table(self.charKeys1, "Buffs")

	local function skinBuffs()

		for i= 1, BUFF_MAX_DISPLAY do
			local bb = _G["BuffButton"..i]
			if bb and not Skinner.sBut[bb] then
				Skinner:addSkinButton{obj=bb, parent=bb}
				Skinner:moveObject{obj=_G["BuffButton"..i.."Duration"], y=-2}
			end
		end
		for i= 1, DEBUFF_MAX_DISPLAY do
			local db = _G["DebuffButton"..i]
			if db and not Skinner.sBut[db] then
				Skinner:addSkinButton{obj=db, x1=-5, y1=5, x2=5 ,y2=-5}
				Skinner:moveObject{obj=_G["DebuffButton"..i.."Duration"], y=-3}
			end
		end

	end

	self:SecureHook("BuffFrame_Update", function()
		skinBuffs()
	end)

	-- skin any current Buffs/Debuffs
	skinBuffs()

	-- skin Main and Off Hand Enchant buttons (Poisons/Oils etc)
	self:addSkinButton{obj=TempEnchant1}
	self:moveObject{obj=_G["TempEnchant1".."Duration"], y=-2}
	self:addSkinButton{obj=TempEnchant2}
	self:moveObject{obj=_G["TempEnchant2".."Duration"], y=-2}

	-- Consolidated Buffs
	self:addSkinFrame{obj=ConsolidatedBuffsTooltip, x1=4, y1=-3, x2=-5, y2=4}

end

function Skinner:VehicleMenuBar()
	if not self.db.profile.VehicleMenuBar or self.initialized.VehicleMenuBar then return end
	self.initialized.VehicleMenuBar = true

	self:add2Table(self.charKeys1, "VehicleMenuBar")

	local xOfs1, xOfs2, yOfs1, yOfs2

	local function skinVehicleMenuBar(opts)

--		Skinner:Debug("sVMB: [%s, %s, %s]", opts.src, opts.sn or "nil", opts.pv or "nil")

		-- expand frame width if mechanical vehicle
		if opts.sn == "Mechanical"
		or VehicleMenuBar.currSkin == "Mechanical"
		then
			xOfs1 = 132
			yOfs1 = 41
			yOfs2 = -1
		else
			-- "Natural" settings
			xOfs1 = 159
			yOfs1 = 46
			yOfs2 = -2
		end
		xOfs2 = xOfs1 * -1

		-- remove all textures
		VehicleMenuBarArtFrame:DisableDrawLayer("BACKGROUND")
		VehicleMenuBarArtFrame:DisableDrawLayer("BORDER")
		VehicleMenuBarArtFrame:DisableDrawLayer("ARTWORK")
		VehicleMenuBarArtFrame:DisableDrawLayer("OVERLAY")
		-- Pitch Slider
		self:moveObject{obj=VehicleMenuBarPitchSlider, y=2}
		VehicleMenuBarPitchSlider:DisableDrawLayer("OVERLAY")
		 -- make it appear above the skin frame
		VehicleMenuBarPitchSlider:SetFrameStrata("MEDIUM")

		local sf = Skinner.skinFrame[VehicleMenuBar]
		if not sf then
			self:addSkinFrame{obj=VehicleMenuBar, ft=ftype, x1=xOfs1, y1=yOfs1, x2=xOfs2, y2=yOfs2}
		else
			sf:ClearAllPoints()
			sf:SetPoint("TOPLEFT", VehicleMenuBar, "TOPLEFT", xOfs1, yOfs1)
			sf:SetPoint("BOTTOMRIGHT", VehicleMenuBar, "BOTTOMRIGHT", xOfs2, yOfs2)
		end

	end

    self:SecureHook(VehicleMenuBar, "Show", function(this, ...)
        skinVehicleMenuBar{src=1}
    end)

    self:SecureHook("VehicleMenuBar_SetSkin", function(skinName, pitchVisible)
        skinVehicleMenuBar{src=2, sn=skinName, pv=pitchVisible}
    end)

	if VehicleMenuBar:IsShown() then skinVehicleMenuBar{src=3} end

end

function Skinner:WatchFrame()
	if not self.db.profile.WatchFrame or self.initialized.WatchFrame then return end
	self.initialized.WatchFrame = true

	self:add2Table(self.charKeys1, "WatchFrame")

	self:addSkinFrame{obj=WatchFrameLines, ft=ftype, x1=-10, y1=4, x2=10}

end

function Skinner:GearManager() -- inc. in PaperDollFrame.xml
	if not self.db.profile.GearManager or self.initialized.GearManager then return end
	self.initialized.GearManager = true

	self:add2Table(self.charKeys1, "GearManager")

	self:addSkinFrame{obj=GearManagerDialog, ft=ftype, kfs=true, x1=4, y1=-2, x2=-1, y2=2}
	for i = 1, MAX_EQUIPMENT_SETS_PER_PLAYER do
		self:getRegion(_G["GearSetButton"..i], 2):SetTexture(self.esTex)
	end
-->>-- Popup frame
	self:skinScrollBar{obj=GearManagerDialogPopupScrollFrame}
	self:skinEditBox{obj=GearManagerDialogPopupEditBox, regs={9}}
	self:addSkinFrame{obj=GearManagerDialogPopup, ft=ftype, kfs=true, x1=4, y1=-2, x2=-1, y2=3}

end

if Skinner.isBeta then

	function Skinner:ArchaeologyUI()
		if not self.db.profile.ArchaeologyUI or self.initialized.ArchaeologyUI then return end
		self.initialized.ArchaeologyUI = true

		self:skinDropDown{obj=ArchaeologyFrame.raceFilterDropDown}
		self:glazeStatusBar(ArchaeologyFrame.rankBar, 0,  ArchaeologyFrameRankBarBackground)
		ArchaeologyFrameRankBarBorder:Hide()
		self:addSkinFrame{obj=ArchaeologyFrame, ft=ftype, kfs=true, ri=true, y1=2, x2=1}
	-->>-- Summary Page
		self:keepFontStrings(ArchaeologyFrame.summaryPage) -- remove title textures
		ArchaeologyFrameSummaryPageTitle:SetTextColor(self.HTr, self.HTg, self.HTb)
		for i = 1, ARCHAEOLOGY_MAX_RACES do
			ArchaeologyFrame.summaryPage["race"..i].raceName:SetTextColor(self.BTr, self.BTg, self.BTb)
		end
	-->>-- Completed Page
		self:keepFontStrings(ArchaeologyFrame.completedPage) -- remove title textures
		ArchaeologyFrame.completedPage.infoText:SetTextColor(self.BTr, self.BTg, self.BTb)
		ArchaeologyFrame.completedPage.titleBig:SetTextColor(self.HTr, self.HTg, self.HTb)
		ArchaeologyFrame.completedPage.titleTop:SetTextColor(self.BTr, self.BTg, self.BTb)
		ArchaeologyFrame.completedPage.titleMid:SetTextColor(self.BTr, self.BTg, self.BTb)
		ArchaeologyFrame.completedPage.pageText:SetTextColor(self.BTr, self.BTg, self.BTb)
		for i = 1, ARCHAEOLOGY_MAX_COMPLETED_SHOWN do
			ArchaeologyFrame.completedPage["artifact"..i].artifactName:SetTextColor(self.HTr, self.HTg, self.HTb)
			ArchaeologyFrame.completedPage["artifact"..i].artifactSubText:SetTextColor(self.BTr, self.BTg, self.BTb)
			ArchaeologyFrame.completedPage["artifact"..i].border:Hide()
			_G["ArchaeologyFrameCompletedPageArtifact"..i.."Bg"]:Hide()
		end
	-->>-- Artifact Page
		self:removeRegions(ArchaeologyFrame.artifactPage, {3, 4}) -- title textures
		ArchaeologyFrame.artifactPage:DisableDrawLayer("BACKGROUND")
		ArchaeologyFrame.artifactPage:DisableDrawLayer("BORDER")
		ArchaeologyFrame.artifactPage.historyTitle:SetTextColor(self.HTr, self.HTg, self.HTb)
		ArchaeologyFrame.artifactPage.historyText:SetTextColor(self.BTr, self.BTg, self.BTb)
		-- Solve Frame
		ArchaeologyFrameArtifactPageSolveFrameStatusBarBarBG:Hide()
		self:glazeStatusBar(ArchaeologyFrame.artifactPage.solveFrame.statusBar, 0,  nil)
		ArchaeologyFrame.artifactPage.solveFrame.statusBar:SetStatusBarColor(0.75, 0.45, 0, 0.7)

	end

	function Skinner:GuildUI()

		-- Guild Panel
		GuildFrameBottomInset:DisableDrawLayer("BACKGROUND")
		GuildFrameBottomInset:DisableDrawLayer("BORDER")
		self:skinDropDown{obj=GuildDropDown}
		GuildLevelFrame:DisableDrawLayer("BACKGROUND")
		--[=[
			TODO XPBar not using sb texture/ background
		--]=]
		GuildXPBar:DisableDrawLayer("BORDER")
		GuildXPBarProgress:SetTexture(self.sbTexture)
		GuildXPBarShadow:SetAlpha(0)
		GuildXPBarCap:SetTexture(self.sbTexture)
		--[=[
			TODO faction bar not using statusbar texture
		--]=]
		self:glazeStatusBar(GuildFactionBar, 0, GuildFactionBarBG)
		GuildFactionBarLeft:SetAlpha(0)
		GuildFactionBarRight:SetAlpha(0)
		GuildFactionBarMiddle:SetAlpha(0)
		-- GuildMain Frame
		GuildPerksToggleButton:DisableDrawLayer("BACKGROUND")
		GuildNewPerksFrame:DisableDrawLayer("BACKGROUND")
		GuildUpdatesNoNews:SetTextColor(self.BTr, self.BTg, self.BTb)
		GuildUpdatesDivider:SetAlpha(0)
		GuildUpdatesNoEvents:SetTextColor(self.BTr, self.BTg, self.BTb)
		GuildLatestPerkButtonNameFrame:SetTexture(nil)
		GuildNextPerkButtonNameFrame:SetTexture(nil)
		GuildAllPerksFrame:DisableDrawLayer("BACKGROUND")
		self:skinSlider{obj=GuildPerksContainerScrollBar, size=2}
		for i = 1, #GuildPerksContainer.buttons do
			--[=[
				TODO textures reappear when scrolling
			--]=]
			GuildPerksContainer.buttons[i]:DisableDrawLayer("BACKGROUND")
			GuildPerksContainer.buttons[i]:DisableDrawLayer("BORDER")
		end
		self:addSkinFrame{obj=GuildFrame, ft=ftype, kfs=true, ri=true, y1=2, x2=1, y2=-6}
		-- Roster Panel
		self:skinDropDown{obj=GuildRosterViewDropdown}
		self:skinFFColHeads("GuildRosterColumnButton", 5)
		self:skinSlider{obj=GuildRosterContainerScrollBar, size=2}
		for i = 1, #GuildRosterContainer.buttons do
			GuildRosterContainer.buttons[i]:DisableDrawLayer("BACKGROUND")
			GuildRosterContainer.buttons[i].barTexture:SetTexture(self.sbTexture)
			--[=[
				TODO handle header lines, when textures removed other text is revealed
			--]=]
--			GuildRosterContainer.buttons[i].header:DisableDrawLayer("BORDER")
--			GuildRosterContainer.buttons[i].header:DisableDrawLayer("BACKGROUND")
		end
		self:addSkinFrame{obj=GuildMemberDetailFrame, ft=ftype, kfs=true, nb=true}--, x1=10, y1=-12, x2=-32, y2=71}
		-- News Panel
		GuildNewsFrame:DisableDrawLayer("BACKGROUND")
		self:skinSlider{obj=GuildNewsContainerScrollBar, size=2}
		for i = 1, #GuildNewsContainer.buttons do
			GuildNewsContainer.buttons[i].header:SetAlpha(0)
		end
		self:skinDropDown{obj=GuildNewsDropDown}
		self:addSkinFrame{obj=GuildNewsFiltersFrame, ft=ftype, kfs=true, x1=7, y1=-7, x2=-7, y2=7}
		self:addSkinFrame{obj=GuildNewsBossModel, ft=ftype, kfs=true}
		-- Rewards Panel
		GuildRewardsFrame:DisableDrawLayer("BACKGROUND")
		self:skinSlider{obj=GuildRewardsContainerScrollBar, size=2}
		for i = 1, #GuildRewardsContainer.buttons do
			GuildRewardsContainer.buttons[i]:GetNormalTexture():SetAlpha(0)
		end
		self:skinDropDown{obj=GuildRewardsDropDown}
		-- Info Panel
		self:removeRegions(GuildInfoFrame, {1, 2, 3, 4, 5, 6 ,7, 8}) -- Background textures and bars
		self:skinSlider{obj=GuildInfoEventsContainerScrollBar, size=2}
		GuildInfoNoEvents:SetTextColor(self.BTr, self.BTg, self.BTb)
		self:skinSlider{obj=GuildInfoDetailsFrameScrollBar, size=2}
		-- Guild Text Edit frame
		--[=[
			TODO close button is too large
		--]=]
		self:skinSlider{obj=GuildTextEditScrollFrameScrollBar, size=2}
		self:addSkinFrame{obj=GuildTextEditContainer, ft=ftype, nb=true}
		self:addSkinFrame{obj=GuildTextEditFrame, ft=ftype, kfs=true, nb=true, x1=7, y1=-7, x2=-7, y2=7}
		-- Guild Log Frame
		--[=[
			TODO close button is too large
		--]=]
		self:skinSlider{obj=GuildLogScrollFrameScrollBar, size=2}
		self:addSkinFrame{obj=GuildLogContainer, ft=ftype, nb=true}
		self:addSkinFrame{obj=GuildLogFrame, ft=ftype, kfs=true, nb=true, x1=7, y1=-7, x2=-7, y2=7}

	-->>-- Tabs
		for i = 1, GuildFrame.numTabs do
			local tabObj = _G["GuildFrameTab"..i]
			self:keepRegions(tabObj, {7, 8}) -- N.B. region 7 is text, 8 is highlight
			local tabSF = self:addSkinFrame{obj=tabObj, ft=ftype, noBdr=self.isTT, x1=6, y1=0, x2=-6, y2=2}
			if i == 1 then
				if self.isTT then self:setActiveTab(tabSF) end
			else
				if self.isTT then self:setInactiveTab(tabSF) end
			end
		end
		self.tabFrames[GuildFrame] = true

	end

	function Skinner:GuildControlUI()

		GuildControlUI:DisableDrawLayer("BACKGROUND")
		GuildControlUIHbar:SetAlpha(0)
		self:skinDropDown{obj=GuildControlUI.dropdown}
		self:addSkinFrame{obj=GuildControlUI, ft=ftype, kfs=true, x1=10, y1=-10, x2=-10, y2=10}
		-- Guild Ranks Panel
		local function skinROFrames()

			for i = 1, MAX_GUILDRANKS do
				local frame = _G["GuildControlUIRankOrderFrameRank"..i]
				if frame
				and not Skinner.skinned[frame]
				then
					Skinner:skinEditBox{obj=frame.nameBox, regs={9}, x=-5}
				end
			end

		end
		self:SecureHook("GuildControlUI_RankOrder_Update", function(...)
			skinROFrames()
		end)
		skinROFrames()
		-- Rank Permissions Panel
		self:skinSlider{obj=GuildControlUIRankBankFrameInsetScrollFrameScrollBar, size=2}
		GuildControlUI.rankPermFrame:DisableDrawLayer("BACKGROUND")
		self:skinDropDown{obj=GuildControlUI.rankPermFrame.dropdown}
		self:skinEditBox{obj=GuildControlUI.rankPermFrame.goldBox, regs={9}}
		-- Bank Tab Permissions panel
		self:skinDropDown{obj=GuildControlUI.bankTabFrame.dropdown}
		GuildControlUI.bankTabFrame.inset:DisableDrawLayer("BACKGROUND")
		GuildControlUI.bankTabFrame.inset:DisableDrawLayer("BORDER")
		for i = 1, #GuildControlUI.bankTabFrame.scrollFrame.buttons do
			local btn = GuildControlUI.bankTabFrame.scrollFrame.buttons[i]
			btn:DisableDrawLayer("BACKGROUND")
			self:skinEditBox{obj=btn.owned.editBox, regs={9}}
			self:skinButton{obj=btn.buy.button, as=true}
		end

	end

end
