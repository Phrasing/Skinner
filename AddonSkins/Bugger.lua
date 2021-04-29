local _, aObj = ...
if not aObj:isAddonEnabled("Bugger") then return end
local _G = _G

aObj.addonsToSkin.Bugger = function(self) -- v 8.0.0.0

	self:SecureHook(_G.Bugger, "SetupFrame", function(this)
		self:skinObject("slider", {obj=this.scrollFrame.ScrollBar})
		self:skinObject("tabs", {obj=this.frame, tabs=this.tabs, selectedTab=3, lod=self.isTT and true, track=false})
		if self.isTT then
			self:SecureHook(this, "ShowSession", function(this, session)
				for _, tab in _G.pairs(this.tabs) do
					if tab.session == session then
						self:setActiveTab(tab.sf)
					else
						self:setInactiveTab(tab.sf)
					end
				end
			end)
		end
		self:skinObject("frame", {obj=this.frame, kfs=true, ofs=-1, y1=-2, y2=0})
		if self.modBtns then
			self:skinCloseButton{obj=_G[this.frame:GetName() .. "Close"]}
			self:skinStdButton{obj=this.reload}
			self:skinStdButton{obj=this.clear}
			self:skinStdButton{obj=this.showLocals}
			self:skinStdButton{obj=this.next}
			self:skinStdButton{obj=this.previous}
			self:SecureHook(this, "ShowError", function(this, _)
				self:clrBtnBdr(this.showLocals)
				self:clrBtnBdr(this.previous)
				self:clrBtnBdr(this.next)
				self:clrBtnBdr(this.clear)
			end)
		end

		self:Unhook(_G.Bugger, "SetupFrame")
	end)

end
