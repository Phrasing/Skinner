
function Skinner:LightHeaded()
	if not self.db.profile.QuestLog.skin then return end
	
	self:skinEditBox{obj=LightHeadedSearchBox, regs={9}}
	self:skinScrollBar{obj=LightHeadedScrollFrame}
	self:addSkinFrame{obj=LightHeadedFrame, kfs=true, x1=2, y1=1, x2=2, y2=-2}

	-- Re-parent the close button so it hides when the rest of the frame contents do
	LightHeadedFrame.close:SetParent(LightHeadedFrameSub)

-->>--	Tooltip
	if self.db.profile.Tooltips.skin then
		if self.db.profile.Tooltips.style == 3 then LightHeadedTooltip:SetBackdrop(self.backdrop) end
		self:skinTooltip(LightHeadedTooltip)
	end

end
