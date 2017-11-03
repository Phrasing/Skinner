local aName, aObj = ...
if not aObj:isAddonEnabled("Guild_Roster_Manager") then return end
local _G = _G

aObj.addonsToSkin.Guild_Roster_Manager = function(self) -- 7.3.2R1.101

	-- FIXME - remove spaces from the realm name when constructing the PlayerName string so it matches subsequent checks
	_G.GRM_AddonGlobals.addonPlayerName = (_G.GetUnitName ( "PLAYER" , false ) .. "-" .. _G.GRM_AddonGlobals.realmName:gsub(" ", ""))

	-- buttons on GuildRoster subframe)
	self:skinStdButton{obj=_G.GRM_LoadLogButton}
	self:skinStdButton{obj=_G.GRM_BanListButton}
	self:skinStdButton{obj=_G.GRM_AddonUsersButton}

	-- GRM_MemberDetailMetaData (appears on mouseover of guild members on GuildRoster frame when showing Guild Status)
	self:skinStdButton{obj=_G.GRM_MemberDetailJoinDateButton}
	self:skinStdButton{obj=_G.GRM_SetPromoDateButton}
	self:removeInset(_G.GRM_DayDropDownMenuSelected)
	self:addSkinFrame{obj=_G.GRM_DayDropDownMenu, ft="a", kfs=true}
	self:removeInset(_G.GRM_YearDropDownMenuSelected)
	self:addSkinFrame{obj=_G.GRM_YearDropDownMenu, ft="a", kfs=true}
	self:removeInset(_G.GRM_MonthDropDownMenuSelected)
	self:addSkinFrame{obj=_G.GRM_MonthDropDownMenu, ft="a", kfs=true}
	self:skinStdButton{obj=_G.GRM_DateSubmitButton}
	self:skinStdButton{obj=_G.GRM_DateSubmitCancelButton}
	self:skinEditBox{obj=_G.GRM_PlayerNoteEditBox, regs={6}} -- 6 is text
	self:addSkinFrame{obj=_G.GRM_PlayerNoteWindow, ft="a", x1=-2, x2=2}
	self:skinEditBox{obj=_G.GRM_PlayerOfficerNoteEditBox, regs={6}} -- 6 is text
	self:addSkinFrame{obj=_G.GRM_PlayerOfficerNoteWindow, ft="a", x1=-2, x2=2}

	-- appears when right clicking on date(s)
	self:addSkinFrame{obj=_G.GRM_altDropDownOptions, ft="a"}

	-- N.B. use ApplySkin for buttons otherwise Button skin frame disappears!
	self:addSkinFrame{obj=_G.GRM_MemberDetailMetaData, ft="a", kfs=true, bas=true, x1=2, y2=6}
	_G.GRM_MemberDetailMetaDataCloseButton:SetSize(30, 30)

	-- tooltips
	_G.C_Timer.After(0.1, function()
		self:add2Table(self.ttList, _G.GRM_MemberDetailRankToolTip)
		self:add2Table(self.ttList, _G.GRM_MemberDetailJoinDateToolTip)
		self:add2Table(self.ttList, _G.GRM_MemberDetailServerNameToolTip)
		self:add2Table(self.ttList, _G.GRM_MemberDetailNotifyStatusChangeTooltip)
		self:add2Table(self.ttList, _G.GRM_altFrameToolTip)
	end)

	-- GRM_PopupWindow
	_G.RaiseFrameLevelByTwo(_G.GRM_PopupWindow)
	self:addSkinFrame{obj=_G.GRM_PopupWindow, ft="a", kfs=true}

	-- GRM_MemberDetailEditBoxFrame
	self:skinEditBox{obj=_G.GRM_MemberDetailPopupEditBox, regs={6}} -- 6 is text
	self:addSkinFrame{obj=_G.GRM_MemberDetailEditBoxFrame, ft="a", kfs=true}

	-- GRM_CoreAltFrame

	-- GRM_AddAltEditFrame
	self:skinEditBox{obj=_G.GRM_AddAltEditBox, regs={6}, noInsert=true} -- 6 is text
	self:skinStdButton{obj=_G.GRM_AddAltButton}
	self:addSkinFrame{obj=_G.GRM_AddAltEditFrame, ft="a", kfs=true, ofs=-6}

	-- GRM_AddEventFrame
	self:addSkinFrame{obj=_G.GRM_AddEventScrollBorderFrame, ft="a", kfs=true, ofs=-4}
	self:skinSlider{obj=_G.GRM_AddEventScrollFrameSlider, wdth=-4}
	self:addSkinFrame{obj=_G.GRM_AddEventFrame, ft="a", kfs=true, ofs=2, x2=1}

	-- GRM_RosterChangeLogFrame
	self:skinCheckButton{obj=_G.GRM_UI.GRM_RosterLoadOnLogonCheckButton}
	_G.GRM_UI.GRM_RosterLoadOnLogonCheckButton.sb:Show() -- hidden by default
	self:skinCheckButton{obj=_G.GRM_RosterAddTimestampCheckButton}
	self:skinCheckButton{obj=_G.GRM_RosterReportAddEventsToCalendarButton}
	self:skinCheckButton{obj=_G.GRM_RosterMainOnlyCheckButton}
	self:skinCheckButton{obj=_G.GRM_SyncOnlyCurrentVersionCheckButton}
	self:skinCheckButton{obj=_G.GRM_RosterSyncBanList}
	self:removeInset(_G.GRM_RosterBanListDropDownSelected)
	self:skinCheckButton{obj=_G.GRM_RosterNotifyOnChangesCheckButton}
	self:skinCheckButton{obj=_G.GRM_RosterTimeIntervalCheckButton}
	self:skinCheckButton{obj=_G.GRM_RosterRecommendKickCheckButton}
	self:skinEditBox{obj=_G.GRM_RosterKickRecommendEditBox, regs={6}, noWidth=true} -- 6 is text
	self:skinCheckButton{obj=_G.GRM_RosterReportInactiveReturnButton}
	self:skinEditBox{obj=_G.GRM_ReportInactiveReturnEditBox, regs={6}, noWidth=true} -- 6 is text
	self:skinCheckButton{obj=_G.GRM_RosterReportUpcomingEventsCheckButton}
	self:skinEditBox{obj=_G.GRM_RosterReportUpcomingEventsEditBox, regs={6}, noWidth=true} -- 6 is text
	self:skinCheckButton{obj=_G.GRM_RosterSyncCheckButton}
	self:removeInset(_G.GRM_RosterSyncRankDropDownSelected)
	self:addSkinFrame{obj=_G.GRM_RosterSyncRankDropDownMenu, ft="a", kfs=true}
	self:skinSlider{obj=_G.GRM_RosterChangeLogScrollFrameSlider} -- size changed in code
	self:addSkinFrame{obj=_G.GRM_RosterChangeLogScrollBorderFrame, ft="a", kfs=true, ofs=-2, y1=-5, x2=-4}
	self:skinStdButton{obj=_G.GRM_ScanOptionsButton}
	self:skinStdButton{obj=_G.GRM_SyncOptionsButton}
	self:skinStdButton{obj=_G.GRM_CenterOptionsButton}
	self:skinStdButton{obj=_G.GRM_HelpOptionsButton}
	self:skinStdButton{obj=_G.GRM_ClearAllOptionsButton}
	self:skinStdButton{obj=_G.GRM_VersionOptionsButton}
	self:skinStdButton{obj=_G.GRM_SyncInfoOptionsButton}
	self:skinStdButton{obj=_G.GRM_ResetDefaultOptionsButton}
	self:skinStdButton{obj=_G.GRM_RosterOptionsButton}
	self:skinStdButton{obj=_G.GRM_RosterClearLogButton}
	self:addSkinFrame{obj=_G.GRM_RosterChangeLogFrame, ft="a", kfs=true, ofs=2, x2=1}

	-- GRM_RosterCheckBoxSideFrame
	for _, type in pairs{"Joined", "LeveledChange", "InactiveReturn", "PromotionChange", "DemotionChange", "NoteChange", "OfficerNoteChange", "NameChange", "RankRename", "Event", "LeftGuild"} do
		self:skinCheckButton{obj=_G["GRM_Roster" .. type .. "CheckButton"]}
		if type == "LeveledChange"
		or type == "PromotionChange"
		or type == "DemotionChange"
		or type == "NoteChange"
		or type == "OfficerNoteChange"
		then
			type = type:gsub("Change", "") -- remove "Change"
		end
		self:skinCheckButton{obj=_G["GRM_Roster" .. type .. "ChatCheckButton"]}
	end
	self:skinCheckButton{obj=_G.GRM_RosterRecommendationsButton}
	self:skinCheckButton{obj=_G.GRM_RosterRecommendationsChatButton}
	self:skinCheckButton{obj=_G.GRM_RosterBannedPlayersButton}
	self:skinCheckButton{obj=_G.GRM_RosterBannedPlayersButtonChatButton}
	self:addSkinFrame{obj=_G.GRM_RosterCheckBoxSideFrame, ft="a", kfs=true, ofs=-3}

	-- GRM_RosterConfirmFrame
	self:skinStdButton{obj=_G.GRM_RosterConfirmYesButton}
	self:skinStdButton{obj=_G.GRM_RosterConfirmCancelButton}
	self:addSkinFrame{obj=_G.GRM_RosterConfirmFrame, ft="a", kfs=true, ofs=2, x2=1}

	-- GRM_AddonUsersCoreFrame
	self:addSkinFrame{obj=_G.GRM_AddonUsersCoreFrame, ft="a", kfs=true, ofs=2, x2=1}
	self:skinSlider{obj=_G.GRM_AddonUsersScrollFrameSlider}
	self:addSkinFrame{obj=_G.GRM_AddonUsersScrollBorderFrame, ft="a", kfs=true, nb=true, ofs=-2, x1=-4}

	-- GRM_CoreBanListFrame
	self:addSkinFrame{obj=_G.GRM_CoreBanListFrame, ft="a", kfs=true, ofs=2, x2=1}
	self:skinSlider{obj=_G.GRM_CoreBanListScrollFrameSlider}
	self:addSkinFrame{obj=_G.GRM_CoreBanListScrollBorderFrame, ft="a", kfs=true, nb=true, aso={bd=10, ng=true}, ofs=-2, x1=-4} -- no backdrop background & no gradient texture (allows text to be seen)
	self:skinStdButton{obj=_G.GRM_BanListRemoveButton}
	self:skinStdButton{obj=_G.GRM_BanListAddButton}

	-- hook these to handle frame changes
	self:SecureHook(_G.GRM_UI, "GR_MetaDataInitializeUIFirst", function(this)
		self:adjHeight{obj=_G.GRM_DateSubmitButton, adj=-4}
		self:adjHeight{obj=_G.GRM_DateSubmitCancelButton, adj=-4}
		_G.GRM_PlayerNoteWindow:SetBackdrop(nil)
		_G.GRM_PlayerOfficerNoteWindow:SetBackdrop(nil)
		self:Unhook(this, "GR_MetaDataInitializeUIFirst")
	end)
	self:SecureHook(_G.GRM_UI, "GR_MetaDataInitializeUISecond", function(this)
		_G.GRM_MemberDetailPopupEditBox:SetTextInsets(6 ,3 ,3 ,6)
		_G.GRM_altDropDownOptions:SetBackdrop(nil)
		self:Unhook(this, "GR_MetaDataInitializeUISecond")
	end)
	self:SecureHook(_G.GRM_UI, "GR_MetaDataInitializeUIThird", function(this)
		_G.GRM_AddAltEditBox:SetTextInsets(6 ,3 ,3 ,6)
		_G.GRM_LoadLogButton:SetSize(60, 16)
		_G.GRM_LoadLogButton:ClearAllPoints()
	    _G.GRM_LoadLogButton:SetPoint("BOTTOMLEFT" ,_G.GuildRosterFrame ,"TOPLEFT" ,30 ,0.5)
		_G.GRM_BanListButton:SetSize(60, 16)
	    _G.GRM_AddonUsersButton:SetSize(60, 16)
		_G.GRM_MemberDetailMetaData:SetPoint("TOPLEFT", _G.GuildRosterFrame, "TOPRIGHT", -2, 2)
		self:Unhook(this, "GR_MetaDataInitializeUIThird")
	end)
	self:SecureHook(_G.GRM_UI, "MetaDataInitializeUIrosterLog1", function(this)
		_G.GRM_RosterOptionsButton:SetSize (90 ,20)
		_G.GRM_RosterClearLogButton:SetSize (90 ,20)
		_G.GRM_RosterTimeIntervalOverlayNote:SetBackdrop(nil)
		_G.GRM_RosterKickOverlayNote:SetBackdrop(nil)
		_G.GRM_ReportInactiveReturnEditBox:SetWidth(38)
		_G.GRM_ReportInactiveReturnEditBox:ClearAllPoints()
		_G.GRM_ReportInactiveReturnEditBox:SetPoint("RIGHT", _G.GRM_RosterReportInactiveReturnButtonText2, "LEFT", 2, 0)
		_G.GRM_ReportInactiveReturnEditBox:SetTextInsets(6 ,9 ,9 ,6)
		_G.GRM_ReportInactiveReturnOverlayNote:SetBackdrop(nil)
		_G.GRM_RosterReportUpcomingEventsOverlayNote:SetBackdrop(nil)
		self:Unhook(this, "MetaDataInitializeUIrosterLog1")
	end)

end
