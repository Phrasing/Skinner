--This Skin is for the Original Bagnon/Banknon Addon found here: http://wowui.incgamers.com/ui.php?id=4060
-- and here http://wow.curse.com/downloads/details/2090/
-- and also for the Bagnon Addon formerly known as vBagnon, found here: http://wow-en.curse-gaming.com/files/details/2090/vbagnon/ or here http://wowui.incgamers.com/ui.php?id=3197

-- Updated 26.06.09
-- vBagnon no longer is supported
-- Now supports the newest version found on Curse

function Skinner:Bagnon(LoD)
	if not self.db.profile.ContainerFrames or self.initialized.Bagnon then return end
	self.initialized.Bagnon = true

	--	if Addon is LoD then it's the original one
	if LoD then
		self:applySkin(Bagnon)
		-- hook these to stop the Backdrop colours from being changed
		self:RawHook(Bagnon, "SetBackdropColor", function() end, true)
		self:RawHook(Bagnon, "SetBackdropBorderColor", function() end, true)
		
	-- it's the newest version from Curse	
	else
		local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
		-- skin the bag frame
		self:RawHook(Bagnon.Frame, "New", function(this, frameID)
			self:Debug("Bagnon.Frame_New: [%s, %s]", this, frameID)
			local frame = self.hooks[Bagnon.Frame].New(this, frameID)
			self:applySkin(frame)
			self:RawHook(frame, "SetBackdropColor", function() end, true)
			self:RawHook(frame, "SetBackdropBorderColor", function() end, true)
			return frame
		end)
		-- skin the Search EditBox
		self:RawHook(Bagnon.SearchFrame, "New", function(this, ...)
			local eb = self.hooks[Bagnon.SearchFrame].New(this, ...)
			self:skinEditBox{obj=eb, regs={9}}
			return eb
		end)

	end

end

function Skinner:Banknon()
	if not self.db.profile.ContainerFrames then return end

	self:applySkin(Banknon)
	-- hook these to stop the Backdrop colours from being changed
	self:RawHook(Banknon, "SetBackdropColor", function() end, true)
	self:RawHook(Banknon, "SetBackdropBorderColor", function() end, true)

end

function Skinner:Bagnon_Forever()
	if not self.db.profile.ContainerFrames then return end

	self:SecureHook(BagnonDB, "ToggleDropdown", function(this)
		self:keepFontStrings(BagnonDBCharSelect)
		self:Unhook(BagnonDB, "ToggleDropdown")
	end)

end

function Skinner:Bagnon_Options()

	self:applySkin(BagnonRightClickMenu)
	self:skinDropDown(BagnonRightClickMenuPanelSelector)

end
