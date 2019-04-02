local aName, aObj = ...
if not aObj:isAddonEnabled("PetBattleHUD") then return end
local _G = _G

aObj.addonsToSkin.PetBattleHUD = function(self) -- v 8.0.0.1

	if not (IsAddOnLoaded("Tukui")
	or IsAddOnLoaded("AsphyxiaUI")
	or IsAddOnLoaded("DuffedUI")
	or IsAddOnLoaded("ElvUI"))
	then
		return
	end

	if not _G.PetBattleFrame.sfl then
		_G.C_Timer.After(0.1, function()
			self.addonsToSkin.PetBattleHUD(self)
		end)
		return
	end

	-- Hide Skinner added frames
	_G.PetBattleFrame.sfl:Hide()
	_G.PetBattleFrame.sfm:Hide()
	_G.PetBattleFrame.sfr:Hide()
	_G.PetBattleFrame.BottomFrame.sf:Hide()

end
