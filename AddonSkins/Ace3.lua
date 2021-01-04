-- This is a Framework
local aName, aObj = ...
local _G = _G

aObj.ItemPimper = true -- to stop IP skinning its frame

local AceGUI = _G.LibStub:GetLibrary("AceGUI-3.0", true)
local objectsToSkin = {}
if AceGUI then
	aObj:RawHook(AceGUI, "Create", function(this, objType)
		local obj = aObj.hooks[this].Create(this, objType)
		objectsToSkin[obj] = objType
		return obj
	end, true)
end

-- TODO: change ALL object types to use New Skin Funcs

aObj.libsToSkin["AceGUI-3.0"] = function(self) -- v AceGUI-3.0, 41
	if self.initialized.Ace3 then return end
	self.initialized.Ace3 = true

	local function skinAceGUI(obj, objType)
		local objVer = AceGUI.GetWidgetVersion and AceGUI:GetWidgetVersion(objType) or 0
		-- if not objType:find("CollectMe") then
			-- aObj:Debug("skinAceGUI: [%s, %s, %s]", obj, objType, objVer)
		-- end
		-- if objType:find("TSM") then
			-- aObj:Debug("skinAceGUI: [%s, %s, %s, %s, %s, %s]", obj, objType, objVer, obj.sknd, objType:find("TSM"), obj.sknrTSM)
		-- end
		if obj
		and not obj.sknd
		and not (objType:find("TSM") and obj.sknrTSM) -- check objType as TSM overlays existing objects
		then
			-- aObj:Debug("Ace3 Skinning: [%s, %s]", obj, objType)

			if objType == "Button" then
				if aObj.modBtns then
					-- TODO: handle PowerRaid reskinning buttons, DON't just nil out .sb as gradient is overloaded
					aObj:skinStdButton{obj=obj.frame, x1=5, x2=-5}
					aObj:secureHook(obj.frame, "Disable", function(this, _)
						aObj:clrBtnBdr(this)
					end)
					aObj:secureHook(obj.frame, "Enable", function(this, _)
						aObj:clrBtnBdr(this)
					end)
				end

			elseif objType == "CheckBox" then
				if aObj.modChkBtns then
					-- force creation of button border so check texture can be reparented
					aObj.modUIBtns:addButtonBorder{obj=obj.frame, ofs=-2, relTo=obj.checkbg, reParent={obj.check}, clr="grey"}
					-- hide button border if Radio Button
					aObj:secureHook(obj, "SetType", function(this, type)
						if type == "radio"
						or _G.Round(this.checkbg:GetWidth()) == 16
						then
							this.check:SetParent(this.frame)
							this.frame.sbb:Hide()
						else
							this.check:SetParent(this.frame.sbb)
							this.frame.sbb:Show()
						end
					end)
					obj.checkbg:SetTexture(nil)
				end

			elseif objType == "ColorPicker" then
				obj.alignoffset = 10 -- align to neighbouring DropDowns

			elseif objType == "Dropdown" then
				aObj:skinAceDropdown(obj, nil, 1)

			elseif objType == "Dropdown-Pullout" then
				aObj:skinObject("slider", {obj=obj.slider})
				-- ensure skinframe is behind thumb texture
				obj.slider.sf.SetFrameLevel = _G.nop

			elseif objType == "DropdownGroup"
			or objType == "InlineGroup"
			or objType == "TabGroup"
			then
				aObj:skinObject("frame", {obj=obj.border or obj.content:GetParent(), kfs=true, fb=true, ofs=0})
				if objType == "TabGroup"
				and aObj.modBtns
				then
					aObj:secureHook(obj, "BuildTabs", function(this)
						aObj:skinObject("tabs", {obj=this.frame, tabs=obj.tabs, ignoreSize=true, lod=true, upwards=true, offsets={x1=8, y1=-2, x2=-8, y2=-4}, noCheck=true, track=false})
						aObj:Unhook(this, "BuildTabs")
					end)
					if aObj.isTT then
						aObj:secureHook(obj, "SelectTab", function(this, value)
							for _, tab in _G.ipairs(this.tabs) do
								if tab.value == value then
									aObj:setActiveTab(tab.sf)
								else
									aObj:setInactiveTab(tab.sf)
								end
							end
						end)
					end
				end

			elseif objType == "EditBox"
			or objType == "NumberEditBox"
			then
				aObj:skinObject("editbox", {obj=obj.editbox, ofs=0, x1=-2})
				-- hook this as insets are changed
				aObj:rawHook(obj.editbox, "SetTextInsets", function(this, left, ...)
					return left + 6, ...
				end, true)
				if aObj.modBtns then
					aObj:skinStdButton{obj=obj.button, as=true}
					if objType == "NumberEditBox" then
						aObj:skinStdButton{obj=obj.minus, as=true}
						aObj:skinStdButton{obj=obj.plus, as=true}
					end
				end

			elseif objType == "Frame" then
				-- status frame
				aObj:skinObject("frame", {obj=aObj:getChild(obj.frame, 2), fb=true, ofs=0, x1=2})
				obj.titletext:SetPoint("TOP", obj.frame, "TOP", 0, -6)
				aObj:skinObject("frame", {obj=obj.frame, kfs=true, ofs=0})
				if aObj.modBtns then
					aObj:skinStdButton{obj=aObj:getChild(obj.frame, 1), y1=1}
				end

			elseif objType == "MultiLineEditBox" then
				aObj:skinObject("slider", {obj=obj.scrollBar})
				aObj:removeBackdrop(obj.scrollBG)
				if aObj.modBtns then
					aObj:skinStdButton{obj=obj.button, ofs=0}
					aObj:secureHook(obj.button, "Disable", function(this, _)
						aObj:clrBtnBdr(this)
					end)
					aObj:secureHook(obj.button, "Enable", function(this, _)
						aObj:clrBtnBdr(this)
					end)
				end

			elseif objType == "ScrollFrame" then
				aObj:removeRegions(obj.scrollbar, {2}) -- background texture
				aObj:skinObject("slider", {obj=obj.scrollbar})

			elseif objType == "Slider" then -- horizontal slider with editbox
				aObj:skinObject("editbox", {obj=obj.editbox})
				aObj:skinObject("slider", {obj=obj.slider})

			elseif objType == "TreeGroup" then
				aObj:skinObject("slider", {obj=obj.scrollbar})
				aObj:skinObject("frame", {obj=obj.border, fb=true, ofs=0})
				aObj:skinObject("frame", {obj=obj.treeframe, fb=true, ofs=0})
				if aObj.modBtns then
					-- hook to manage changes to button textures
					aObj:secureHook(obj, "RefreshTree", function(this)
						for _, btn in _G.pairs(this.buttons) do
							if not btn.toggle.sb then
								aObj:skinExpandButton{obj=btn.toggle, onSB=true}
							end
							aObj:checkTex(btn.toggle)
						end
					end)
				end

			elseif objType == "Window" then
				obj.titletext:SetPoint("TOP", obj.frame, "TOP", 0, -6)
				aObj:skinObject("frame", {obj=obj.frame, kfs=true, cb=true, ofs=0})

			elseif objType == "Keybinding" then
				aObj:skinObject("frame", {obj=obj.msgframe})
				if aObj.modBtns then
					aObj:skinStdButton{obj=obj.button, as=true}
				end

			-- handle HybridScrollFrame child (created by HonorSpy [Classic])
			elseif objType == "SimpleGroup" then
				if obj.frame:GetNumChildren() == 2
				and aObj:getChild(obj.frame, 2):IsObjectType("ScrollFrame") then
					aObj:skinObject("slider", {obj=aObj:getChild(obj.frame, 2).scrollBar, rpTex="artwork"})
				end

			-- Snowflake objects (Producer AddOn)
			elseif objType == "SnowflakeEditBox" then
				aObj:skinEditBox{obj=obj.box, regs={9}, noHeight=true}

			elseif objType == "SnowflakeGroup" then
				aObj:applySkin{obj=obj.frame}
				aObj:skinSlider{obj=obj.slider, size=2}
				-- hook this for frame refresh
				aObj:secureHook(obj, "Refresh", function(this)
					this.frame:SetBackdrop(aObj.Backdrop[1])
					this.frame:SetBackdropColor(aObj.bClr:GetRGBA())
					this.frame:SetBackdropBorderColor(aObj.bbClr:GetRGBA())
				end)

			-- Producer objects
			elseif objType == "ProducerHead" then
				aObj:applySkin{obj=obj.frame}
				obj.SetBorder = _G.nop
				if aObj.modBtns then
					aObj:skinCloseButton{obj=obj.close, onSB=true}
				end

			-- ListBox object (AuctionLite)
			elseif objType == "ListBox" then
				for _, child in _G.ipairs{obj.frame:GetChildren()} do
					if child:IsObjectType("ScrollFrame") then
						child:SetBackdrop(nil)
						aObj:skinSlider{obj=_G[child:GetName() .. "ScrollBar"]}
						break
					end
				end
				aObj:applySkin{obj=obj.box, kfs=true}

			-- LibSharedMedia objects
			elseif objType == "LSM30_Background"
			or objType == "LSM30_Border"
			or objType == "LSM30_Font"
			or objType == "LSM30_Sound"
			or objType == "LSM30_Statusbar"
			or objType == "RS_Markers" -- RareScanner
			then
			    if not aObj.db.profile.TexturedDD then
			        aObj:keepFontStrings(obj.frame)
			    else
					obj.alignoffset = 29 -- align to neighbouring DropDowns
					local xOfs1, yOfs1, xOfs2, yOfs2
					if objType == "LSM30_Background"
					or objType == "LSM30_Border"
					then
						xOfs1, yOfs1, xOfs2, yOfs2 = 41, -18, 1, 2
					elseif objType == "LSM30_Font"
					or objType == "LSM30_Sound"
					or objType == "LSM30_Statusbar"
					then
						xOfs1, yOfs1, xOfs2, yOfs2 = 0, -19, 1, 1
					elseif objType == "RS_Markers" then
						xOfs1, yOfs1, xOfs2, yOfs2 = 0, -18, 1, 0
					end
					aObj:skinObject("dropdown", {obj=obj.frame, regions={2, 3, 4}, rp=true, x1=xOfs1, y1=yOfs1, x2=xOfs2, y2=yOfs2})
					aObj:secureHook(obj, "SetDisabled", function(this, disabled)
						aObj:checkDisabledDD(this.frame, disabled)
					end)
					aObj:secureHookScript(obj.frame.dropButton, "OnClick", function(this)
						if obj.dropdown then
							if not obj.dropdown.sf then
								aObj:skinObject("slider", {obj=obj.dropdown.slider})
								aObj:skinObject("frame", {obj=obj.dropdown, ofs=0})
								_G.RaiseFrameLevel(obj.dropdown)
							else
								aObj:removeBackdrop(obj.dropdown)
							end
						end
					end)
				end

			-- WeakAuras objects
			elseif objType == "WeakAurasDisplayButton" then
				-- aObj:skinEditBox{obj=obj.renamebox, regs={9}, noHeight=true}
				-- obj.renamebox:SetHeight(18)
				aObj:skinObject("editbox", {obj=obj.renamebox})
				obj.background:SetTexture(nil)
				if aObj.modBtns then
					aObj:skinExpandButton{obj=obj.expand, onSB=true}
					aObj:secureHook(obj.expand, "SetNormalTexture", function(this, nTex)
						aObj:checkTex{obj=this, nTex=nTex}
					end)
				end
				if aObj.modBtnBs then
					aObj:addButtonBorder{obj=obj.frame, relTo=obj.frame.icon}
					-- make sure button border frame is visible
					aObj:secureHook(obj, "SetIcon", function(this, icon)
						_G.RaiseFrameLevel(this.frame.sbb)
					end)
					aObj:addButtonBorder{obj=obj.group, es=10, ofs=0}
				end

			elseif objType == "WeakAurasLoadedHeaderButton" then
				obj.frame.background:SetTexture(nil)
				if aObj.modBtns then
					aObj:skinExpandButton{obj=obj.expand, onSB=true}
					aObj:secureHook(obj.expand, "SetNormalTexture", function(this, nTex)
						aObj:checkTex{obj=this, nTex=nTex}
					end)
				end

			elseif objType == "WeakAurasNewButton" then
				obj.background:SetTexture(nil)
				if aObj.modBtnBs then
					aObj:addButtonBorder{obj=obj.frame, relTo=obj.frame.icon}
					-- make sure button border frame is visible
					aObj:secureHook(obj, "SetIcon", function(this, icon)
						_G.RaiseFrameLevel(this.frame.sbb)
					end)
				end

			elseif objType == "WeakAurasNewHeaderButton" then
				obj.frame.background:SetTexture(nil)

			elseif objType == "WeakAurasSortedDropdown" then
				aObj:skinAceDropdown(obj, nil, 1)

			elseif objType == "WeakAurasMultiLineEditBox" then
				aObj:skinObject("frame", {obj=obj.scrollBG, kfs=true, fb=true})
				if aObj.modBtns then
					-- wait for the extra buttons to be created
					_G.C_Timer.After(0.05, function()
						for _, btn in _G.pairs(obj.extraButtons) do
							aObj:skinStdButton{obj=btn}
						end
					end)
				end

			elseif objType == "WeakAurasSnippetButton" then
				aObj:skinObject("editbox", {obj=obj.renameEditBox, ofs=3})
				if aObj.modBtnBs then
					aObj:addButtonBorder{obj=obj.deleteButton, es=10, ofs=-1, x1=2.5, y2=3.5}
				end

            -- TradeSkillMaster (TSM) objects
	        elseif objType == "TSMButton" then
	           obj.btn:SetBackdrop(nil)
				if aObj.modBtns then
					aObj:skinStdButton{obj=obj.btn, as=true} -- just skin it otherwise text is hidden
				end
	             obj.sknrTSM = true

 			elseif objType == "TSMDropdown" then
 				aObj:skinAceDropdown(obj, 0, 0)
                 obj.sknrTSM = true

 			elseif objType == "TSMDropdown-Pullout" then
 				aObj:applySkin{obj=obj.frame}
                 obj.sknrTSM = true

			elseif objType == "TSMEditBox" then
				if aObj.modBtns then
					aObj:skinStdButton{obj=obj.button, as=true}
				end
				 obj.sknrTSM = true

	        elseif objType == "TSMInlineGroup"
	        then
	            obj.HideBorder = _G.nop
	            obj.SetBackdrop = _G.nop
	            obj.border:Hide()
	            obj.titletext:ClearAllPoints()
	            obj.titletext:SetPoint("TOPLEFT", 10, -6)
	            obj.titletext:SetPoint("TOPRIGHT", -14, -6)
	            aObj:applySkin{obj=obj.frame}
	            obj.sknrTSM = true

            elseif objType == "TSMMacroButton"
            or objType == "TSMFastDestroyButton"
            then
                obj.frame:SetBackdrop(nil)
				if aObj.modBtns then
					aObj:skinStdButton{obj=obj.frame}
				end
                obj.sknrTSM = true

            elseif objType == "TSMMainFrame" then
                aObj:applySkin{obj=obj.frame}
                aObj:getChild(obj.frame, 1):SetBackdrop(nil)
				if aObj.modBtns then
					aObj:skinStdButton{obj=aObj:getChild(obj.frame, 1), nc=true, ofs=2} -- close button
				end
                obj.sknrTSM = true

            elseif objType == "TSMScrollingTable" then
				aObj:addSkinFrame{obj=obj.frame, ft="a", nb=true, ofs=2}
                obj.sknrTSM = true

            elseif objType == "TSMSelectionList" then
                aObj:applySkin{obj=obj.leftFrame}
                aObj:skinSlider{obj=obj.leftScrollFrame._scrollbar}
                aObj:applySkin{obj=obj.rightFrame}
                aObj:skinSlider{obj=obj.rightScrollFrame._scrollbar}
                obj.sknrTSM = true

            elseif objType == "TSMTabGroup"
            then
                aObj:applySkin{obj=obj.content:GetParent()}
                obj.sknrTSM = true

            elseif objType == "TSMTreeGroup" then
                aObj:applySkin{obj=obj.border}
                aObj:applySkin{obj=obj.treeframe}
                obj.sknrTSM = true

            elseif objType == "TSMWindow" then
                aObj:applySkin{obj=obj.frame, kfs=true}
               obj.titletext:SetPoint("TOP", obj.frame, "TOP", 0, -6)
				if aObj.modBtns then
					aObj:skinCloseButton{obj=obj.closebutton}
				end
                 obj.sknrTSM = true

			-- AuctionMaster objects
			elseif objType == "ScrollableSimpleHTML" then
				aObj:skinSlider{obj=obj.scrollFrame.ScrollBar}
			elseif objType == "EditDropdown" then
				if aObj.modBtnBs then
					aObj:addButtonBorder{obj=obj.button, es=12, ofs=-2}
				end

			-- CompactMissions objects
			elseif objType == "Follower" then
			elseif objType == "Mission" then
				aObj:applySkin{obj=obj.frame, kfs=true}
				if aObj.modBtns then
					aObj:skinStdButton{obj=obj.startbutton, as=true}
				end

			-- GarrisonMissionCommander/OrderHallCommander/ChampionCommander objects
			elseif objType == "GMCLayer" then
				aObj:addSkinFrame{obj=obj.frame, ft="a", nb=true, x1=-4, x2=4, y2=-4}
			elseif objType == "GMCMissionButton"
			or objType == "GMCSlimMissionButton"
			or objType == "OHCMissionButton"
			or objType == "BFAMissionButton"
			then
				obj.frame:DisableDrawLayer("BACKGROUND")
				obj.frame:DisableDrawLayer("BORDER")
				-- extend the top & bottom highlight texture
				obj.frame.HighlightT:ClearAllPoints()
				obj.frame.HighlightT:SetPoint("TOPLEFT", 0, 4)
				obj.frame.HighlightT:SetPoint("TOPRIGHT", 0, 4)
		        obj.frame.HighlightB:ClearAllPoints()
		        obj.frame.HighlightB:SetPoint("BOTTOMLEFT", 0, -4)
		        obj.frame.HighlightB:SetPoint("BOTTOMRIGHT", 0, -4)
				aObj:removeRegions(obj.frame, {13, 14, 23, 24, 25, 26}) -- LocBG, RareOverlay, Highlight corners
				if aObj.modBtnBs then
					aObj:secureHook(obj, "SetMission", function(this)
						for _, reward in _G.pairs(this.frame.Rewards) do
							aObj:removeRegions(reward, {1}) -- rewards shadow
							if aObj.modBtns then
								aObj:addButtonBorder{obj=reward, relTo=reward.Icon, reParent={reward.Quantity}}
							end
						end
					end)
				end

			-- GarrisonCommander objects
			elseif objType == "GMCGUIContainer" then
				obj.frame.GarrCorners:DisableDrawLayer("BACKGROUND")
				aObj:addSkinFrame{obj=obj.frame, ft="a", kfs=true, ofs=2, x2=1}
				-- if aObj.modBtns then
				-- 	aObj:skinCloseButton{obj=obj.frame.CloseButton}
				-- end

			-- OrderHallCommander/ChampionCommander objects
			elseif objType == "OHCGUIContainer"
			or objType == "BFAGUIContainer"
			then
				aObj:addSkinFrame{obj=obj.frame, ft="a", kfs=true, nb=true}
				if aObj.modBtns then
					aObj:skinCloseButton{obj=obj.frame.Close}
				end

			-- quantify
			elseif objType == "QuantifyInlineGroup" then
				aObj:applySkin{obj=obj.border, kfs=true}

			-- AdiBags
			elseif objType == "ItemList" then
				aObj:addSkinFrame{obj=obj.content:GetParent(), kfs=true, nb=true}

			-- ignore these types for now
			elseif objType == "BlizOptionsGroup"
			or objType == "Dropdown-Item-Execute"
			or objType == "Dropdown-Item-Header"
			or objType == "Dropdown-Item-Menu"
			or objType == "Dropdown-Item-Separator"
			or objType == "Dropdown-Item-Toggle"
			or objType == "Label"
			or objType == "Heading"
			or objType == "Icon"
			or objType == "InteractiveLabel"
			-- Snowflake objects
			or objType == "SnowflakeButton"
			or objType == "SnowflakeEscape"
			or objType == "SnowflakePlain"
			or objType == "SnowflakeTitle"
			-- LSM30 objects
			or objType == "LSM30_Statusbar_Overlay"
			or objType == "LSM30_Statusbar_Overlay-Item-Toggle"
			-- WeakAuras objects
			or objType == "WeakAurasExpand"
			or objType == "WeakAurasExpandAnchor"
			or objType == "WeakAurasExpandSmall"
			or objType == "WeakAurasIcon"
			or objType == "WeakAurasIconButton"
			or objType == "WeakAurasImportButton"
			or objType == "WeakAurasInlineGroup"
			or objType == "WeakAurasTemplateGroup"
			or objType == "WeakAurasTextureButton"
			or objType == "WeakAurasToolbarButton"
			or objType == "WeakAurasTreeGroup"
			or objType == "WeakAurasTwoColumnDropdown"
			-- ReagentRestocker object
			or objType == "DragDropTarget"
			-- TradeSkillMaster objects
			or objType == "TSMCheckBox"
			or objType == "TSMColorPicker"
			or objType == "TSMDropdown-Item-Execute"
			or objType == "TSMDropdown-Item-Toggle"
			or objType == "TSMImage"
			or objType == "TSMLabel"
			or objType == "TSMMultiLabel"
			or objType == "TSMScrollFrame"
			or objType == "TSMSimpleGroup"
			or objType == "TSMSlider"
			or objType == "TSMGroupBox"
			or objType == "TSMInteractiveLabel"
			-- CollectMe objects
			or objType == "CollectMeLabel"
			-- GarrisonMissionCommander objects
			or objType == "GCMCList"
			-- OrderHallCommander objects
			or objType == "OHCMissionsList"
			-- ChampionCommander objects
			or objType == "BFAMissionsList"
			-- ElvUI
			or objType == "ColorPicker-ElvUI"
			-- DDI [Dropdown ITems (used by oRA3)]
			or objType == "DDI-Statusbar"
			or objType == "DDI-Font"
			-- quantify
			or objType == "QuantifyContainerWrapper"
			or objType == "QuantifyInlineGroup"
			-- AdiBags
			or objType == "ItemListElement"
			then
				-- aObj:Debug("Ignoring: [%s]", objType)
			-- any other types
			else
				aObj:Debug("AceGUI, unmatched type - %s", objType)
			end
		end
	end

	if self:IsHooked(AceGUI, "Create") then
		self:Unhook(AceGUI, "Create")
	end

	self:RawHook(AceGUI, "Create", function(this, objType)
		local obj = self.hooks[this].Create(this, objType)
		if not objectsToSkin[obj] then skinAceGUI(obj, objType) end -- Bugfix: ignore objects awaiting skinning
		return obj
	end, true)

	-- skin any objects created earlier
	for obj in _G.pairs(objectsToSkin) do
		skinAceGUI(obj, objectsToSkin[obj])
	end
	_G.wipe(objectsToSkin)

end

-- hook this to capture the creation of AceConfig IOF panels
aObj.iofSkinnedPanels = {}
aObj.ACD = _G.LibStub:GetLibrary("AceConfigDialog-3.0", true)
if aObj.ACD then
	-- hook this to manage IOF panels that have already been skinned by Ace3 skin
	aObj:RawHook(aObj.ACD, "AddToBlizOptions", function(this, ...)
		local frame = aObj.hooks[this].AddToBlizOptions(this, ...)
		aObj.iofSkinnedPanels[frame] = true
		return frame
	end, true)
	aObj:SecureHookScript(aObj.ACD.popup, "OnShow", function(this)
		if not aObj.isClsc then
			aObj:keepFontStrings(aObj:getChild(this, 1))
		end
		aObj:addSkinFrame{obj=this, ft="a", kfs=true, nb=true, ofs=-4}
		if aObj.modBtnBs then
			aObj:skinStdButton{obj=this.accept}
			aObj:skinStdButton{obj=this.cancel}
		end

		aObj:Unhook(this, "OnShow")
	end)
end
