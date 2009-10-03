local _G = _G
local ftype = "n"

function Skinner:MerchantFrames()
	if not self.db.profile.MerchantFrames or self.initialized.MerchantFrames then return end
	self.initialized.MerchantFrames = true

	if self.isTT then
		-- hook this to change the texture for the Active and Inactive tabs
		self:SecureHook("MerchantFrame_Update",function()
			for i = 1, MerchantFrame.numTabs do
				local tabSF = self.skinFrame[_G["MerchantFrameTab"..i]]
				if i == MerchantFrame.selectedTab then
					self:setActiveTab(tabSF)
				else
					self:setInactiveTab(tabSF)
				end
			end
		end)
	end

	self:removeRegions(MerchantPrevPageButton, {2})
	self:removeRegions(MerchantNextPageButton, {2})

	self:skinButton{obj=MerchantFrameCloseButton, cb=true}
	self:addSkinFrame{obj=MerchantFrame, ft=ftype, kfs=true, x1=10, y1=-11, x2=-33, y2=55}

-->>-- Tabs
	for i = 1, MerchantFrame.numTabs do
		local tabName = _G["MerchantFrameTab"..i]
		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is text, 8 is highlight
		self:addSkinFrame{obj=tabName, ft=ftype, noBdr=self.isTT, x1=6, x2=-6, y2=2}
		local tabSF = self.skinFrame[tabName]
		if i == 1 then
			if self.isTT then self:setActiveTab(tabSF) end
		else
			if self.isTT then self:setInactiveTab(tabSF) end
		end
	end

end

function Skinner:GossipFrame()
	if not self.db.profile.GossipFrame or self.initialized.GossipFrame then return end
	self.initialized.GossipFrame = true

	-- setup Quest display colours here
	local QTHex = self:RGBPercToHex(self.HTr, self.HTg, self.HTb)
	NORMAL_QUEST_DISPLAY = "|cff"..QTHex.."%s|r"
	TRIVIAL_QUEST_DISPLAY = "|cff"..QTHex.."%s (low level)|r"

	self:keepFontStrings(GossipFrameGreetingPanel)
	GossipGreetingText:SetTextColor(self.HTr, self.HTg, self.HTb)
	self:skinScrollBar{obj=GossipGreetingScrollFrame}
	for i = 1, NUMGOSSIPBUTTONS do
		local text = self:getRegion(_G["GossipTitleButton"..i], 3)
		text:SetTextColor(self.BTr, self.BTg, self.BTb)
	end
	self:skinButton{obj=GossipFrameGreetingGoodbyeButton}

	self:skinButton{obj=GossipFrameCloseButton, cb=true}
	self:addSkinFrame{obj=GossipFrame, ft=ftype, kfs=true, x1=12, y1=-18, x2=-29, y2=66}

end

function Skinner:TrainerUI()
	if not self.db.profile.TrainerUI or self.initialized.TrainerUI then return end
	self.initialized.TrainerUI = true

	if self.db.profile.Buttons then
		-- hook to manage changes to button textures
		self:SecureHook("ClassTrainerFrame_Update", function()
			for i = 1, CLASS_TRAINER_SKILLS_DISPLAYED do
				self:checkTex(_G["ClassTrainerSkill"..i])
			end
			self:checkTex(ClassTrainerCollapseAllButton)
		end)
	end

	self:keepFontStrings(ClassTrainerExpandButtonFrame)
	self:skinButton{obj=ClassTrainerCollapseAllButton, mp=true}
	self:skinDropDown{obj=ClassTrainerFrameFilterDropDown}
	for i = 1, CLASS_TRAINER_SKILLS_DISPLAYED do
		self:skinButton{obj=_G["ClassTrainerSkill"..i], mp=true}
	end
	self:skinScrollBar{obj=ClassTrainerListScrollFrame}
	self:skinScrollBar{obj=ClassTrainerDetailScrollFrame}
	self:skinButton{obj=ClassTrainerTrainButton}
	self:skinButton{obj=ClassTrainerCancelButton}
	self:skinButton{obj=ClassTrainerFrameCloseButton, cb=true}
	self:addSkinFrame{obj=ClassTrainerFrame, ft=ftype, kfs=true, x1=10, y1=-11, x2=-32, y2=74}

	if self.db.profile.Buttons then ClassTrainerFrame_Update() end -- force update for button textures

end

function Skinner:TaxiFrame()
	if not self.db.profile.TaxiFrame or self.initialized.TaxiFrame then return end
	self.initialized.TaxiFrame = true

	self:keepRegions(TaxiFrame, {6, 7}) -- N.B. region 6 is TaxiName, 7 is the Map background

	self:skinButton{obj=TaxiCloseButton, cb=true}
	self:addSkinFrame{obj=TaxiFrame, ft=ftype, x1=10, y1=-11, x2=-32, y2=74}

end

function Skinner:QuestFrame()
	if not self.db.profile.QuestFrame or self.initialized.QuestFrame then return end
	self.initialized.QuestFrame = true

	-- setup Quest display colours here
	local QTHex = self:RGBPercToHex(self.HTr, self.HTg, self.HTb)
	NORMAL_QUEST_DISPLAY = "|cff"..QTHex.."%s|r"
	TRIVIAL_QUEST_DISPLAY = "|cff"..QTHex.."%s (low level)|r"

	self:RawHook("QuestFrame_SetTitleTextColor", function(fontString, ...)
		fontString:SetTextColor(self.HTr, self.HTg, self.HTb)
	end, true)
	self:RawHook("QuestFrame_SetTextColor", function(fontString, ...)
		fontString:SetTextColor(self.BTr, self.BTg, self.BTb)
	end, true)

	self:skinButton{obj=QuestFrameCloseButton, cb=true}
	self:addSkinFrame{obj=QuestFrame, ft=ftype, kfs=true, x1=12, y1=-18, x2=-29, y2=66}

-->>--	Reward Panel
	self:keepFontStrings(QuestFrameRewardPanel)
	QuestRewardHonorFrameHonorReceiveText:SetTextColor(self.BTr, self.BTg, self.BTb)
	QuestRewardTalentFrameTalentReceiveText:SetTextColor(self.BTr, self.BTg, self.BTb)
	self:skinButton{obj=QuestFrameCancelButton}
	self:skinButton{obj=QuestFrameCompleteQuestButton}
	self:skinScrollBar{obj=QuestRewardScrollFrame}

-->>--	Progress Panel
	self:keepFontStrings(QuestFrameProgressPanel)
	QuestProgressRequiredItemsText:SetTextColor(self.HTr, self.HTg, self.HTb)
	self:skinButton{obj=QuestFrameGoodbyeButton}
	self:skinButton{obj=QuestFrameCompleteButton}
	self:skinScrollBar{obj=QuestProgressScrollFrame}

-->>--	Detail Panel
	self:keepFontStrings(QuestFrameDetailPanel)
	QuestDetailHonorFrameHonorReceiveText:SetTextColor(self.BTr, self.BTg, self.BTb)
	QuestDetailTalentFrameTalentReceiveText:SetTextColor(self.BTr, self.BTg, self.BTb)
	self:skinButton{obj=QuestFrameAcceptButton}
	self:skinButton{obj=QuestFrameDeclineButton}
	self:skinScrollBar{obj=QuestDetailScrollFrame}

-->>--	Greeting Panel
	self:keepFontStrings(QuestFrameGreetingPanel)
	self:skinButton{obj=QuestFrameGreetingGoodbyeButton}
	self:skinScrollBar{obj=QuestGreetingScrollFrame}
	if QuestFrameGreetingPanel:IsShown() then
		GreetingText:SetTextColor(self.BTr, self.BTg, self.BTb)
		CurrentQuestsText:SetTextColor(self.HTr, self.HTg, self.HTb)
		AvailableQuestsText:SetTextColor(self.HTr, self.HTg, self.HTb)
	end

end

function Skinner:Battlefields()
	if not self.db.profile.Battlefields or self.initialized.Battlefields then return end
	self.initialized.Battlefields = true

	self:skinScrollBar{obj=BattlefieldListScrollFrame}
	BattlefieldFrameZoneDescription:SetTextColor(self.BTr, self.BTg, self.BTb)

	self:skinButton{obj=BattlefieldFrameCloseButton, cb=true}
	self:skinButton{obj=BattlefieldFrameCancelButton}
	self:skinButton{obj=BattlefieldFrameJoinButton}
	self:addSkinFrame{obj=BattlefieldFrame, ft=ftype, kfs=true, x1=10, y1=-12, x2=-32, y2=71}

end

function Skinner:ArenaFrame()
	if not self.db.profile.ArenaFrame or self.initialized.ArenaFrame then return end
	self.initialized.ArenaFrame = true

	ArenaFrameZoneDescription:SetTextColor(self.BTr, self.BTg, self.BTb)

	self:skinButton{obj=ArenaFrameCancelButton}
	self:skinButton{obj=ArenaFrameJoinButton}
	self:skinButton{obj=ArenaFrameGroupJoinButton}
	self:skinButton{obj=ArenaFrameCloseButton, cb=true}
	self:addSkinFrame{obj=ArenaFrame, ft=ftype, kfs=true, x1=10, y1=-12, x2=-32, y2=71}

end

function Skinner:ArenaRegistrar()
	if not self.db.profile.ArenaRegistrar or self.initialized.ArenaRegistrar then return end
	self.initialized.ArenaRegistrar = true

-->>--	Arena Registrar Frame
	self:skinButton{obj=ArenaRegistrarFrameCloseButton, cb=true}
	self:keepFontStrings(ArenaRegistrarGreetingFrame)
	self:getRegion(ArenaRegistrarGreetingFrame, 1):SetTextColor(self.HTr, self.HTg, self.HTb) -- AvailableServicesText (name also used by GuildRegistrar frame)
	RegistrationText:SetTextColor(self.HTr, self.HTg, self.HTb)
	self:skinButton{obj=ArenaRegistrarFrameGoodbyeButton}
	for i = 1, MAX_TEAM_BORDERS do
		local text = self:getRegion(_G["ArenaRegistrarButton"..i], 3)
		text:SetTextColor(self.BTr, self.BTg, self.BTb)
	end
	ArenaRegistrarPurchaseText:SetTextColor(self.BTr, self.BTg, self.BTb)
	self:skinButton{obj=ArenaRegistrarFrameCancelButton}
	self:skinButton{obj=ArenaRegistrarFramePurchaseButton}
	self:skinEditBox{obj=ArenaRegistrarFrameEditBox}
	self:addSkinFrame{obj=ArenaRegistrarFrame, ft=ftype, kfs=true, x1=10, y1=-17, x2=-29, y2=64}

-->>--	PVP Banner Frame
	self:keepRegions(PVPBannerFrame, {6, 17, 18, 19, 20, 21, 22}) -- N.B. region 6 is the background, 17 - 20 are the emblem, 21, 22 are the text

	self:removeRegions(PVPBannerFrameCustomizationFrame)
	self:keepFontStrings(PVPBannerFrameCustomization1)
	self:keepFontStrings(PVPBannerFrameCustomization2)
	self:skinButton{obj=PVPColorPickerButton1}
	self:skinButton{obj=PVPColorPickerButton2}
	self:skinButton{obj=PVPColorPickerButton3}
	self:skinButton{obj=PVPBannerFrameCancelButton}
	self:skinButton{obj=PVPBannerFrameSaveButton}

	self:skinButton{obj=PVPBannerFrameAcceptButton}
	self:skinButton{obj=self:getChild(PVPBannerFrame, 4)} -- PVPBannerFrameCancelButton (name used by PVPBannerFrameCustomizationFrame)
	self:skinButton{obj=PVPBannerFrameCloseButton, cb=true}
	self:addSkinFrame{obj=PVPBannerFrame, ft=ftype, x1=10, y1=-12, x2=-32, y2=74}

end

function Skinner:GuildRegistrar()
	if not self.db.profile.GuildRegistrar or self.initialized.GuildRegistrar then return end
	self.initialized.GuildRegistrar = true

	self:keepFontStrings(GuildRegistrarGreetingFrame)
	AvailableServicesText:SetTextColor(self.HTr, self.HTg, self.HTb)
	GuildRegistrarPurchaseText:SetTextColor(self.BTr, self.BTg, self.BTb)
	for i = 1, 2 do
		local text = self:getRegion(_G["GuildRegistrarButton"..i], 3)
		text:SetTextColor(self.BTr, self.BTg, self.BTb)
	end
	self:skinEditBox{obj=GuildRegistrarFrameEditBox}

	self:skinButton{obj=GuildRegistrarFrameCloseButton, cb=true}
	self:skinButton{obj=GuildRegistrarFrameGoodbyeButton}
	self:skinButton{obj=GuildRegistrarFrameCancelButton}
	self:skinButton{obj=GuildRegistrarFramePurchaseButton}
	self:addSkinFrame{obj=GuildRegistrarFrame, ft=ftype, kfs=true, x1=12, y1=-17, x2=-29, y2=65}

end

function Skinner:Petition()
	if not self.db.profile.Petition or self.initialized.Petition then return end
	self.initialized.Petition = true

	PetitionFrameCharterTitle:SetTextColor(self.HTr, self.HTg, self.HTb)
	PetitionFrameCharterName:SetTextColor(self.BTr, self.BTg, self.BTb)
	PetitionFrameMasterTitle:SetTextColor(self.HTr, self.HTg, self.HTb)
	PetitionFrameMasterName:SetTextColor(self.BTr, self.BTg, self.BTb)
	PetitionFrameMemberTitle:SetTextColor(self.HTr, self.HTg, self.HTb)
	for i = 1, 9 do
		_G["PetitionFrameMemberName"..i]:SetTextColor(self.BTr, self.BTg, self.BTb)
	end
	PetitionFrameInstructions:SetTextColor(self.BTr, self.BTg, self.BTb)

	self:skinButton{obj=PetitionFrameCloseButton, cb=true}
	self:skinButton{obj=PetitionFrameCancelButton}
	self:skinButton{obj=PetitionFrameSignButton}
	self:skinButton{obj=PetitionFrameRequestButton}
	self:skinButton{obj=PetitionFrameRenameButton}
	self:addSkinFrame{obj=PetitionFrame, ft=ftype, kfs=true, x1=12, y1=-17, x2=-29, y2=65}

end

function Skinner:Tabard()
	if not self.db.profile.Tabard or self.initialized.Tabard then return end
	self.initialized.Tabard = true

	self:keepRegions(TabardFrame, {6, 17, 18, 19, 20, 21, 22}) -- N.B. region 6 is the background, 17 - 20 are the emblem, 21, 22 are the text

	TabardCharacterModelRotateLeftButton:Hide()
	TabardCharacterModelRotateRightButton:Hide()
	self:makeMFRotatable(TabardModel)
	TabardFrameCostFrame:SetBackdrop(nil)
	self:keepFontStrings(TabardFrameCustomizationFrame)
	for i = 1, 5 do
		self:keepFontStrings(_G["TabardFrameCustomization"..i])
	end

	self:skinButton{obj=TabardFrameCloseButton, cb=true}
	self:skinButton{obj=TabardFrameAcceptButton}
	self:skinButton{obj=TabardFrameCancelButton}
	self:addSkinFrame{obj=TabardFrame, ft=ftype, kfs=true, x1=10, y1=-12, x2=-32, y2=74}

end

function Skinner:BarbershopUI()
	if not self.db.profile.BarbershopUI or self.initialized.Barbershop then return end
	self.initialized.Barbershop = true

-->>-- Barbershop Banner Frame
	self:keepFontStrings(BarberShopBannerFrame)
	BarberShopBannerFrameCaption:ClearAllPoints()
	BarberShopBannerFrameCaption:SetPoint("CENTER", BarberShopFrame, "TOP", 0, -46)
-->>-- Barbershop Frame
	self:keepFontStrings(BarberShopFrameMoneyFrame)

	self:skinButton{obj=BarberShopFrameOkayButton}
	self:skinButton{obj=BarberShopFrameCancelButton}
	self:skinButton{obj=BarberShopFrameResetButton}
	self:addSkinFrame{obj=BarberShopFrame, ft=ftype, kfs=true, x1=35, y1=-32, x2=-32, y2=42}

end
