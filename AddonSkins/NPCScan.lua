local aName, aObj = ...
if not aObj:isAddonEnabled("NPCScan") then return end
local _G = _G

aObj.addonsToSkin.NPCScan = function(self) -- v 7.3.5.3

	local function skinTargetButton(event, ...)
		-- aObj:Debug("skinTargetButton fired: [%s, %s]", event, ...)

		-- handle inCombat
		if _G.InCombatLockdown() then
			aObj:add2Table(aObj.oocTab, {skinTargetButton, {"OoC"}})
			return
		end

		-- if called after combat wait for queued Target button to be created
		if event == "OoC" then
			_G.C_Timer.After(0.1, function() skinTargetButton() end)
		end

		aObj.RegisterCallback("NPCScan", "UIParent_GetChildren", function(this, child)
			if child.DismissButton
			and child.killedTextureFrame
			then
				child.Background:SetTexture(nil)
				child.Background.SetTexture = _G.nop
				if child.Background2 then
					child.Background2:SetTexture(nil)
					child.Background2.SetTexture = _G.nop
					child.Background3:SetTexture(nil)
					child.Background3.SetTexture = _G.nop
				end
				if child.DismissButton:GetNormalTexture() then
					child.DismissButton:GetNormalTexture():SetTexture(nil)
					child.DismissButton:GetPushedTexture():SetTexture(nil)
				end
				aObj:skinCloseButton{obj=child.DismissButton, font=aObj.fontSBX, aso={bd=5, bba=0}, onSB=true, storeOnParent=true}
				local xOfs, yOfs
				if _G.Round(child:GetHeight()) == 119 then -- Elite/RareElite
					xOfs = 38
					yOfs = 18
				elseif _G.Round(child:GetHeight()) == 96 then -- Rare
					xOfs = 8
					yOfs = 10
				else -- Normal
					xOfs = 10
					yOfs = 9
				end
				aObj:addSkinFrame{obj=child, ft="a", kfs=true, nb=true, sec=true, x1=xOfs, y1=-yOfs, x2=-9, y2=yOfs}
				xOfs, yOfs = nil, nil
			end
		end)
		aObj:scanUIParentsChildren()

	end

	-- Register to know when Targeting buttons are used
	self:RegisterMessage("NPCScan_DetectedNPC", skinTargetButton)
	self:RegisterMessage("NPCScan_TargetButtonRequestDeactivate", skinTargetButton)
	self:RegisterMessage("NPCScan_TargetButtonNeedsReclassified", skinTargetButton)

		-- skin the anchor frame
	local function skinAnchor(cbName, addonName)
		if addonName == "NPCScan" then
			aObj.RegisterCallback("NPCScan_Options", "UIParent_GetChildren", function(this, child)
				if child:GetName() == nil
				and _G.Round(child:GetWidth()) == 302
				and _G.Round(child:GetHeight()) == 61 -- N.B. NOT 119 as defined in code
				then
					aObj:skinCloseButton{obj=aObj:getChild(child, 1), font=aObj.fontSBX, aso={bd=5, bba=0}, onSB=true, storeOnParent=true}
					aObj:addSkinFrame{obj=child, ft="a", kfs=true, nb=true}
					aObj.UnregisterCallback("NPCScan_Options", "UIParent_GetChildren")
				end
			end)
			aObj:scanUIParentsChildren()
		end
	end

	-- Register to know when Show/Hide Anchor button pressed
	self.ACR.RegisterCallback(self, "ConfigTableChange", skinAnchor)

end
