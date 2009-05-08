
function Skinner:oRA3()

	-- hook this to manage textured tabs
	if self.isTT then
		self:SecureHook(oRA3, "SelectPanel", function(this, name)
			for i = 1, #oRA3.panels do
				local tabSF = self.skinFrame[_G["oRA3FrameTab"..i]]
				if i == oRA3Frame.selectedTab then
					self:setActiveTab(tabSF)
				else
					self:setInactiveTab(tabSF)
				end
			end
		end)
	end
	
	self:addSkinFrame{obj=oRA3Frame, kfs=true, bg=true, x1=10 , y1=1, x2=1, y2=-3}

	if not oRA3.db.profile.open then oRA3Frame.title:SetAlpha(0) end
	-- show the title when opened
	self:SecureHook(oRA3FrameSub, "Show", function()
		oRA3Frame.title:SetAlpha(1)
	end)
	-- hide the title when closed
	self:SecureHook(oRA3FrameSub, "Hide", function()
		oRA3Frame.title:SetAlpha(0)
	end)
	
-->>-- SubFrame	
	oRA3FrameSub:SetBackdrop(nil)
	self:skinScrollBar{obj=oRA3ScrollFrame}
	oRA3ScrollFrameBottom:SetBackdrop(nil)
	oRA3ScrollFrameTop:SetBackdrop(nil)
	
-->>-- ScrollHeaders
	local shCnt = 4
	self:skinFFColHeads("oRA3ScrollHeader", shCnt)
	self:SecureHook(oRA3, "CreateScrollHeader", function()
		shCnt = shCnt + 1
		local sh = _G["oRA3ScrollHeader"..shCnt]
		self:keepRegions(sh, {4, 5}) -- N.B 4 is text, 5 is highlight
		self:addSkinFrame{obj=sh}
	end)
	
-->>-- Tabs
	for i = 1, #oRA3.panels do
		local tabName = _G["oRA3FrameTab"..i]
		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is text, 8 is highlight
		self:addSkinFrame{obj=tabName, noBdr=self.isTT, x1=6, x2=-6, y2=2}
		local tabSF = self.skinFrame[tabName]
		if i == 1 then
			self:moveObject{obj=tabName, y=2}
			if self.isTT then self:setActiveTab(tabSF) end
		else
			if self.isTT then self:setInactiveTab(tabSF) end
		end
	end
	
end
