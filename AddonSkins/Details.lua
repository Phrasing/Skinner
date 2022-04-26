local _, aObj = ...
if not aObj:isAddonEnabled("Details") then return end
local _G = _G

-- used by all contained functions
local Details = _G.LibStub:GetLibrary("AceAddon-3.0"):GetAddon("_detalhes", true)

aObj.addonsToSkin.Details = function(self) -- v 9.2.0.9735.146

	-- Player Details Window
	self:skinObject("frame", {obj=_G.DetailsPlayerDetailsWindow, kfs=true, ofs=4})

	-- Report Window
	if _G.DetailsReportWindow then
		self:skinObject("frame", {obj=_G.DetailsReportWindow, kfs=true, ofs=4})
	else
		self:SecureHook(Details.gump, "CriaJanelaReport", function(this)
			self:skinObject("frame", {obj=_G.DetailsReportWindow, kfs=true, ofs=4})

			self:Unhook(this, "CriaJanelaReport")
		end)
	end

	-- News Window
	local function skinNews()
		_G.DetailsNewsWindow.DumpTableFrame.editbox.sf:Hide() -- not really an editbox
		aObj:skinObject("slider", {obj=_G.DetailsNewsWindowSlider})
	end
	if _G.DetailsNewsWindow then
		skinNews()
	else
		self:SecureHook(Details, "CreateOrOpenNewsWindow", function(this)
			skinNews()

			self:Unhook(this, "CreateOrOpenNewsWindow")
		end)
	end

	-- Welcome Window
	local function skinWelcome()
		aObj:skinObject("frame", {obj=_G.DetailsWelcomeWindow})
		if aObj.modBtnBs then
			local pBtn, nBtn = aObj:getChild(_G.DetailsWelcomeWindow, 2),aObj:getChild(_G.DetailsWelcomeWindow, 3)
			aObj:addButtonBorder{obj=pBtn, ofs=-2, x1=1, clr="gold"}
			aObj:addButtonBorder{obj=nBtn, ofs=-2, x1=1, clr="gold"}
			aObj:SecureHook(pBtn, "Disable", function(bObj, _)
				aObj:clrBtnBdr(bObj)
			end)
			aObj:SecureHook(pBtn, "Enable", function(bObj, _)
				aObj:clrBtnBdr(bObj, "gold")
			end)
			aObj:SecureHook(nBtn, "Disable", function(bObj, _)
				aObj:clrBtnBdr(bObj)
			end)
			aObj:SecureHook(nBtn, "Enable", function(bObj, _)
				aObj:clrBtnBdr(bObj, "gold")
			end)
		end
	end
	if _G.DetailsWelcomeWindow then
		skinWelcome()
	else
		self:SecureHook(Details, "OpenWelcomeWindow", function(this)
			skinWelcome()

			self:Unhook(Details, "OpenWelcomeWindow")
		end)
	end

	-- Base frame(s)
	local function skinInstance(frame)
		frame.cabecalho.top_bg:SetTexture(nil)
		aObj:skinObject("frame", {obj=frame, kfs=true, ofs=4, y1=22})
	end
	self:SecureHook(Details.gump, "CriaJanelaPrincipal", function(this, ID, instancia, criando)
		skinInstance(_G["DetailsBaseFrame" .. ID])
	end)
	-- skin existing instance(s)
	for _, v in _G.ipairs(Details.tabela_instancias) do
		if v.baseframe then
			skinInstance(v.baseframe)
		end
	end

	if not Details:GetTutorialCVar("WINDOW_LOCK_UNLOCK1") then
		-- hook this to skin LockPopUp
		self:SecureHook(Details, "DelayOptionsRefresh", function(this)
			self:skinObject("glowbox", {obj=_G.DetailsWindowLockPopUp1})

			self:Unhook(this, "DelayOptionsRefresh")
		end)
	end

	-- CopyPaste Panel
	local function skinCopy()
		local eb = _G.DetailsCopy.text.editbox
		self:removeBackdrop(eb)
		self:skinObject("editbox", {obj=eb, regions={3, 4, 5, 6, 7, 8, 9, 10, 11}})
		eb.SetBackdropColor = _G.nop
		eb.SetBackdropBorderColor = _G.nop
		self:skinObject("frame", {obj=_G.DetailsCopy, kfs=true, ri=true, ofs=2, x2=1})
	end
	if _G.DetailsCopy then
		skinCopy()
	else
		self:SecureHook(Details, "CreateCopyPasteWindow", function(this)
			skinCopy()

			self:Unhook(this, "CreateCopyPasteWindow")
		end)
	end

	-- Plugins
	for _, v in _G.pairs{"DmgRank", "DpsTuning", "TimeAttack", "Vanguard"} do
		self:checkAndRunAddOn("Details_" .. v, "Details_" .. v)
	end

end

function aObj:Details_DmgRank()

	local DmgRank = Details:GetPlugin("DETAILS_PLUGIN_DAMAGE_RANK")

	if not DmgRank then
		self.Details_DmgRank = nil
		return
	end

	DmgRank.BackgroundTex:SetTexture(nil)
	_G.DetailsDmgRankBadgeBackground:SetBackdrop(nil)
	_G.DetailsDmgRankLeftBackground:SetBackdrop(nil)
	_G.DetailsDmgRankRightBackground:SetBackdrop(nil)
	if self.modBtns then
		self:skinCloseButton{obj=self:getChild(DmgRank.Frame, 1)}
	end

end

function aObj:Details_DpsTuning()

	local DpsTuning = Details:GetPlugin("DETAILS_PLUGIN_DPS_TUNING")

	if not DpsTuning then
		self.Details_DpsTuning = nil
		return
	end

	if self.modBtns then
		self:skinCloseButton{obj=self:getChild(DpsTuning.Frame, 1)}
	end

end

function aObj:Details_TimeAttack()

	local TimeAttack = Details:GetPlugin("DETAILS_PLUGIN_TIME_ATTACK")

	if not TimeAttack then
		self.Details_TimeAttack = nil
		return
	end

	TimeAttack.BackgroundTex:SetAlpha(0) -- texture is changed in code
	self:getRegion(TimeAttack.Frame, 3):SetTexture(nil) -- title background texture
	if self.modBtns then
		self:skinCloseButton{obj=self:getChild(TimeAttack.Frame, 1)}
	end

end

function aObj:Details_Vanguard()

	local Vanguard = Details:GetPlugin("DETAILS_PLUGIN_VANGUARD")

	if not Vanguard then
		self.Details_Vanguard = nil
		return
	end

	if not Vanguard.db.first_run then
		self:SecureHook(Vanguard, "OnDetailsEvent", function(this, event, ...)
			-- help frame displayed on 1st show
			if event == "SHOW" then
				local frame = self:findFrame2(_G.UIParent, "Frame", 175, 400)
				if frame then
					self:skinObject("frame", {obj=frame, kfs=true, ofs=4})
					frame = nil
				end
			end

			self:Unhook(this, "OnDetailsEvent")
		end)
	end

end
