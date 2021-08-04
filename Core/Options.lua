local aName, aObj = ...

local _G = _G

aObj.SetupDefaults = function(self)

	local defaults = {
		profile = {
		-- General
			Warnings                   = true,
			Errors                     = true,
			MinimapIcon                = {hide = false, minimapPos = 210, radius = 80},
			FrameBorders               = true,
			UIDropDownMenu             = true,
			-- Tab and DropDown Texture settings
			TexturedTab                = false,
			TexturedDD                 = false,
			TabDDFile                  = "None",
			TabDDTexture               = aName .. " Inactive Tab",
			Delay                      = {Init = 0.5, Addons = 0.5},
			FadeHeight                 = {enable = false, value = 500, force = false},
			StatusBar                  = {texture = "Blizzard", r = 0, g = 0.5, b = 0.5, a = 0.5},
		-- Backdrop Settings
			BdDefault                  = true,
			BdFile                     = "None",
			BdTexture                  = "Blizzard ChatFrame Background",
			BdTileSize                 = 16,
			BdEdgeFile                 = "None",
			BdBorderTexture            = "Blizzard Tooltip",
			BdEdgeSize                 = 16,
			BdInset                    = 4,
		-- Background Texture settings
			BgUseTex                   = false,
			BgFile                     = "None",
			BgTexture                  = "None",
			BgTile                     = false,
			LFGTexture                 = false,
		-- Colours
			ClassClrBd                 = false,
			ClassClrBg                 = false,
			ClassClrGr                 = false,
			ClassClrTT                 = false,
			TooltipBorder              = _G.CreateColor(0.5, 0.5, 0.5, 1),
			Backdrop                   = _G.CreateColor(0, 0, 0, 0.9),
			BackdropBorder             = _G.CreateColor(0.5, 0.5, 0.5, 1),
			SliderBorder               = _G.CreateColor(0.2, 0.2, 0.2, 1),
			HeadText                   = _G.CreateColor(0.8, 0.8, 0, 1),
			BodyText                   = _G.CreateColor(0.6, 0.6, 0, 1),
			IgnoredText                = _G.CreateColor(0.5, 0.5, 0, 1),
			GradientMin                = _G.CreateColor(0.1, 0.1, 0.1, 0),
			GradientMax                = _G.CreateColor(0.25, 0.25, 0.25, 1),
			BagginsBBC                 = _G.IsAddOnLoaded("Baggins") and _G.CreateColor(0.5, 0.5, 0.5, 1),
		-- Gradient
			Gradient                   = {enable = true, invert = false, rotate = false, char = true, ui = true, npc = true, skinner = true, addon = true, texture = "Blizzard ChatFrame Background"},
		-- Modules (populated below)
		-- NPC Frames
			DisableAllNPC              = false,
			AlliedRacesUI              = true,
			AuctionHouseUI             = true,
			AzeriteRespecUI            = true,
			BankFrame                  = true,
			BlackMarketUI              = true,
			ChromieTimeUI              = true,
			CovenantRenown             = true,
			CovenantSanctum            = true,
			CovenantPreviewUI          = true,
			FlightMap                  = true,
			GossipFrame                = true,
			GuildRegistrar             = true,
			ItemInteractionUI          = true,
			ItemUpgradeUI              = true,
			MerchantFrame              = true,
			NewPlayerExperienceGuide   = true,
			Petition                   = true,
			PetStableFrame             = true,
			QuestFrame                 = true,
			QuestInfo                  = true,
			RuneForgeUI                = true,
			Tabard                     = true,
			TaxiFrame                  = true,
			TrainerUI                  = true,
			VoidStorageUI              = true,
		-- Player Frames
			DisableAllP                = false,
			AchievementUI              = {skin = true, style = 2},
			ArchaeologyUI              = true,
			ArtifactUI                 = true,
			AzeriteEssenceUI           = true,
			AzeriteUI                  = true,
			Buffs                      = true,
			CastingBar                 = {skin = true, glaze = true},
			CharacterFrames            = true,
			Collections                = true, -- (Mounts, Pets, Toys, Heirlooms & Appearances)
			Communities                = true,
			CompactFrames              = true,
			ContainerFrames            = {skin = true, fheight = 100},
			DressUpFrame               = true,
			EncounterJournal           = true,
			EquipmentFlyout            = true,
			FriendsFrame               = true,
			GuildControlUI             = true,
			GuildUI                    = true,
			GuildInvite                = true,
			InspectUI                  = true,
			ItemSocketingUI            = true,
			LookingForGuildUI          = true,
			LootFrames                 = {skin = true, size = 1},
			LootHistory                = true,
			MirrorTimers               = {skin = true, glaze = true},
			ObjectiveTracker           = {skin = false, popups = true, headers=true, animapowers=true},
			OverrideActionBar          = true, -- a.k.a. VehicleUI
			PVPUI                      = true,
			RaidUI                     = true,
			ReadyCheck                 = true,
			RolePollPopup              = true,
			SpellBookFrame             = true,
			StackSplit                 = true,
			TalentUI                   = true,
			TradeFrame                 = true,
			TradeSkillUI               = true,
			VehicleMenuBar             = true,
		-- UI Frames
			DisableAllUI               = false,
			AddonList                  = true,
			AdventureMap               = true,
			AlertFrames                = true,
			AnimaDiversionUI           = true,
			AutoComplete               = true,
			AzeriteItemToasts          = true,
			BattlefieldMap             = true,
			BindingUI                  = true,
			BNFrames                   = true,
			Calendar                   = true,
			ChallengesUI               = true,
			CharacterCustomize         = true,
			ChatBubbles                = {skin = true, alpha = 0.45},
			ChatButtons                = true,
			ChatChannelsUI             = true,
			ChatConfig                 = true,
			ChatEditBox                = {skin = true, style = 3},
			ChatFrames                 = false, -- (inc ChatMinimizedFrames)
			ChatMenus                  = true,
			ChatTabs                   = false, -- (inc. ChatTemporaryWindow)
			ChatTabsFade               = true,
			CinematicFrame             = true,
			ClassTrial                 = true,
			CoinPickup                 = true,
			Colours                    = true,
			Console                    = true,
			Contribution               = true,
			CombatLogQBF               = false,
			CovenantToasts             = true,
			DeathRecap                 = true,
			DebugTools                 = true,
			DestinyFrame               = true,
			EventToastManager          = true,
			EventTrace                 = not aObj.isClscERA and true,
			GarrisonUI                 = true,
			GhostFrame                 = true,
			GMChatUI                   = true,
			GuildBankUI                = true,
			HelpFrame                  = true,
			HelpTip                    = true,
			InterfaceOptions           = true,
			IslandsPartyPoseUI         = true,
			IslandsQueueUI             = true,
			ItemText                   = true,
			LevelUpDisplay             = true,
			LossOfControl              = true,
			MacroUI                    = true,
			MailFrame                  = true,
			MainMenuBar                = {skin = true, glazesb = true, extraab=true, altpowerbar=true},
			MenuFrames                 = true, -- (inc. MacroUI & BindingUI)
			Minimap                    = {skin = false, gloss = false},
			MinimapButtons             = {skin = false, style = false},
			MovePad                    = true,
			MovieFrame                 = true,
			Nameplates                 = true,
			NavigationBar              = true,
			NewPlayerExperience        = true,
			ObliterumUI                = true,
			OrderHallUI                = true,
			PetBattleUI                = true,
			PlayerChoice               = true,
			ProductChoiceFrame         = true,
			PTRFeedback                = true,
			PVEFrame                   = true, -- (inc, LFD, LFG, RaidFinder) a.k.a. GroupFinder
			PVPMatch                   = true,
			QuestMap                   = true,
			QuestSession               = true, -- a.k.a. Party Sync
			QueueStatusFrame           = true,
			RaidFrame                  = true, -- (inc. LFR)
			SharedBasicControls        = true,
			ScrappingMachineUI         = true,
			SplashFrame                = true,
			StaticPopups               = true,
			Soulbinds                  = true,
			SubscriptionInterstitialUI = true,
			SystemOptions              = true,
			TalkingHeadUI              = true,
			TextToSpeechFrame          = true,
			TimeManager                = true,
			Tooltips                   = {skin = true, style = 1, glazesb = true, border = 1},
			TorghastLevelPicker        = true,
			Tutorial                   = true,
			UIWidgets                  = true,
			UnitPopup                  = true,
			WarfrontsPartyPoseUI       = true,
			WeeklyRewards              = true,
			WorldMap                   = {skin = true, size = 1},
			ZoneAbility                = true,
		-- Disabled Skins
			DisableAllAS               = false,
			DisabledSkins              = {},
		-- Profiles (populated below)

		},
	}

	if not self.db then
		self.db = _G.LibStub:GetLibrary("AceDB-3.0", true):New(aName .. "DB", defaults, "Default")
	end

end

aObj.SetupOptions = function(self)

	local db = self.db.profile
	local dflts = self.db.defaults.profile

	local function reskinIOFBackdrop()
		-- show changes by reskinning the Interface Options Frame with the new settings
		self:setupBackdrop()
		_G.InterfaceOptionsFrame.sf:SetBackdrop(self.backdrop)
		_G.InterfaceOptionsFrame.sf:SetBackdropColor(aObj.bClr:GetRGBA())
		_G.InterfaceOptionsFrame.sf:SetBackdropBorderColor(aObj.bbClr:GetRGBA())
	end

	self.optTables = {

		General = {
			type = "group",
			name = aName,
			get = function(info) return db[info[#info]] end,
			set = function(info, value) db[info[#info]] = value end,
			args = {
				desc = {
					type = "description",
					order = 1,
					name = self.L["UI Enhancement"]  .. " - "..(_G.GetAddOnMetadata(aName, "X-Curse-Packaged-Version") or _G.GetAddOnMetadata(aName, "Version") or "") .. "\n",
				},
				longdesc = {
					type = "description",
					order = 2,
					name = self.L["Provides a Minimalist UI by removing the Blizzard textures"] .. "\n",
				},
				Errors = {
					type = "toggle",
					order = 3,
					name = self.L["Show Errors"],
					desc = self.L["Toggle the Showing of Errors"],
				},
				Warnings = {
					type = "toggle",
					order = 4,
					name = self.L["Show Warnings"],
					desc = self.L["Toggle the Showing of Warnings"],
				},
				MinimapIcon = {
					type = "toggle",
					order = 5,
					name = self.L["Minimap icon"],
					desc = self.L["Toggle the minimap icon"],
					get = function(info) return not db.MinimapIcon.hide end,
					set = function(info, value)
						db.MinimapIcon.hide = not value
						if value then self.DBIcon:Show(aName) else self.DBIcon:Hide(aName) end
					end,
					hidden = function() return not self.DBIcon end,
				},
				FrameBorders = {
					type = "toggle",
					order = 7,
					name = self.L["Frame Borders"],
					desc = self.L["Frame Borders"] .. " " .. self.L["have no Background or Gradient textures"],
				},
				TabDDTextures = {
					type = "group",
					order = 10,
					inline = true,
					name = self.L["Inactive Tab & DropDown Texture Settings"],
					args = {
						TexturedDD = {
							type = "toggle",
							order = 1,
							name = self.L["Textured DropDown"],
							desc = self.L["Toggle the Texture of the DropDowns"],
						},
						TexturedTab = {
							type = "toggle",
							order = 2,
							name = self.L["Textured Tab"],
							desc = self.L["Toggle the Texture of the Tabs"],
							set = function(info, value)
								db[info[#info]] = value
								self.isTT = db[info[#info]] and true or false
							end,
						},
						TabDDFile = {
							type = "input",
							order = 3,
							width = "full",
							name = self.L["Inactive Tab & DropDown Texture File"],
							desc = self.L["Set Inactive Tab & DropDown Texture Filename"],
						},
						TabDDTexture = _G.AceGUIWidgetLSMlists and {
							type = "select",
							order = 4,
							width = "double",
							name = self.L["Inactive Tab & DropDown Texture"],
							desc = self.L["Choose the Texture for the Inactive Tab & DropDowns"],
							dialogControl = "LSM30_Background",
							values = _G.AceGUIWidgetLSMlists.background,
						} or nil,
					},
				},
				Delay = {
					type = "group",
					order = 12,
					inline = true,
					name = self.L["Skinning Delays"],
					get = function(info) return db.Delay[info[#info]] end,
					set = function(info, value) db.Delay[info[#info]] = value end,
					args = {
						Init = {
							type = "range",
							order = 1,
							name = self.L["Initial Delay"],
							desc = self.L["Set the Delay before Skinning Blizzard Frames"],
							min = 0, max = 10, step = 0.5,
						},
						Addons = {
							type = "range",
							order = 2,
							name = self.L["Addons Delay"],
							desc = self.L["Set the Delay before Skinning Addons Frames"],
							min = 0, max = 10, step = 0.5,
						},
					},
				},
				FadeHeight = {
					type = "group",
					order = 14,
					inline = true,
					name = self.L["Fade Height"],
					get = function(info) return db.FadeHeight[info[#info]] end,
					set = function(info, value) db.FadeHeight[info[#info]] = value end,
					args = {
						enable = {
							type = "toggle",
							order = 1,
							name = self.L["Global Fade Height"],
							desc = self.L["Toggle the Global Fade Height"],
						},
						value = {
							type = "range",
							order = 2,
							name = self.L["Fade Height value"],
							desc = self.L["Change the Height of the Fade Effect"],
							min = 0, max = 1000, step = 10,
						},
						force = {
							type = "toggle",
							order = 3,
							name = self.L["Force the Global Fade Height"],
							desc = self.L["Force ALL Frame Fade Height's to be Global"],
						},
					},
				},
				StatusBar = {
					type = "group",
					order = 16,
					inline = true,
					name = self.L["Status Bar"],
					args = {
						texture = _G.AceGUIWidgetLSMlists and {
							type = "select",
							order = 1,
							name = self.L["Texture"],
							desc = self.L["Choose the Texture for the Status Bars"],
							dialogControl = "LSM30_Statusbar",
							values = _G.AceGUIWidgetLSMlists.statusbar,
							get = function(info) return db.StatusBar.texture end,
							set = function(info, value)
								db.StatusBar.texture = value
								self:checkAndRun("updateSBTexture", "s") -- not an addon in its own right
							end,
						} or nil,
						bgcolour = {
							type = "color",
							order = 2,
							name = self.L["Background Colour"],
							desc = self.L["Change the Colour of the Status Bar Background"],
							hasAlpha = true,
							get = function(info)
								local c = db.StatusBar
								return c.r, c.g, c.b, c.a
							end,
							set = function(info, r, g, b, a)
								local c = db.StatusBar
								c.r, c.g, c.b, c.a = r, g, b, a
								self:checkAndRun("updateSBTexture", "s") -- not an addon in its own right
							end,
						},
					},
				},
			},
		},

		Backdrop = {
			type = "group",
			name = self.L["Default Backdrop"],
			get = function(info) return db[info[#info]] end,
			set = function(info, value)
				db[info[#info]] = value == "" and "None" or value
				if info[#info] ~= "BdDefault" then db.BdDefault = false end
				reskinIOFBackdrop()
			end,
			args = {
				BdDefault = {
					type = "toggle",
					order = 1,
					width = "double",
					name = self.L["Use Default Backdrop"],
					desc = self.L["Toggle the Default Backdrop"],
				},
				BdFile = {
					type = "input",
					order = 2,
					width = "full",
					name = self.L["Backdrop Texture File"],
					desc = self.L["Set Backdrop Texture Filename"],
				},
				BdTexture = _G.AceGUIWidgetLSMlists and {
					type = "select",
					order = 3,
					width = "double",
					name = self.L["Backdrop Texture"],
					desc = self.L["Choose the Texture for the Backdrop"],
					dialogControl = "LSM30_Background",
					values = _G.AceGUIWidgetLSMlists.background,
				} or nil,
				BdTileSize = {
					type = "range",
					order = 4,
					name = self.L["Backdrop TileSize"],
					desc = self.L["Set Backdrop TileSize"],
					min = 0, max = 128, step = 4,
				},
				BdEdgeFile = {
					type = "input",
					order = 5,
					width = "full",
					name = self.L["Border Texture File"],
					desc = self.L["Set Border Texture Filename"],
				},
				BdBorderTexture = _G.AceGUIWidgetLSMlists and {
					type = "select",
					order = 6,
					width = "double",
					name = self.L["Border Texture"],
					desc = self.L["Choose the Texture for the Border"],
					dialogControl = 'LSM30_Border',
					values = _G.AceGUIWidgetLSMlists.border,
				} or nil,
				BdEdgeSize = {
					type = "range",
					order = 7,
					name = self.L["Border Width"],
					desc = self.L["Set Border Width"],
					min = 0, max = 32, step = 1,
				},
				BdInset = {
					type = "range",
					order = 8,
					name = self.L["Border Inset"],
					desc = self.L["Set Border Inset"],
					min = 0, max = 8, step = 1,
				},
			},
		},

		Background = {
			type = "group",
			name = self.L["Background Settings"],
			get = function(info) return db[info[#info]] end,
			set = function(info, value)
				db[info[#info]] = value == "" and "None" or value
				if info[#info] ~= "BgUseTex"
				and info[#info] ~= "LFGTexture"
				then
					db.BgUseTex = true
				end
				if db.BgUseTex then db.Tooltips.style = 3 end -- set Tooltip style to Custom
			end,
			args = {
				BgUseTex = {
					type = "toggle",
					order = 1,
					width = "double",
					name = self.L["Use Background Texture"],
					desc = self.L["Toggle the Background Texture"],
				},
				BgFile = {
					type = "input",
					order = 2,
					width = "full",
					name = self.L["Background Texture File"],
					desc = self.L["Set Background Texture Filename"],
				},
				BgTexture = _G.AceGUIWidgetLSMlists and {
					type = "select",
					order = 3,
					width = "double",
					name = self.L["Background Texture"],
					desc = self.L["Choose the Texture for the Background"],
					dialogControl = "LSM30_Background",
					values = _G.AceGUIWidgetLSMlists.background,
				} or nil,
				BgTile = {
					type = "toggle",
					order = 4,
					name = self.L["Tile Background"],
					desc = self.L["Tile or Stretch Background"],
				},
				LFGTexture = {
					type = "toggle",
					width = "double",
					name = self.L["Show LFG Background Texture"],
					desc = self.L["Toggle the background texture of the LFG Popup"],
				},
			},
		},

		Colours = {
			type = "group",
			name = self.L["Default Colours"],
			get = function(info)
				if info[#info] == "ClassClrBd"
				or info[#info] == "ClassClrBg"
				or info[#info] == "ClassClrGr"
				or info[#info] == "ClassClrTT"
				then
					return db[info[#info]]
				else
					return db[info[#info]]:GetRGBA()
				end
			end,
			set = function(info, r, g, b, a)
				local c
				if info[#info]:find("ClassClr") then
					if self.isClsc then
						c = {_G.GetClassColorObj(self.uCls):GetRGBA()}
					else
						c = {_G.C_ClassColor.GetClassColor(self.uCls):GetRGBA()}
					end
				end
				if info[#info] == "ClassClrBd" then
					db[info[#info]] = r
					if r then
						db.BackdropBorder:SetRGBA(c[1], c[2], c[3], 1)
						if _G.IsAddOnLoaded("Baggins") then
							db.BagginsBBC:SetRGBA(c[1], c[2], c[3], 1)
						end
					else
						db.BackdropBorder:SetRGBA(dflts.BackdropBorder:GetRGBA())
						if _G.IsAddOnLoaded("Baggins") then
							db.BagginsBBC:SetRGBA(dflts.BagginsBBC:GetRGBA())
						end
					end
				elseif info[#info] == "ClassClrBg" then
					db[info[#info]] = r
					if r then
						db.Backdrop:SetRGBA(c[1], c[2], c[3], 1)
					else
						db.Backdrop:SetRGBA(dflts.Backdrop:GetRGBA())
					end
				elseif info[#info] == "ClassClrGr" then
					db[info[#info]] = r
					if r then
						db.GradientMax:SetRGBA(c[1], c[2], c[3], 1)
					else
						db.GradientMax:SetRGBA(dflts.GradientMax:GetRGBA())
					end
				elseif info[#info] == "ClassClrTT" then
					db[info[#info]] = r
					if r then
						db.TooltipBorder:SetRGBA(c[1], c[2], c[3], 1)
					else
						db.TooltipBorder:SetRGBA(dflts.TooltipBorder:GetRGBA())
					end
				else
					db[info[#info]]:SetRGBA(r, g, b, a)
				end
				c = nil
			end,
			args = {
				ClassClrBd = {
					type = "toggle",
					order = 1,
					width = "double",
					name = self.L["Class Coloured "] .. self.L["Border"],
					desc = self.L["Use Class Colour for "] .. self.L["Border"],
				},
				ClassClrBg = {
					type = "toggle",
					order = 2,
					width = "double",
					name = self.L["Class Coloured "] .. self.L["Background"],
					desc = self.L["Use Class Colour for "] .. self.L["Background"],
				},
				ClassClrGr = {
					type = "toggle",
					order = 3,
					width = "double",
					name = self.L["Class Coloured "] .. self.L["Gradient"],
					desc = self.L["Use Class Colour for "] .. self.L["Gradient"],
				},
				ClassClrTT = {
					type = "toggle",
					order = 4,
					width = "double",
					name = self.L["Class Coloured "] .. self.L["Tooltip"],
					desc = self.L["Use Class Colour for "] .. self.L["Tooltip"],
				},
				TooltipBorder = {
					type = "color",
					order = 6,
					width = "double",
					name = self.L["Tooltip"] .. " " .. self.L["Border"] .. " " .. self.L["Colour"],
					desc = self.L["Set "] .. self.L["Tooltip"] .. " " .. self.L["Border"] .. " " .. self.L["Colour"],
					hasAlpha = true,
				},
				Backdrop = {
					type = "color",
					order = 7,
					width = "double",
					name = self.L["Backdrop"] .. " " .. self.L["Colour"],
					desc = self.L["Set "] .. self.L["Backdrop"] .. " " .. self.L["Colour"],
					hasAlpha = true,
				},
				BackdropBorder = {
					type = "color",
					order = 8,
					width = "double",
					name = self.L["Backdrop"] .. " " .. self.L["Border"] .. " " .. self.L["Colour"],
					desc = self.L["Set "] .. self.L["Backdrop"] .. " " .. self.L["Border"] .. " " .. self.L["Colour"],
					hasAlpha = true,
				},
				SliderBorder = {
					type = "color",
					order = 9,
					width = "double",
					name = self.L["Slider & EditBox"] .. " " .. self.L["Border"] .. " " .. self.L["Colour"],
					desc = self.L["Set "] .. self.L["Slider & EditBox"] .. " " .. self.L["Border"] .. " " .. self.L["Colour"],
					hasAlpha = true,
				},
				HeadText = {
					type = "color",
					order = 10,
					width = "double",
					name = self.L["Text Heading Colour"],
					desc = self.L["Set "] .. self.L["Text Heading Colour"],
				},
				BodyText = {
					type = "color",
					order = 11,
					width = "double",
					name = self.L["Text Body Colour"],
					desc = self.L["Set "] .. self.L["Text Body Colour"],
				},
				IgnoredText = {
					type = "color",
					order = 12,
					width = "double",
					name = self.L["Ignored Text Colour"],
					desc = self.L["Set "] .. self.L["Ignored Text Colour"],
				},
				GradientMin = {
					type = "color",
					order = 20,
					width = "double",
					name = self.L["Gradient Minimum Colour"],
					desc = self.L["Set "] .. self.L["Gradient Minimum Colour"],
					hasAlpha = true,
				},
				GradientMax = {
					type = "color",
					order = 21,
					width = "double",
					name = self.L["Gradient Maximum Colour"],
					desc = self.L["Set "] .. self.L["Gradient Maximum Colour"],
					hasAlpha = true,
				},
				BagginsBBC = _G.IsAddOnLoaded("Baggins") and {
					type = "color",
					order = -1,
					width = "double",
					name = self.L["Baggins Bank Bags Colour"],
					desc = self.L["Set "] .. self.L["Baggins Bank Bags Colour"],
					hasAlpha = true,
				} or nil,
			},
		},

		Gradient = {
			type = "group",
			name = self.L["Gradient"],
			get = function(info) return db.Gradient[info[#info]] end,
			set = function(info, value) db.Gradient[info[#info]] = value end,
			args = {
				enable = {
					type = "toggle",
					order = 1,
					width = "double",
					name = self.L["Gradient Effect"],
					desc = self.L["Toggle the Gradient Effect"],
				},
				texture = _G.AceGUIWidgetLSMlists and {
					type = "select",
					order = 2,
					width = "double",
					name = self.L["Gradient Texture"],
					desc = self.L["Choose the Texture for the Gradient"],
					dialogControl = "LSM30_Background",
					values = _G.AceGUIWidgetLSMlists.background,
				} or nil,
				invert = {
					type = "toggle",
					order = 3,
					width = "double",
					name = self.L["Invert Gradient"],
					desc = self.L["Invert the Gradient Effect"],
				},
				rotate = {
					type = "toggle",
					order = 4,
					width = "double",
					name = self.L["Rotate Gradient"],
					desc = self.L["Rotate the Gradient Effect"],
				},
				char = {
					type = "toggle",
					order = 5,
					width = "double",
					name = self.L["Enable Character Frames Gradient"],
					desc = self.L["Enable the Gradient Effect for the Character Frames"],
				},
				ui = {
					type = "toggle",
					order = 6,
					width = "double",
					name = self.L["Enable UserInterface Frames Gradient"],
					desc = self.L["Enable the Gradient Effect for the UserInterface Frames"],
				},
				npc = {
					type = "toggle",
					order = 7,
					width = "double",
					name = self.L["Enable NPC Frames Gradient"],
					desc = self.L["Enable the Gradient Effect for the NPC Frames"],
				},
				skinner = {
					type = "toggle",
					order = 8,
					width = "double",
					name = self.L["Enable Skinner Frames Gradient"],
					desc = self.L["Enable the Gradient Effect for the Skinner Frames"],
				},
				addon = {
					type = "toggle",
					order = 9,
					width = "double",
					name = self.L["Enable AddOn Frames Gradient"],
					desc = self.L["Enable the Gradient Effect for AddOn Frames"],
				},
			},
		},

		Modules = {
			type = "group",
			name = self.L["Module settings"],
			childGroups = "tab",
			args = {
				desc = {
					type = "description",
					name = self.L["Change the Module's settings"],
				},
			},
		},

		["NPC Frames"] = {
			type = "group",
			name = self.L["NPC Frames"],
			get = function(info) return db[info[#info]] end,
			set = function(info, value)
				db[info[#info]] = value
				-- handle Blizzard LoD Addons
				if self.blizzLoDFrames.n[info[#info]] then
					if _G.IsAddOnLoaded("Blizzard_" .. info[#info]) then
						self:checkAndRun(info[#info], "n", true)
					end
				else self:checkAndRun(info[#info], "n") end
				-- treat GossipFrame, QuestFrame, QuestInfo & QuestLog/QuestMap as one
				-- as they all change the quest text colours
				if info[#info] == "GossipFrame" then
					db.QuestFrame = value
					db.QuestInfo = value
					if self.isClsc then
						db.QuestLog = value
					else
						db.QuestMap = value
					end
					_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame[self.L["UI Frames"]])
					_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame[self.L["NPC Frames"]])
				elseif info[#info] == "QuestFrame" then
					db.GossipFrame = value
					db.QuestInfo = value
					if self.isClsc then
						db.QuestLog = value
					else
						db.QuestMap = value
					end
					_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame[self.L["UI Frames"]])
					_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame[self.L["NPC Frames"]])
				elseif info[#info] == "QuestInfo" then
					db.GossipFrame = value
					db.QuestFrame = value
					if self.isClsc then
						db.QuestLog = value
					else
						db.QuestMap = value
					end
					_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame[self.L["UI Frames"]])
					_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame[self.L["NPC Frames"]])
				end
			end,
			args = {
				head1 = {
					order = 1,
					type = "header",
					name = self.L["Either"],
				},
				DisableAllNPC = {
					order = 2,
					width = "full",
					type = "toggle",
					name = self.L["Disable all NPC Frames"],
					desc = self.L["Disable all the NPC Frames from being skinned"],
					set = function(info, value) db[info[#info]] = value end,
				},
				head2 = {
					order = 3,
					type = "header",
					name = self.L["or choose which frames to skin"],
				},
				AlliedRacesUI = {
					type = "toggle",
					name = self.L["Allied Races UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Allied Races UI"],
				},
				AuctionHouseUI = {
					type = "toggle",
					name = self.L["AuctionHouse UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["AuctionHouse UI"],
				},
				AzeriteRespecUI ={
					type = "toggle",
					name = self.L["Azerite Respec UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Azerite Respec UI"],
				},
				BankFrame = {
					type = "toggle",
					name = self.L["Bank Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Bank Frame"],
				},
				BlackMarketUI = {
					type = "toggle",
					name = self.L["Black Market UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Black Market UI"],
				},
				ChromieTimeUI = {
					type = "toggle",
					name = self.L["Chromie Time UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Chromie Time UI"],
				},
				CovenantRenown = {
					type = "toggle",
					name = self.L["Covenant Renown"],
					desc = self.L["Toggle the skin of the "] .. self.L["Covenant Renown"],
				},
				CovenantSanctum = {
					type = "toggle",
					name = self.L["Covenant Sanctum"],
					desc = self.L["Toggle the skin of the "] .. self.L["Covenant Sanctum"],
				},
				CovenantPreviewUI = {
					type = "toggle",
					name = self.L["Covenant Preview UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Covenant Preview UI"],
				},
				FlightMap = {
					type = "toggle",
					name = self.L["Flight Map"],
					desc = self.L["Toggle the skin of the "] .. self.L["Flight Map"],
				},
				GossipFrame = {
					type = "toggle",
					name = self.L["Gossip Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Gossip Frame"],
				},
				GuildRegistrar = {
					type = "toggle",
					name = self.L["Guild Registrar Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Guild Registrar Frame"],
				},
				ItemInteractionUI = {
					type = "toggle",
					name = self.L["Item Interaction UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Item Interaction UI"],
				},
				ItemUpgradeUI = {
					type = "toggle",
					name = self.L["Item Upgrade UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Item Upgrade UI"],
				},
				MerchantFrame = {
					type = "toggle",
					name = self.L["Merchant Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Merchant Frame"],
				},
				NewPlayerExperienceGuide = {
					type = "toggle",
					name = self.L["New Player Experience Guide Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["New Player Experience Guide Frame"],
				},
				Petition = {
					type = "toggle",
					name = self.L["Petition Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Petition Frame"],
				},
				PetStableFrame = {
					type = "toggle",
					name = self.L["Stable Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Stable Frame"],
				},
				QuestFrame = {
					type = "toggle",
					name = self.L["Quest Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Quest Frame"],
				},
				QuestInfo = {
					type = "toggle",
					name = self.L["Quest Info Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Quest Info Frame"],
				},
				RuneForgeUI = {
					type = "toggle",
					name = self.L["RuneForge UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["RuneForge UI"],
				},
				Tabard = {
					type = "toggle",
					name = self.L["Tabard Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Tabard Frame"],
				},
				TaxiFrame = {
					type = "toggle",
					name = self.L["Taxi Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Taxi Frame"],
				},
				TrainerUI = {
					name = self.L["Trainer UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Trainer UI"],
					type = "toggle",
				},
				VoidStorageUI = {
					type = "toggle",
					name = self.L["Void Storage UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Void Storage UI"],
				},
			},
		},

		["Player Frames"] = {
			type = "group",
			name = self.L["Player Frames"],
			get = function(info) return db[info[#info]] end,
			set = function(info, value)
				db[info[#info]] = value
				-- handle Blizzard LoD Addons
				if self.blizzLoDFrames.p[info[#info]] then
					if _G.IsAddOnLoaded("Blizzard_" .. info[#info]) then
						self:checkAndRun(info[#info], "p", true)
					end
				else self:checkAndRun(info[#info], "p") end
			end,
			args = {
				head1 = {
					order = 1,
					type = "header",
					name = self.L["Either"],
				},
				DisableAllP = {
					order = 2,
					width = "full",
					type = "toggle",
					name = self.L["Disable all Player Frames"],
					desc = self.L["Disable all the Player Frames from being skinned"],
					set = function(info, value) db[info[#info]] = value end,
				},
				head2 = {
					order = 3,
					type = "header",
					name = self.L["or choose which frames to skin"],
				},
				AchievementUI = {
					type = "group",
					order = -1,
					inline = true,
					name = self.L["Achievement UI"],
					get = function(info) return db.AchievementUI[info[#info]] end,
					set = function(info, value)
						db.AchievementUI[info[#info]] = value
						if _G.IsAddOnLoaded("Blizzard_AchievementUI") then	self:checkAndRun("AchievementUI", "p", true) end
					end,
					args = {
						skin = {
							type = "toggle",
							name = self.L["Skin Frame"],
							desc = self.L["Toggle the skin of the "] .. self.L["Achievement UI"],
						},
						style = {
							type = "range",
							name = self.L["Achievement Style"],
							desc = self.L["Set the Achievement style (Textured, Untextured)"],
							min = 1, max = 2, step = 1,
						},
					},
				},
				ArchaeologyUI = {
					type = "toggle",
					name = self.L["Archaeology UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Archaeology UI"],
				},
				ArtifactUI = {
					type = "toggle",
					name = self.L["Artifact UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Artifact UI"],
				},
				AzeriteEssenceUI = {
					type = "toggle",
					name = self.L["Azerite Essence UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Azerite Essence UI"],
				},
				AzeriteUI = {
					type = "toggle",
					name = self.L["Azerite UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Azerite UI"],
				},
				Buffs = {
					type = "toggle",
					name = self.L["Buffs Buttons"],
					desc = self.L["Toggle the skin of the "] .. self.L["Buffs Buttons"],
				},
				CastingBar = {
					type = "group",
					inline = true,
					order = -1,
					name = self.L["Casting Bar Frames"],
					get = function(info) return db.CastingBar[info[#info]] end,
					set = function(info, value)
						db.CastingBar[info[#info]] = value
						self:checkAndRun("CastingBar", "p")
					end,
					args = {
						skin = {
							type = "toggle",
							order = 1,
							name = self.L["Skin Frames"],
							desc = self.L["Toggle the skin of the "] .. self.L["Casting Bar Frames"],
						},
						glaze = {
							type = "toggle",
							order = 2,
							name = self.L["Glaze Frames"],
							desc = self.L["Toggle the glazing of the "] .. self.L["Casting Bar Frames"],
						},
					},
				},
				CharacterFrames = {
					type = "toggle",
					name = self.L["Character Frames"],
					desc = self.L["Toggle the skin of the "] .. self.L["Character Frames"],
				},
				Collections = {
					-- (Mounts, Pets, Toys, Heirlooms & Appearances)
					type = "toggle",
					name = self.L["Collections Journal"],
					desc = self.L["Toggle the skin of the "] .. self.L["Collections Journal"],
				},
				Communities ={
					type = "toggle",
					name = self.L["Communities UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Communities UI"],
				},
				CompactFrames = {
					type = "toggle",
					name = self.L["Compact Frames"],
					desc = self.L["Toggle the skin of the "] .. self.L["Compact Frames"],
				},
				ContainerFrames = {
					type = "group",
					inline = true,
					order = -1,
					name = self.L["Container Frames"],
					get = function(info) return db.ContainerFrames[info[#info]] end,
					set = function(info, value)
						db.ContainerFrames[info[#info]] = value
						self:checkAndRun("ContainerFrames", "p")
					end,
					args = {
						skin = {
							type = "toggle",
							order = 1,
							name = self.L["Skin Frames"],
							desc = self.L["Toggle the skin of the "] .. self.L["Container Frames"],
						},
						fheight = {
							type = "range",
							order = 2,
							name = self.L["CF Fade Height"],
							desc = self.L["Change the Height of the Fade Effect"],
							min = 0, max = 300, step = 1,
						},
					},
				},
				DressUpFrame = {
					type = "toggle",
					name = self.L["Dress Up Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Dress Up Frame"],
				},
				EncounterJournal = {
					type = "toggle",
					name = self.L["Adventure Guide"],
					desc = self.L["Toggle the skin of the "] .. self.L["Adventure Guide"],
				},
				EquipmentFlyout = {
					type = "toggle",
					name = self.L["Equipment Flyout"],
					desc = self.L["Toggle the skin of the "] .. self.L["Equipment Flyout"],
				},
				FriendsFrame = {
					type = "toggle",
					name = self.L["Friends List Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Friends List Frame"],
				},
				GuildControlUI = {
					type = "toggle",
					name = self.L["Guild Control UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Guild Control UI"],
				},
				GuildUI = {
					type = "toggle",
					name = self.L["Guild UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Guild UI"],
				},
				GuildInvite = {
					type = "toggle",
					name = self.L["Guild Invite Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Guild Invite Frame"],
				},
				InspectUI = {
					type = "toggle",
					name = self.L["Inspect UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Inspect UI"],
				},
				ItemSocketingUI = {
					type = "toggle",
					name = self.L["Item Socketing UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Item Socketing UI"],
				},
				LookingForGuildUI = {
					type = "toggle",
					name = self.L["Looking for Guild UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Looking for Guild UI"],
				},
				LootFrames = {
					type = "group",
					inline = true,
					order = -1,
					name = self.L["Loot Frames"],
					get = function(info) return db.LootFrames[info[#info]] end,
					set = function(info, value)
						db.LootFrames[info[#info]] = value
						self:checkAndRun("LootFrames", "p")
					end,
					args = {
						skin = {
							type = "toggle",
							order = 1,
							name = self.L["Skin Frames"],
							desc = self.L["Toggle the skin of the "] .. self.L["Loot Frames"],
						},
						size = {
							type = "range",
							order = 3,
							name = self.L["GroupLoot Size"],
							desc = self.L["Set the GroupLoot size (Normal, Small, Micro)"],
							min = 1, max = 3, step = 1,
						},
					},
				},
				LootHistory = {
					type = "toggle",
					name = self.L["Loot History Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Loot History Frame"],
				},
				MirrorTimers = {
					type = "group",
					inline = true,
					order = -1,
					name = self.L["Timer Frames"],
					get = function(info) return db.MirrorTimers[info[#info]] end,
					set = function(info, value)
						db.MirrorTimers[info[#info]] = value
						self:checkAndRun("MirrorTimers", "p")
					end,
					args = {
						skin = {
							type = "toggle",
							order = 1,
							name = self.L["Skin Frames"],
							desc = self.L["Toggle the skin of the "] .. self.L["Timer Frames"],
						},
						glaze = {
							type = "toggle",
							order = 2,
							name = self.L["Glaze Frames"],
							desc = self.L["Toggle the glazing of the "] .. self.L["Timer Frames"],
						},
					},
				},
				ObjectiveTracker = {
					type = "group",
					order = -1,
					inline = true,
					name = self.L["ObjectiveTracker Frame"],
					get = function(info) return db.ObjectiveTracker[info[#info]] end,
					set = function(info, value) db.ObjectiveTracker[info[#info]] = value end,
					args = {
						skin = {
							type = "toggle",
							order = 1,
							name = self.L["Skin Frame"],
							desc = self.L["Toggle the skin of the "] .. self.L["ObjectiveTracker Frame"],
						},
						popups = {
							type = "toggle",
							order = 2,
							name = self.L["AutoPopUp Frames"],
							desc = self.L["Toggle the skin of the "] .. self.L["AutoPopUp Frames"],
						},
						headers = {
							type = "toggle",
							order = 3,
							name = self.L["Header Blocks"],
							desc = self.L["Toggle the skin of the "] .. self.L["Header Blocks"],
						},
						animapowers = {
							type = "toggle",
							order = 4,
							name = self.L["Anima Powers"],
							desc = self.L["Toggle the skin of the "] .. self.L["Anima Powers"],
						},
					},
				},
				OverrideActionBar = {
					type = "toggle",
					name = self.L["Vehicle UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Vehicle UI"],
				},
				PVPUI = {
					type = "toggle",
					name = self.L["PVP Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["PVP Frame"],
				},
				RaidUI = {
					type = "toggle",
					name = self.L["Raid UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Raid UI"],
				},
				ReadyCheck = {
					type = "toggle",
					name = self.L["Ready Check Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Ready Check Frame"],
				},
				RolePollPopup = {
					type = "toggle",
					name = self.L["Role Poll Popup"],
					desc = self.L["Toggle the skin of the "] .. self.L["Role Poll Popup"],
				},
				SpellBookFrame = {
					type = "toggle",
					name = self.L["SpellBook Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["SpellBook Frame"],
				},
				StackSplit = {
					type = "toggle",
					name = self.L["Stack Split Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Stack Split Frame"],
				},
				TalentUI = {
					type = "toggle",
					name = self.L["Talent UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Talent UI"],
				},
				TradeFrame = {
					type = "toggle",
					name = self.L["Trade Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Trade Frame"],
				},
				TradeSkillUI = {
					type = "toggle",
					name = self.L["Trade Skill UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Trade Skill UI"],
				},
			},
		},

		["UI Frames"] = {
			type = "group",
			name = self.L["UI Frames"],
			get = function(info) return db[info[#info]] end,
			set = function(info, value)
				db[info[#info]] = value
				if info[#info] == "Colours" then self:checkAndRun("ColorPicker", "p")
				elseif info[#info] == "CombatLogQBF" then return
				elseif info[#info] == "ChatTabsFade" then return
				-- handle Blizzard LoD Addons
				elseif self.blizzLoDFrames.u[info[#info]] then
					if _G.IsAddOnLoaded("Blizzard_" .. info[#info]) then
						self:checkAndRun(info[#info], "u", true)
					end
				-- treat GossipFrame, QuestFrame, QuestInfo & QuestLog/QuestMap as one
				-- as they all change the quest text colours
				elseif info[#info] == self.isCls and "QuestLog" or "QuestMap" then
					db.GossipFrame = value
					db.QuestFrame = value
					db.QuestInfo = value
					_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame[self.L["NPC Frames"]])
					_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame[self.L["UI Frames"]])
				else self:checkAndRun(info[#info], "u") end
			end,
			args = {
				head1 = {
					order = 1,
					type = "header",
					name = self.L["Either"],
				},
				DisableAllUI = {
					order = 2,
					width = "full",
					type = "toggle",
					name = self.L["Disable all UI Frames"],
					desc = self.L["Disable all the UI Frames from being skinned"],
					set = function(info, value) db[info[#info]] = value end,
				},
				head2 = {
					order = 3,
					type = "header",
					name = self.L["or choose which frames to skin"],
				},
				AddonList = {
					type = "toggle",
					name = self.L["Addon List Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Addon List Frame"],
				},
				AdventureMap = {
					type = "toggle",
					name = self.L["Adventure Map"],
					desc = self.L["Toggle the skin of the "] .. self.L["Adventure Map"],
				},
				AlertFrames = {
					type = "toggle",
					name = self.L["Alert Frames"],
					desc = self.L["Toggle the skin of the "] .. self.L["Alert Frames"],
				},
				AnimaDiversionUI = {
					type = "toggle",
					name = self.L["Anima Diversion UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Anima Diversion UI"],
				},
				AutoComplete = {
					type = "toggle",
					name = self.L["Auto Complete Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Auto Complete Frame"],
				},
				AzeriteItemToasts = {
					type = "toggle",
					name = self.L["Azerite Item Toasts"],
					desc = self.L["Toggle the skin of the "] .. self.L["Azerite Item Toasts"],
				},
				BattlefieldMap = {
					type = "toggle",
					name = self.L["Battlefield Map Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Battlefield Map Frame"],
				},
				BindingUI = {
					type = "toggle",
					name = self.L["Key Bindings UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Key Bindings UI"],
				},
				BNFrames = {
					type = "toggle",
					name = self.L["BattleNet Frames"],
					desc = self.L["Toggle the skin of the "] .. self.L["BattleNet Frames"],
				},
				Calendar = {
					type = "toggle",
					name = self.L["Calendar"],
					desc = self.L["Toggle the skin of the "] .. self.L["Calendar"],
				},
				ChallengesUI = {
					type = "toggle",
					name = self.L["Challenges UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Challenges UI"],
				},
				CharacterCustomize = {
					type = "toggle",
					width = "double",
					name = self.L["Character Customize Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Character Customize Frame"],
				},
				chatopts = {
					type = "group",
					inline = true,
					order = -1,
					name = self.L["Chat Sub Frames"],
					args = {
						ChatMenus = {
							type = "toggle",
							order = 1,
							name = self.L["Chat Menus"],
							desc = self.L["Toggle the skin of the "] .. self.L["Chat Menus"],
						},
						ChatConfig = {
							type = "toggle",
							order = 2,
							name = self.L["Chat Config Frame"],
							desc = self.L["Toggle the skin of the "] .. self.L["Chat Config Frame"],
						},
						ChatTabs = {
							type = "toggle",
							order = 3,
							name = self.L["Chat Tabs"],
							desc = self.L["Toggle the skin of the "] .. self.L["Chat Tabs"],
						},
						ChatTabsFade = {
							type = "toggle",
							order = 4,
							name = self.L["Chat Tabs Fade"],
							desc = self.L["Toggle the fading of the Chat Tabs"],
						},
						ChatFrames = {
							type = "toggle",
							order = 5,
							name = self.L["Chat Frames"],
							desc = self.L["Toggle the skin of the "] .. self.L["Chat Frames"],
						},
						ChatButtons = {
							type = "toggle",
							order = 6,
							name = self.L["Chat Buttons"],
							desc = self.L["Toggle the skin of the "] .. self.L["Chat Buttons"],
						},
						CombatLogQBF = {
							type = "toggle",
							width = "double",
							order = 7,
							name = self.L["CombatLog Quick Button Frame"],
							desc = self.L["Toggle the skin of the "] .. self.L["CombatLog Quick Button Frame"],
						},
					},
				},
				ChatBubbles = {
					type = "group",
					inline = true,
					order = -1,
					name = self.L["Chat Bubbles"],
					get = function(info) return db.ChatBubbles[info[#info]] end,
					set = function(info, value)
						db.ChatBubbles[info[#info]] = value
						self:checkAndRun("ChatBubbles", "u")
					end,
					args = {
						skin = {
							type = "toggle",
							order = 1,
							name = self.L["Chat Bubbles Skin"],
							desc = self.L["Toggle the skin of the "] .. self.L["Chat Bubbles"],
						},
						alpha = {
							type = "range",
							order = 2,
							name = self.L["Background Alpha"],
							desc = self.L["Set the Background Alpha value"],
							min = 0, max = 1, step = 0.05,
						},
					},
				},
				ChatChannelsUI = {
					type = "toggle",
					name = self.L["Chat Channels UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Chat Channels UI"],
				},
				ChatEditBox = {
					type = "group",
					inline = true,
					order = -1,
					name = self.L["Chat Edit Box"],
					get = function(info) return db.ChatEditBox[info[#info]] end,
					set = function(info, value)
						db.ChatEditBox[info[#info]] = value
						self:checkAndRun("ChatEditBox", "u")
					end,
					args = {
						skin = {
							type = "toggle",
							order = 1,
							name = self.L["Skin Frames"],
							desc = self.L["Toggle the skin of the "] .. self.L["Chat Edit Box Frames"],
						},
						style = {
							type = "range",
							order = 2,
							name = self.L["Chat Edit Box Style"],
							desc = self.L["Set the Chat Edit Box style (Frame, EditBox, Borderless)"],
							min = 1, max = 3, step = 1,
						},
					},
				},
				CinematicFrame = {
					type = "toggle",
					name = self.L["Cinematic Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Cinematic Frame"],
				},
				ClassTrial = {
					type = "toggle",
					name = self.L["Class Trial Frames"],
					desc = self.L["Toggle the skin of the "] .. self.L["Class Trial Frames"],
				},
				CoinPickup = {
					type = "toggle",
					name = self.L["Coin Pickup Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Coin Pickup Frame"],
				},
				Colours = {
					type = "toggle",
					name = self.L["Colour Picker Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Colour Picker Frame"],
				},
				Console = {
					type = "toggle",
					width = "double",
					name = self.L["Developer Console Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Developer Console Frame"],
				},
				Contribution = {
					type = "toggle",
					name = self.L["Contribution Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Contribution Frame"],
				},
				CovenantToasts = {
					type = "toggle",
					name = self.L["Covenant Toasts"],
					desc = self.L["Toggle the skin of the "] .. self.L["Covenant Toasts"],
				},
				DeathRecap = {
					type = "toggle",
					name = self.L["Death Recap Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Death Recap Frame"],
				},
				DebugTools = {
					type = "toggle",
					name = self.L["Debug Tools Frames"],
					desc = self.L["Toggle the skin of the "] .. self.L["Debug Tools Frames"],
				},
				DestinyFrame = {
					type = "toggle",
					name = self.L["Destiny Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Destiny Frame"],
				},
				EventToastManager ={
					type = "toggle",
					width = "double",
					name = self.L["Event Toast Manager Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Event Toast Manager Frame"],
				},
				EventTrace = not aObj.isClscERA and {
					type = "toggle",
					name = self.L["Event Trace"],
					desc = self.L["Toggle the skin of the "] .. self.L["Event Trace"],
				} or nil,
				GarrisonUI = {
					type = "toggle",
					name = self.L["Garrison UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Garrison UI"],
				},
				GhostFrame = {
					type = "toggle",
					name = self.L["Ghost Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Ghost Frame"],
				},
				GMChatUI = {
					type = "toggle",
					name = self.L["GM Chat UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["GM Chat UI"],
				},
				GuildBankUI = {
					type = "toggle",
					name = self.L["Guild Bank UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Guild Bank UI"],
				},
				HelpFrame = {
					type = "group",
					inline = true,
					order = -1,
					name = self.L["Help Frames"],
					args = {
						HelpFrame = {
							type = "toggle",
							name = self.L["Customer Support Frame"],
							desc = self.L["Toggle the skin of the "] .. self.L["Customer Support Frame"],
						},
					},
				},
				HelpTip = {
					type = "toggle",
					name = self.L["Help Tips"],
					desc = self.L["Toggle the skin of the "] .. self.L["Help Tips"],
				},
				InterfaceOptions = {
					type = "toggle",
					name = self.L["Interface Options"],
					desc = self.L["Toggle the skin of the "] .. self.L["Interface Options"],
				},
				IslandsPartyPoseUI ={
					type = "toggle",
					name = self.L["Islands Party Pose UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Islands Party Pose UI"],
				},
				IslandsQueueUI ={
					type = "toggle",
					name = self.L["Islands Queue UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Islands Queue UI"],
				},
				ItemText = {
					type = "toggle",
					name = self.L["Item Text Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Item Text Frame"],
				},
				LevelUpDisplay = {
					type = "toggle",
					name = self.L["Level Up Display"],
					desc = self.L["Toggle the skin of the "] .. self.L["Level Up Display"],
				},
				LossOfControl = {
					type = "toggle",
					name = self.L["Loss Of Control Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Loss Of Control Frame"],
				},
				MacroUI = {
					type = "toggle",
					name = self.L["Macros UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Macros UI"],
				},
				MailFrame = {
					type = "toggle",
					name = self.L["Mail Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Mail Frame"],
				},
				MainMenuBar = {
					type = "group",
					inline = true,
					order = -1,
					name = self.L["Main Menu Bar"],
					get = function(info) return db.MainMenuBar[info[#info]] end,
					set = function(info, value)
						db.MainMenuBar[info[#info]] = value
						self:checkAndRun("MainMenuBar", "u")
					end,
					args = {
						skin = {
							type = "toggle",
							order = 1,
							name = self.L["Skin Frame"],
							desc = self.L["Toggle the skin of the "] .. self.L["Main Menu Bar"],
						},
						glazesb = {
							type = "toggle",
							order = 2,
							width = "double",
							name = self.L["Glaze Status Bar"],
							desc = self.L["Toggle the glazing of the "] .. self.L["Status Bar"],
						},
						extraab = {
							type = "toggle",
							order = 3,
							width = "double",
							name = self.L["Extra Action Button"],
							desc = self.L["Toggle the skin of the "] .. self.L["Extra Action Button"],
						},
						altpowerbar = {
							type = "toggle",
							order = 3,
							width = "double",
							name = self.L["Alternate Power Bars"],
							desc = self.L["Toggle the skin of the "] .. self.L["Alternate Power Bars"],
						},
					},
				},
				MenuFrames = {
					-- inc. BindingUI & MacroUI
					type = "toggle",
					name = self.L["Menu Frames"],
					desc = self.L["Toggle the skin of the "] .. self.L["Menu Frames"],
				},
				Minimap = {
					type = "group",
					inline = true,
					order = -1,
					name = self.L["Minimap Options"],
					get = function(info) return db.Minimap[info[#info]] end,
					set = function(info, value)
						db.Minimap[info[#info]] = value
						if info[#info] == "skin" and value then self:checkAndRun("Minimap", "u")
						elseif info[#info] == "gloss" and _G.Minimap.sf then
							if value then
								_G.RaiseFrameLevel(_G.Minimap.sf)
							else
								_G.LowerFrameLevel(_G.Minimap.sf)
							end
						end
					end,
					args = {
						skin = {
							type = "toggle",
							name = self.L["Skin Frame"],
							desc = self.L["Toggle the skin of the "] .. self.L["Minimap"],
							order = 1,
						},
						gloss = {
							type = "toggle",
							name = self.L["Gloss Effect"],
							desc = self.L["Toggle the Gloss Effect for the Minimap"],
							order = 2,
						},
					},
				},
				MinimapButtons = {
					type = "group",
					inline = true,
					order = -1,
					name = self.L["Minimap Button Options"],
					get = function(info) return db.MinimapButtons[info[#info]] end,
					set = function(info, value)
						db.MinimapButtons[info[#info]] = value
						if info[#info] == "skin" and value then self:checkAndRun("MinimapButtons", "u")
						elseif info[#info] == "style" then
							db.MinimapButtons.skin = true
							self:checkAndRun("MinimapButtons", "u")
						end
					end,
					args = {
						skin = {
							type = "toggle",
							order = 1,
							name = self.L["Skin Buttons"],
							desc = self.L["Toggle the skin of the "] .. self.L["Minimap Buttons"],
						},
						style = {
							type = "toggle",
							name = self.L["Minimal Minimap Buttons"],
							desc = self.L["Toggle the style of the Minimap Buttons"],
							width = "double",
						},
					},
				},
				MovePad = {
					type = "toggle",
					name = self.L["Move Pad"],
					desc = self.L["Toggle the skin of the "] .. self.L["Move Pad"],
				},
				MovieFrame = {
					type = "toggle",
					name = self.L["Movie Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Movie Frame"],
				},
				Nameplates = {
					type = "toggle",
					name = self.L["Nameplates"],
					desc = self.L["Toggle the skin of the "] .. self.L["Nameplates"],
				},
				NavigationBar = {
					type = "toggle",
					name = self.L["Navigation Bar"],
					desc = self.L["Toggle the skin of the "] .. self.L["Navigation Bar"],
				},
				NewPlayerExperience = {
					type = "toggle",
					name = self.L["New Player Experience"],
					desc = self.L["Toggle the skin of the "] .. self.L["New Player Experience"],
				},
				ObliterumUI = {
					type = "toggle",
					name = self.L["Obliterum UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Obliterum UI"],
				},
				OrderHallUI = {
					type = "toggle",
					name = self.L["OrderHall UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["OrderHall UI"],
				},
				PetBattleUI = {
					type = "toggle",
					name = self.L["Pet Battle UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Pet Battle UI"],
				},
				ProductChoiceFrame = {
					type = "toggle",
					name = self.L["Product Choice Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Product Choice Frame"],
				},
				PlayerChoice = {
					type = "toggle",
					name = self.L["Player Choice UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Player Choice UI"],
				},
				PTRFeedback = {
					type = "toggle",
					name = self.L["PTR Feedback Frames"],
					desc = self.L["Toggle the skin of the "] .. self.L["PTR Feedback Frames"],
				},
				PVEFrame = {
					-- inc. LFD, LFG, RaidFinder
					type = "toggle",
					name = self.L["Group Finder Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Group Finder Frame"],
				},
				PVPMatch = {
					type = "toggle",
					name = self.L["PVP Match Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["PVP Match Frame"],
				},
				QuestMap = {
					type = "toggle",
					name = self.L["Quest Map"],
					desc = self.L["Toggle the skin of the "] .. self.L["Quest Map"],
				},
				QuestSession = {
					type = "toggle",
					name = self.L["Quest Session Frames"],
					desc = self.L["Toggle the skin of the "] .. self.L["Quest Session Frames"],
				},
				QueueStatusFrame = {
					type = "toggle",
					name = self.L["Queue Status Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Queue Status Frame"],
				},
				RaidFrame = {
					-- inc. LFR
					type = "toggle",
					name = self.L["Raid Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Raid Frame"],
				},
				ScrappingMachineUI ={
					type = "toggle",
					name = self.L["Scrapping Machine UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Scrapping Machine UI"],
				},
				SharedBasicControls = {
					type = "toggle",
					name = self.L["Script Errors Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Script Errors Frame"],
				},
				SplashFrame = {
					type = "toggle",
					name = self.L["What's New Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["What's New Frame"],
				},
				StaticPopups = {
					type = "toggle",
					name = self.L["Static Popups"],
					desc = self.L["Toggle the skin of the "] .. self.L["Static Popups"],
				},
				Soulbinds = {
					type = "toggle",
					name = self.L["Soulbinds Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Soulbinds Frame"],
				},
				SubscriptionInterstitialUI = {
					type = "toggle",
					width = "double",
					name = self.L["Subscription Interstitial UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Subscription Interstitial UI"],
				},
				SystemOptions = {
					type = "toggle",
					name = self.L["System Options"],
					desc = self.L["Toggle the skin of the "] .. self.L["System Options"],
				},
				TalkingHeadUI = {
					type = "toggle",
					name = self.L["TalkingHead UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["TalkingHead UI"],
				},
				TextToSpeechFrame = {
					type = "toggle",
					name = self.L["Text To Speech Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Text To Speech Frame"],
				},
				TimeManager = {
					type = "toggle",
					name = self.L["Time Manager Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Time Manager Frame"],
				},
				Tooltips = {
					type = "group",
					inline = true,
					order = -1,
					name = self.L["Tooltips"],
					get = function(info) return db.Tooltips[info[#info]] end,
					set = function(info, value) db.Tooltips[info[#info]] = value end,
					args = {
						skin = {
							type = "toggle",
							order = 1,
							name = self.L["Skin Frames"],
							desc = self.L["Toggle the skin of the "] .. self.L["Tooltips"],
						},
						glazesb = {
							type = "toggle",
							order = 2,
							width = "double",
							name = self.L["Glaze Status Bar"],
							desc = self.L["Toggle the glazing of the "] .. self.L["Status Bar"],
						},
						style = {
							type = "range",
							order = 3,
							name = self.L["Tooltips Style"],
							desc = self.L["Set the Tooltips style (Rounded, Flat, Custom)"],
							min = 1, max = 3, step = 1,
						},
						border = {
							type = "range",
							order = 4,
							name = self.L["Tooltips"] .. " " .. self.L["Border"] .. " " .. self.L["Colour"],
							desc = self.L["Set the Tooltips Border colour (Default, Custom)"],
							min = 1, max = 2, step = 1,
						},
					},
				},
				TorghastLevelPicker = {
					type = "toggle",
					width = "double",
					name = self.L["Torghast Level Picker Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Torghast Level Picker Frame"],
				},
				Tutorial = {
					type = "toggle",
					name = self.L["Tutorial Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Tutorial Frame"],
				},
				UIDropDownMenu = {
					type = "toggle",
					name = self.L["DropDown Panels"],
					desc = self.L["Toggle the skin of the "] .. self.L["DropDown Panels"],
				},
				UIWidgets = {
					type = "toggle",
					name = self.L["UI Widgets"],
					desc = self.L["Toggle the skin of the "] .. self.L["UI Widgets"],
				},
				UnitPopup ={
					type = "toggle",
					name = self.L["Unit Popups"],
					desc = self.L["Toggle the skin of the "] .. self.L["Unit Popups"],
				},
				WarfrontsPartyPoseUI = {
					type = "toggle",
					name = self.L["Warfronts Party Pose UI"],
					desc = self.L["Toggle the skin of the "] .. self.L["Warfronts Party Pose UI"],
				},
				WeeklyRewards = {
					type = "toggle",
					name = self.L["Weekly Rewards Frame"],
					desc = self.L["Toggle the skin of the "] .. self.L["Weekly Rewards Frame"],
				},
				WorldMap = {
					type = "group",
					inline = true,
					order = -1,
					name = self.L["World Map Frame"],
					get = function(info) return db.WorldMap[info[#info]] end,
					set = function(info, value)
						db.WorldMap[info[#info]] = value
						self:checkAndRun("WorldMap", "u")
					end,
					args = {
						skin = {
							type = "toggle",
							order = 1,
							name = self.L["Skin Frame"],
							desc = self.L["Toggle the skin of the "] .. self.L["World Map Frame"],
						},
						size = {
							type = "range",
							order = 2,
							name = self.L["World Map Size"],
							desc = self.L["Set the World Map size (Normal, Fullscreen)"],
							min = 1, max = 2, step = 1,
						},
					},
				},
				ZoneAbility = {
					type = "toggle",
					name = self.L["Zone Ability"],
					desc = self.L["Toggle the skin of the "] .. self.L["Zone Ability"],
				},
			},
		},

		["Disabled Skins"] = {
			type = "group",
			name = self.L["Disable Addon/Library Skins"],
			get = function(info) return db.DisabledSkins[info[#info]] end,
			set = function(info, value) db.DisabledSkins[info[#info]] = value and value or nil end,
			args = {
				head1 = {
					order = 1,
					type = "header",
					name = self.L["Either"],
				},
				DisableAllAS = {
					order = 2,
					width = "full",
					type = "toggle",
					name = self.L["Disable all Addon/Library Skins"],
					desc = self.L["Disable all the Addon/Library skins"],
					get = function(info) return db[info[#info]] end,
					set = function(info, value) db[info[#info]] = value end,
				},
				head2 = {
					order = 3,
					type = "header",
					name = self.L["or choose which Addon/Library skins to disable"],
				},
			},
		},

	}

	-- remove PTR Feedback option
	if not _G.PTR_IssueReporter then
		self.prdb.PTRFeedback = nil
		self.optTables["UI Frames"].args.PTRFeedback = nil
	end

	-- module options
	for _, mod in self:IterateModules() do
		if mod.GetOptions then
			self.optTables["Modules"].args[mod.name] = mod:GetOptions()
		end
	end

	-- add DB profile options
	self.optTables.Profiles = _G.LibStub:GetLibrary("AceDBOptions-3.0", true):GetOptionsTable(self.db)
	self.ACR = _G.LibStub:GetLibrary("AceConfigRegistry-3.0", true)

	-- register the options tables and add them to the blizzard frame
	self.ACR:RegisterOptionsTable(aName, self.optTables.General)
	self.optionsFrame = self.ACD:AddToBlizOptions(aName, self.L[aName]) -- N.B. display localised name

	-- register the options, add them to the Blizzard Options in the order specified
	local optCheck, optTitle = {}
	for _, oName in _G.pairs{"Backdrop", "Background", "Colours", "Gradient", "Modules", "NPC Frames", "Player Frames", "UI Frames", "Disabled Skins", "Profiles"} do
		optTitle = (" "):join(aName, oName)
		self.ACR:RegisterOptionsTable(optTitle, self.optTables[oName])
		self.optionsFrame[self.L[oName]] = self.ACD:AddToBlizOptions(optTitle, self.L[oName], self.L[aName]) -- N.B. use localised name
		optCheck[oName:lower()] = oName -- store option name in table
	end
	optTitle = nil

	-- runs when the player clicks "Defaults"
	self.optionsFrame[self.L["Backdrop"]].default = function()
		for name, _ in _G.pairs(self.optTables.Backdrop.args) do
			db[name] = dflts[name]
		end
		-- refresh panel
		_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame[self.L["Backdrop"]])
		reskinIOFBackdrop()
	end
	self.optionsFrame[self.L["Background"]].default = function()
		for name, _ in _G.pairs(self.optTables.Background.args) do
			db[name] = dflts[name]
		end
		-- refresh panel
		_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame[self.L["Background"]])
	end
	self.optionsFrame[self.L["Colours"]].default = function()
		for name, _ in _G.pairs(self.optTables.Colours.args) do
			db[name] = dflts[name]
		end
		-- refresh panel
		_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame[self.L["Colours"]])
	end
	self.optionsFrame[self.L["Gradient"]].default = function()
		for name, _ in _G.pairs(self.optTables.Gradient.args) do
			db.Gradient[name] = dflts.Gradient[name]
		end
		-- refresh panel
		_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame[self.L["Gradient"]])
	end
	self.optionsFrame[self.L["Disabled Skins"]].default = function()
		db.DisableAllAS = false
		_G.wipe(db.DisabledSkins)
		-- refresh panel
		_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame[self.L["Disabled Skins"]])
	end

	-- Slash command handler
	local function chatCommand(input)
		if not input or input:trim() == "" then
			-- Open general panel if there are no parameters, do twice to overcome Blizzard bug
			_G.InterfaceOptionsFrame_OpenToCategory(aObj.optionsFrame)
			_G.InterfaceOptionsFrame_OpenToCategory(aObj.optionsFrame)
		elseif optCheck[input:lower()] then
			_G.InterfaceOptionsFrame_OpenToCategory(aObj.optionsFrame[optCheck[input:lower()]])
			_G.InterfaceOptionsFrame_OpenToCategory(aObj.optionsFrame[optCheck[input:lower()]])
		else
			_G.LibStub:GetLibrary("AceConfigCmd-3.0", true):HandleCommand(aName, self.L[aName], input)
		end
	end

	-- Register slash command handlers
	self:RegisterChatCommand(self.L[aName], chatCommand) -- N.B. use localised name
	self:RegisterChatCommand("skin", chatCommand)

	-- setup the DB object
	self.DBObj = _G.LibStub:GetLibrary("LibDataBroker-1.1", true):NewDataObject(aName, {
		type = "launcher",
		icon = self.mpw01,
		OnClick = function()
			-- do twice to overcome Blizzard bug
			_G.InterfaceOptionsFrame_OpenToCategory(aObj.optionsFrame)
			_G.InterfaceOptionsFrame_OpenToCategory(aObj.optionsFrame)
		end,
		OnTooltipShow = function(tooltip)
			tooltip:AddLine(self.L["Skinner"])
			tooltip:AddLine(self.L["Click to open config panel"], 1, 1, 1)
		end,
	})

	-- register the data object to the Icon library
	self.DBIcon:Register(aName, self.DBObj, db.MinimapIcon)

	-- defer populating Disabled Skins panel until required
	self.RegisterCallback("Skinner_SO", "IOFPanel_Before_Skinning", function(_, panel)
		if panel.parent ~= self.L[aName] -- N.B. use localised name
		or panel.name ~= self.L["Disabled Skins"] -- N.B. use localised name
		then
			return
		end

		-- add Disabled Skins entries
		local function addDSOpt(name)--, lib, lod)
			aObj.optTables["Disabled Skins"].args[name] = {
				type = "toggle",
				name = name,
				desc = aObj.L["Toggle the skinning of "] .. name,
				width = name:len() > 22 and "double" or nil,
			}
		end
		for name, _ in _G.pairs(self.addonsToSkin) do
			if self:isAddonEnabled(name) then
				addDSOpt(name)
			end
		end
		for name, _ in _G.pairs(self.libsToSkin) do
			if _G.LibStub:GetLibrary(name, true) then
				addDSOpt(name .. " (Lib)")
			end
		end
		for name, _ in _G.pairs(self.lodAddons) do
			if self:isAddonEnabled(name) then
				addDSOpt(name .. " (LoD)")
			end
		end
		for name, _ in _G.pairs(self.otherAddons) do
			if self:isAddonEnabled(name) then
				if name == "tekKonfig" then
					addDSOpt(name .. " (Lib)")
				else
					addDSOpt(name)
				end
			end
		end
		addDSOpt = nil

		self.UnregisterCallback("Skinner_SO", "IOFPanel_Before_Skinning")

		-- ensure new entries are displayed
		-- N.B. AFTER callback is unregistered otherwise a stack overflow occurs
		_G.InterfaceOptionsList_DisplayPanel(panel)

	end)

end
