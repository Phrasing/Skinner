local aName, aObj = ...
local _G = _G
local ftype = "p"
local module = aObj:NewModule("UnitFrames", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")

local db
local defaults = {
	profile = {
		alpha = 0.25,
		arena = false,
		focus = false,
		party = false,
		pet = false,
		petlevel = (aObj.uCls == "HUNTER" or aObj.uCls == "WARLOCK") and false or nil,
		petspec = (aObj.uCls == "HUNTER") and true or nil,
		player = false,
		target = false,
	}
}
local lOfs = -9 -- level text offset
local tDelay = 0.2 -- repeating timer delay
local isSkinned = _G.setmetatable({}, {__index = function(t, k) t[k] = true end})
local rpTmr = {}
local unitFrames = {
	"ArenaEnemyBackground",
	"FocusFrame",
	"FocusFrameToT",
	"PartyMemberBackground",
	"PartyMemberBuffTooltip",
	"PlayerFrame",
	"PetFrame",
	"TargetFrame",
	"TargetFrameToT"
}

-- N.B. handle bug in XML & lua which places mana bar 1 pixel too high
local function adjustStatusBarPosn(sBar, yAdj)

	local oPnt
	yAdj = yAdj or 1
	if sBar.TextString then
		oPnt = {sBar.TextString:GetPoint()}
		sBar.TextString:SetPoint(oPnt[1], oPnt[2], oPnt[3], oPnt[4], oPnt[5] + yAdj)
	end
	if sBar == _G.PlayerFrame.healthbar then
		module:RawHook(sBar, "SetPoint", function(this, posn, xOfs, yOfs)
			module.hooks[this].SetPoint(this, posn, xOfs, yOfs + yAdj)
		end, true)
	else
		oPnt = {sBar:GetPoint()}
		sBar:SetPoint(oPnt[1], oPnt[2], oPnt[3], oPnt[4], oPnt[5] + yAdj)
	end
	oPnt = nil

end
local function skinUnitFrame(opts)

	-- setup offset values
	opts.ofs = opts.ofs or 0
	local xOfs1 = opts.x1 or opts.ofs * -1
	local yOfs1 = opts.y1 or opts.ofs
	local xOfs2 = opts.x2 or opts.ofs
	local yOfs2 = opts.y2 or opts.ofs * -1
	aObj:addSkinFrame{obj=opts.obj, ft=ftype, sec=true, aso={bd=11, ng=true}, x1=xOfs1, y1=yOfs1, x2=xOfs2, y2=yOfs2}
	opts.obj.sf:SetBackdropColor(.1, .1, .1, db.alpha) -- use dark background
	opts.obj.sf:EnableMouse(false) -- enable clickthrough

	local tex
	if opts.ft then
		tex = _G[opts.obj:GetName() .. "Flash"]
		tex:ClearAllPoints()
		tex:SetAllPoints(opts.obj.sf)
		aObj:changeRecTex(tex, true, true)
		-- stop changes to texture
		tex.SetTexture = _G.nop
		tex.SetTexCoord = _G.nop
		tex.SetWidth = _G.nop
		tex.SetHeight = _G.nop
		tex.SetPoint = _G.nop
	end
	tex = nil

end
local function skinPlayerF()

	if db.player
	and not isSkinned["Player"]
	then

		local pF = _G.PlayerFrame
		_G.PlayerFrameBackground:SetTexture(nil)
		_G.PlayerFrameTexture:SetAlpha(0) -- texture file is changed dependant upon in vehicle or not
		_G.PlayerFrameVehicleTexture:SetAlpha(0) -- texture file is changed dependant upon in vehicle or not
		_G.PlayerStatusTexture:SetTexture(nil)
		_G.PlayerAttackBackground:SetTexture(nil)
		_G.PlayerRestGlow:SetTexture(nil)
		_G.PlayerAttackGlow:SetTexture(nil)

		-- status bars
		aObj:glazeStatusBar(pF.PlayerFrameHealthBarAnimatedLoss, 0,  nil)
		aObj:glazeStatusBar(pF.healthbar, 0, nil, {pF.myHealPredictionBar, pF.otherHealPredictionBar})
		adjustStatusBarPosn(pF.healthbar)
		aObj:glazeStatusBar(pF.manabar, 0, nil, {pF.manabar.FeedbackFrame.BarTexture, pF.myManaCostPredictionBar}, true)

		-- AlternateManaBar
		aObj:rmRegionsTex(_G.PlayerFrameAlternateManaBar, {2, 3, 4, 5, 6}) -- border textures
		aObj:glazeStatusBar(_G.PlayerFrameAlternateManaBar, 0, _G.PlayerFrameAlternateManaBar.DefaultBackground)
		aObj:moveObject{obj=_G.PlayerFrameAlternateManaBar, y=1}

		-- PowerBarAlt handled in MainMenuBar function (UIF)

		-- casting bar handled in CastingBar function (PF)

		-- move PvP Timer text down
		aObj:moveObject{obj=_G.PlayerPVPTimerText, y=-10}
		-- move level & rest icon down, so they are more visible
		module:RawHook("PlayerFrame_UpdateLevelTextAnchor", function(level)
			_G.PlayerLevelText:SetPoint("CENTER", _G.PlayerFrameTexture, "CENTER", level == 100 and -62 or -61, -17 + lOfs)
		end, true)
		_G.PlayerRestIcon:SetPoint("TOPLEFT", 39, -60)

		-- remove group indicator textures
		aObj:keepFontStrings(_G.PlayerFrameGroupIndicator)
		aObj:moveObject{obj=_G.PlayerFrameGroupIndicatorText, y=-1}

		local function skinComboPointPlayerFrame()

			_G.ComboPointPlayerFrame.Background:SetTexture(nil)
			for i = 1, #_G.ComboPointPlayerFrame.ComboPoints do
				_G.ComboPointPlayerFrame.ComboPoints[i].PointOff:SetTexture(nil)
			end

		end

		local y2Ofs
		-- skin the EclipseBarFrame/ComboPointPlayerFrame, if required
		if aObj.uCls == "DRUID" then
			skinComboPointPlayerFrame() -- Cat Form
		end

		-- skin the ArcaneChargesFrame, if required
		if aObj.uCls == "MAGE" then
			_G.MageArcaneChargesFrame:DisableDrawLayer("BACKGROUND")
		end

		-- skin the MonkHarmonyBar/MonkStaggerBar, if required
		if aObj.uCls == "MONK" then
			-- MonkHarmonyBarFrame (Windwalker)
			aObj:removeRegions(_G.MonkHarmonyBarFrame, {1, 2})
			for i = 1, #_G.MonkHarmonyBarFrame.LightEnergy do
				_G.MonkHarmonyBarFrame.LightEnergy[i]:DisableDrawLayer("BACKGROUND")
			end
			-- hook this to handle orb 5
			module:SecureHook(_G.MonkPowerBar, "UpdateMaxPower", function(this)
				if this.maxLight == 5 then
					_G.MonkHarmonyBarFrame.LightEnergy[5]:DisableDrawLayer("BACKGROUND")
					aObj:Unhook(_G.MonkPowerBar, "UpdateMaxPower")
				end
			end)
			-- MonkStaggerBar (Brewmaster)
			aObj:removeRegions(_G.MonkStaggerBar, {2, 3, 4, 5, 6}) -- border textures
			aObj:glazeStatusBar(_G.MonkStaggerBar, 0, _G.MonkStaggerBar.DefaultBackground)
			-- extend frame if Brewmaster specialization
			if _G.MonkStaggerBar.class == aObj.uCls
			and _G.MonkStaggerBar.specRestriction == _G.GetSpecialization()
			then
				y2Ofs = 3
			end
		end

		-- skin the PaladinPowerBarFrame, if required
		if aObj.uCls == "PALADIN" then
			_G.PaladinPowerBarFrame:DisableDrawLayer("BACKGROUND")
			_G.PaladinPowerBarFrame.glow:DisableDrawLayer("BACKGROUND")
			y2Ofs = 6
		end

		-- skin the PriestBarFrame/InsanityBarFrame, if required
		if aObj.uCls == "PRIEST" then
			_G.PriestBarFrame:DisableDrawLayer("BACKGROUND")
			for i = 1, #_G.PriestBarFrame.LargeOrbs do
				_G.PriestBarFrame.LargeOrbs[i].Highlight:SetTexture(nil)
			end
			for i = 1, #_G.PriestBarFrame.SmallOrbs do
				_G.PriestBarFrame.SmallOrbs[i].Highlight:SetTexture(nil)
			end
			-- InsanityBarFrame
			_G.InsanityBarFrame.InsanityOn.PortraitOverlay:SetTexture(nil)
			_G.InsanityBarFrame.InsanityOn.TopShadowStay:SetTexture(nil)
		end

		-- skin the ComboPointPlayerFrame, if required
		if aObj.uCls == "ROGUE" then
			skinComboPointPlayerFrame()
		end

		--	skin the TotemFrame, if required
		if aObj.uCls == "SHAMAN" then
			for i = 1, _G.MAX_TOTEMS do
				_G["TotemFrameTotem" .. i .. "Background"]:SetAlpha(0) -- texture is changed
				aObj:getRegion(aObj:getChild(_G["TotemFrameTotem" .. i], 2), 1):SetAlpha(0) -- Totem Border texture
			end
			aObj:moveObject{obj=_G.TotemFrameTotem1, y=lOfs} -- covers level text when active
			y2Ofs = 9
		end

		-- skin the WarlockPowerFrame, if required
		if aObj.uCls == "WARLOCK" then
			_G.WarlockPowerFrame:DisableDrawLayer("BACKGROUND") -- Shard(s) background texture
		end

		-- skin the PlayerFrame, here as preceeding code changes yOfs value
		skinUnitFrame{obj=_G.PlayerFrame, ft=true, x1=35, y1=-5, x2=2, y2=y2Ofs}

		pF = nil

	end

end
local function skinPetF()

	if db.pet
	and not isSkinned["Pet"]
	then
		_G.PetFrameTexture:SetAlpha(0) -- texture file is changed dependant upon in vehicle or not
		_G.PetAttackModeTexture:SetTexture(nil)
		-- status bars
		adjustStatusBarPosn(_G.PetFrameHealthBar, 0)
		aObj:glazeStatusBar(_G.PetFrameHealthBar, 0)
		adjustStatusBarPosn(_G.PetFrameManaBar, -1)
		aObj:glazeStatusBar(_G.PetFrameManaBar, 0, nil, nil, true)
		-- casting bar handled in CastingBar function (UIE1)
		aObj:moveObject{obj=_G.PetFrame, x=21, y=-2} -- align under Player Health/Mana bars

		-- skin the PetFrame
		_G.PetPortrait:SetDrawLayer("BORDER") -- move portrait to BORDER layer, so it is displayed
		skinUnitFrame{obj=_G.PetFrame, ft=true, x1=1}
		-- remove debuff border
		for i = 1, 4 do
			_G["PetFrameDebuff" .. i .. "Border"]:SetTexture(nil)
		end
	end
	if db.petspec
	and aObj.uCls == "HUNTER"
	then
		-- Add pet spec icon to pet frame, if required
		_G.PetFrame.roleIcon = _G.PetFrame:CreateTexture(nil, "artwork")
		_G.PetFrame.roleIcon:SetSize(24, 24)
		_G.PetFrame.roleIcon:SetPoint("left", -10, 0)
		_G.PetFrame.roleIcon:SetTexture([[Interface\LFGFrame\UI-LFG-ICON-ROLES]])
		module:RegisterEvent("PET_SPECIALIZATION_CHANGED", function()
			local curSpec = _G.GetSpecialization(nil, true)
			if curSpec then -- if pet is out
				local role = _G.select(5, _G.GetSpecializationInfo(curSpec, nil, true))
				_G.PetFrame.roleIcon:SetTexCoord(_G.GetTexCoordsForRole(role))
			end
		end)
	end


end
local function skinCommon(frame, adjSB)

	_G[frame .. "Background"]:SetTexture(nil)
	_G[frame .. "TextureFrameTexture"]:SetAlpha(0)
	local fo = _G[frame]
	-- status bars
	aObj:glazeStatusBar(fo.healthbar, 0, nil)
	if adjSB then
		adjustStatusBarPosn(fo.healthbar)
	end
	aObj:glazeStatusBar(fo.manabar, 0, nil, nil, true)
	fo = nil

end
local function addSkinFrame(frame, ft)

	local fo = _G[frame]
	local isBoss = aObj:hasTextInName(fo, "Boss")
	local xOfs1, yOfs1, xOfs2, yOfs2
	if isBoss then
		xOfs1, yOfs1, xOfs2, yOfs2 = -1, -14, -72, 5
	else
		xOfs1, yOfs1, xOfs2, yOfs2 = -2, -5, -35, 0
	end
	skinUnitFrame{obj=fo, ft=ft or true, x1=xOfs1, y1=yOfs1, x2=xOfs2, y2=yOfs2}
	skinCommon(frame, true)
	aObj:removeRegions(_G[frame .. "NumericalThreat"], {3}) -- threat border

	-- move level & highlevel down, so they are more visible
	aObj:moveObject{obj=_G[frame .. "TextureFrameLevelText"], x=2, y=lOfs}

	-- create a texture to show UnitClassification
	fo.ucTex = fo:CreateTexture(nil, "ARTWORK")
	fo.ucTex:SetSize(80, 50)
	fo.ucTex:SetPoint("CENTER", isBoss and 36 or 86, (isBoss and -15 or -22) + lOfs)

	-- casting bar
	aObj:adjHeight{obj=fo.spellbar, adj=2}
	fo.spellbar.Text:ClearAllPoints()
	fo.spellbar.Text:SetPoint("TOP", 0, 3)
	fo.spellbar.Flash:SetAllPoints()
	fo.spellbar.Border:SetAlpha(0) -- texture file is changed dependant upon spell type
	aObj:changeShield(fo.spellbar.BorderShield, fo.spellbar.Icon)
	aObj:glazeStatusBar(fo.spellbar, 0, aObj:getRegion(fo.spellbar, 1), {fo.spellbar.Flash})

	-- PowerBarAlt handled in MainMenuBar function (UIF)

	-- Boss frames don't have a ToT frame
	if not isBoss then
		-- TargetofTarget Frame
		skinUnitFrame{obj=fo.totFrame, x2=4, y2=4}
		skinCommon(frame .. "ToT", true)
		aObj:moveObject{obj=_G[frame .. "ToTHealthBar"], y=-2} -- move HealthBar down to match other frames
	end

	fo, isBoss, xOfs1, yOfs1, xOfs2, yOfs2 = nil, nil, nil, nil, nil, nil

end
local function skinTargetF()

	local function showClassificationTex(cInd, tex)

		if cInd == "worldboss"
		or cInd == "elite"
		then
			tex:SetTexture([[Interface\Tooltips\EliteNameplateIcon]])
		elseif cInd == "rareelite" then
			tex:SetTexture([[Interface\Tooltips\RareEliteNameplateIcon]])
		elseif cInd == "rare" then
			tex:SetTexture([[Interface\AddOns\]] .. aName .. [[\Textures\RareNameplateIcon]])
		else
			tex:SetTexture(nil)
		end

	end

	if db.target
	and not isSkinned["Target"]
	then

		addSkinFrame("TargetFrame")

		-- move level text down, so it is more visible
		module:RawHook("TargetFrame_UpdateLevelTextAnchor", function(this, targetLevel)
			this.levelText:SetPoint("Center", targetLevel == 100 and 61 or 62, -17 + lOfs)
		end, true)

		--Boss Target Frames
		local frame
		for i = 1, _G.MAX_BOSS_FRAMES do
			frame = "Boss" .. i .. "TargetFrame"
			addSkinFrame(frame)
			-- always an Elite mob
			_G[frame].ucTex:SetTexture([[Interface\Tooltips\EliteNameplateIcon]])
		end
		frame = nil

		-- hook this to show/hide the elite texture
		module:SecureHook("TargetFrame_CheckClassification", function(frame, ...)
			if frame == _G.TargetFrame
			or (frame == _G.FocusFrame and db.focus)
			then
				showClassificationTex(_G.UnitClassification(frame.unit), frame.ucTex)
			end
		end)

	end

end
local function skinFocusF()

	if db.focus
	and not isSkinned["Focus"]
	then
		addSkinFrame("FocusFrame", false)
	end

end
local function skinPartyF()

	if db.party
	and not isSkinned["Party"]
	then

		local pMF, pPF
		for i = 1, _G.MAX_PARTY_MEMBERS do
			pMF = "PartyMemberFrame" .. i
			skinUnitFrame{obj=_G[pMF], ft=true, x1=2, y1=5, x2=-1}

			-- aObj:moveObject{obj=_G[pMF .. "Portrait"], y=6}
			-- TODO stop portrait being moved
			_G[pMF .. "Background"]:SetTexture(nil)
			_G[pMF .. "Texture"]:SetAlpha(0) -- texture file is changed dependant upon in vehicle or not
			_G[pMF .. "VehicleTexture"]:SetAlpha(0) -- texture file is changed dependant upon in vehicle or not
			_G[pMF .. "Status"]:SetTexture(nil)
			-- status bars
			aObj:glazeStatusBar(_G[pMF .. "HealthBar"], 0, nil)
			aObj:glazeStatusBar(_G[pMF .. "ManaBar"], 0, nil, nil, true)

			-- PowerBarAlt handled in MainMenuBar function (UIF)

			-- pet frame
			pPF = pMF .. "PetFrame"
			skinUnitFrame{obj=_G[pPF], ft=true, x1=-2, y1=1, y2=1}
			_G[pPF .. "Texture"]:SetAlpha(0) -- texture file is changed dependant upon in vehicle or not
			-- status bar
			aObj:glazeStatusBar(_G[pPF .. "HealthBar"], 0, nil)

		end
		pMF, pPF = nil, nil

		-- PartyMember Buff Tooltip
		_G.PartyMemberBuffTooltip:SetBackdrop(nil)
		skinUnitFrame{obj=_G.PartyMemberBuffTooltip, ofs=-4}

		-- PartyMemberBackground
		aObj:addSkinFrame{obj=_G.PartyMemberBackground, ft=ftype, nb=true, x1=4, y1=2, x2=1, y2=2}

	end

end
local function changeUFOpacity()

	for _, uF in _G.pairs(unitFrames) do
		if _G[uF].sf then
			_G[uF].sf:SetAlpha(db.alpha)
		end
		if _G[uF].totFrame then
			_G[uF].totFrame.sf:SetAlpha(db.alpha)
		end
	end
	for i = 1, _G.MAX_BOSS_FRAMES do
		if _G["Boss" .. i .. "TargetFrame"].sf then
			_G["Boss" .. i .. "TargetFrame"].sf:SetAlpha(db.alpha)
		end
	end
	for i = 1, _G.MAX_PARTY_MEMBERS do
		if _G["PartyMemberFrame" .. i].sf then
			_G["PartyMemberFrame" .. i].sf:SetAlpha(db.alpha)
			_G["PartyMemberFrame" .. i .. "PetFrame"].sf:SetAlpha(db.alpha)
		end
	end
	_G.PartyMemberBuffTooltip.sf:SetAlpha(db.alpha)
	for i = 1, _G.MAX_ARENA_ENEMIES do
		if _G["ArenaEnemyFrame" .. i].sf then
			_G["ArenaEnemyFrame" .. i].sf:SetAlpha(db.alpha)
			_G["ArenaEnemyFrame" .. i .. "PetFrame"].sf:SetAlpha(db.alpha)
		end
	end

end

function module:OnInitialize()

	self.db = aObj.db:RegisterNamespace("UnitFrames", defaults)
	db = self.db.profile

	-- convert any old settings
	if aObj.db.profile.UnitFrames then
		for k, v in _G.pairs(aObj.db.profile.UnitFrames) do
			db[k] = v
		end
		aObj.db.profile.UnitFrames = nil
	end

	 -- disable ourself if required
	if not db.player
	and not db.target
	and not db.focus
	and not db.party
	and not db.pet
	and not db.arena
	then
		self:Disable()
	end

	-- disable ourself if another unitframe addon is loaded
	if _G.IsAddOnLoaded("Perl_Config")
	or _G.IsAddOnLoaded("XPerl")
	then
		self:Disable()
	end

end

function module:OnEnable()

	-- handle in combat as it uses SecureUnitButtonTemplate
	if _G.InCombatLockdown() then
		aObj:add2Table(aObj.oocTab, {self.adjustUnitFrames, {"init"}})
		return
	else
		self:adjustUnitFrames("init")
	end

end

function module:adjustUnitFrames(opt)

	if opt == "init" then
		skinPlayerF()
		skinPetF()
		skinTargetF()
		skinFocusF()
		skinPartyF()
	elseif opt == "player" then
		skinPlayerF()
	elseif opt == "pet"
	or opt == "petspec"
	then
		skinPetF()
	elseif opt == "target" then
		skinTargetF()
	elseif opt == "focus" then
		skinFocusF()
	elseif opt == "party" then
		skinPartyF()
	elseif opt == "alpha" then
		changeUFOpacity()
	end

end

function module:GetOptions()

	local options = {
		type = "group",
		name = aObj.L["Unit Frames"],
		desc = aObj.L["Change the Unit Frames settings"],
		get = function(info) return module.db.profile[info[#info]] end,
		set = function(info, value)
			if not module:IsEnabled() then module:Enable() end
			module.db.profile[info[#info]] = value
			module:adjustUnitFrames(info[#info])
		end,
		args = {
			player = {
				type = "toggle",
				order = 1,
				name = aObj.L["Player"],
				desc = aObj.L["Toggle the skin of the Player UnitFrame"],
			},
			pet = {
				type = "toggle",
				order = 2,
				name = aObj.L["Pet"],
				desc = aObj.L["Toggle the skin of the Pet UnitFrame"],
				set = (aObj.uCls == "HUNTER" or aObj.uCls == "WARLOCK") and function(info, value)
					module.db.profile[info[#info]] = value
					if not value then module.db.profile.petlevel = false end -- disable petlevel when disabled
					module:adjustUnitFrames(info[#info])
				end or nil,
			},
			petspec = (aObj.uCls == "HUNTER") and {
				type = "toggle",
				order = 3,
				name = aObj.L["Pet Spec"],
				desc = aObj.L["Toggle the Pet Spec on the Pet Frame"],
				set = function(info, value)
					module.db.profile[info[#info]] = value
					if value then module.db.profile.pet = true end -- enable pet frame when enabled
					module:adjustUnitFrames(info[#info])
				end,
			} or nil,
			target = {
				type = "toggle",
				order = 4,
				name = aObj.L["Target"],
				desc = aObj.L["Toggle the skin of the Target UnitFrame"],
			},
			focus = {
				type = "toggle",
				order = 5,
				name = aObj.L["Focus"],
				desc = aObj.L["Toggle the skin of the Focus UnitFrame"],
			},
			party = {
				type = "toggle",
				order = 6,
				name = aObj.L["Party"],
				desc = aObj.L["Toggle the skin of the Party UnitFrames"],
			},
			arena = {
				type = "toggle",
				order = 8,
				name = aObj.L["Arena"],
				desc = aObj.L["Toggle the skin of the Arena UnitFrames"],
			},
			alpha = {
				type = "range",
				order = 10,
				width = "double",
				name = aObj.L["UnitFrame Background Opacity"],
				desc = aObj.L["Change Opacity value of the UnitFrames Background"],
				min = 0, max = 1, step = 0.05,
			},
		},
	}
	return options

end

-- this stub is used to trigger Arena frames skinning
function aObj:ArenaUI()

	if db.arena then
		local function skinFrame(fName)
			skinUnitFrame{obj=_G[fName], x1=-3, x2=3, y2=-6}
			_G[fName .. "Background"]:SetTexture(nil)
			_G[fName .. "Texture"]:SetTexture(nil)
			_G[fName .. "Status"]:SetTexture(nil)
			_G[fName .. "SpecBorder"]:SetTexture(nil)
			-- status bars
			aObj:glazeStatusBar(_G[fName .. "HealthBar"], 0)
			aObj:glazeStatusBar(_G[fName .. "ManaBar"], 0)
			-- casting bar
			local cBar = fName .. "CastingBar"
			aObj:adjHeight{obj=_G[cBar], adj=2}
			aObj:moveObject{obj=_G[cBar].Text, y=-1}
			_G[cBar].Flash:SetAllPoints()
			aObj:glazeStatusBar(_G[cBar], 0, aObj:getRegion(_G[cBar], 1), {_G[cBar].Flash})
			cBar = nil
		end
		local aPF
		for i = 1, _G.MAX_ARENA_ENEMIES do
			skinFrame("ArenaPrepFrame" .. i)
			skinFrame("ArenaEnemyFrame" .. i)
			-- pet frame
			aPF = "ArenaEnemyFrame" .. i .. "PetFrame"
			skinUnitFrame{obj=_G[aPF], y1=1, x2=1, y2=2}
			_G[aPF .. "Flash"]:SetTexture(nil)
			_G[aPF .. "Texture"]:SetTexture(nil)
			-- status bar
			aObj:glazeStatusBar(_G[aPF .. "HealthBar"], 0)
			aObj:glazeStatusBar(_G[aPF .. "ManaBar"], 0)
			-- move pet frame
			aObj:moveObject{obj=_G[aPF], x=-17} -- align under ArenaEnemy Health/Mana bars
		end
		aPF = nil
		-- ArenaPrepBackground
		aObj:addSkinFrame{obj=_G.ArenaPrepBackground, ft=ftype, nb=true}
		-- ArenaEnemyBackground
		aObj:addSkinFrame{obj=_G.ArenaEnemyBackground, ft=ftype, nb=true}
	end

end
