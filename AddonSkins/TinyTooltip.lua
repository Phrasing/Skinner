local aName, aObj = ...
if not aObj:isAddonEnabled("TinyTooltip") then return end
local _G = _G

aObj.addonsToSkin.TinyTooltip = function(self) -- v 2.1.8.3

	-- setup textures and colours
	_G.BigTipDB.general.bgfile = self.bdTexName
	_G.BigTipDB.general.background = {self.bColour[1], self.bColour[2], self.bColour[3], self.bColour[4]}
	_G.BigTipDB.general.borderCorner = self.bdbTexName
	_G.BigTipDB.general.borderColor = {self.tbColour[1], self.tbColour[2], self.tbColour[3], self.tbColour[4]}
	_G.BigTipDB.general.statusbarTexture = self.db.profile.StatusBar.texture

	-- update existing tooltips
	local LibEvent = _G.LibStub:GetLibrary("LibEvent.7000")
	for _, tip in pairs(_G.TinyTooltip.tooltips) do

		LibEvent:trigger("tooltip.style.bgfile", tip, _G.BigTipDB.general.bgfile)
		LibEvent:trigger("tooltip.style.background", tip, _G.unpack(_G.BigTipDB.general.background))
		LibEvent:trigger("tooltip.style.border.corner", tip, _G.BigTipDB.general.borderCorner)
		LibEvent:trigger("tooltip.style.border.color", tip, _G.unpack(_G.BigTipDB.general.borderColor))
		LibEvent:trigger("tooltip.statusbar.texture", _G.BigTipDB.general.statusbarTexture)

	end
	LibEvent = nil

	-- find and skin the DropDown Frame
	self.RegisterCallback("TinyTooltip", "UIParent_GetChildren", function(this, child)
		if child:IsObjectType("Frame")
		and child.Bg
		and child.ScrollFrame
		and child.ListFrame
		then
			self:skinSlider{obj=child.ScrollFrame.ScrollBar}
			child:DisableDrawLayer("BORDER")
			self:addSkinFrame{obj=child, ft="a", x2=2}
			self.UnregisterCallback("TinyTooltip", "UIParent_GetChildren")
		end
	end)

	-- register callback to indicate already skinned
	local pCnt = 0
	self.RegisterCallback("TinyTooltip", "IOFPanel_Before_Skinning", function(this, panel)
		if panel.name == "TinyTooltip"
		or panel.parent == "TinyTooltip"
		and not self.iofSkinnedPanels[panel]
		then
			self.iofSkinnedPanels[panel] = true
			pCnt = pCnt + 1
		end
		if pCnt == 6 then
			self.UnregisterCallback("TinyTooltip", "IOFPanel_Before_Skinning")
		end
	end)

	-- skin Config elements
	self.RegisterCallback("TinyTooltip", "IOFPanel_After_Skinning", function(this, panel)
		if panel.name == "TinyTooltip"
		or panel.parent == "TinyTooltip"
		and not panel.sknd
		then
			if panel:IsObjectType("ScrollFrame") then -- Player options are in a scroll child frame
				self:skinSlider{obj=panel.ScrollBar}
				panel = panel:GetScrollChild()
			end
			for _, child in _G.ipairs{panel:GetChildren()} do
				if self:isDropDown(child) then
					self:skinDropDown{obj=child, x2=109}
				elseif child:IsObjectType("Slider") then
					self:skinSlider{obj=child}
				elseif child:IsObjectType("CheckButton") then
					self:skinCheckButton{obj=child}
				elseif child:IsObjectType("EditBox") then
					self:skinEditBox{obj=child, regs={6}} -- 6 is text
				elseif child:IsObjectType("Button") then
					if not child.hasopacity  -- colorpick
					and not child.text -- DIY
					then
						self:skinStdButton{obj=child}
					end
				elseif child:IsObjectType("Frame") then
					if child.anchorbutton then -- anchor
						self:skinDropDown{obj=child.dropdown, x2=109}
						self:skinStdButton{obj=child.anchorbutton}
						self:skinCheckButton{obj=child.checkbox1}
						self:skinCheckButton{obj=child.checkbox2}
					elseif child.slider then -- dropdown slider
						self:skinDropDown{obj=child.dropdown, x2=109}
						self:skinSlider{obj=child.slider}
					elseif child.checkbox then -- element
						child:SetBackdrop(nil)
						self:skinCheckButton{obj=child.checkbox}
						if child.colorpick then -- colorpick
							_G.RaiseFrameLevel(child.colorpick)
							self:skinDropDown{obj=child.colordropdown, noBB=true, x2=109}
							child.colordropdown:SetPoint("LEFT", 200, -3)
						end
						if child.editbox then
							self:skinEditBox{obj=child.editbox, regs={6}} -- 6 is text
						end
						if child.filterdropdown then
							self:skinDropDown{obj=child.filterdropdown, x2=109}
						end
					end
				end
			end
			panel.sknd = true
		end
		if pCnt == 6 then
			self.UnregisterCallback("TinyTooltip", "IOFPanel_After_Skinning")
			pCnt = nil
		end
	end)

end
