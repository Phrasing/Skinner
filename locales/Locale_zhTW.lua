-- Many thanks to ananhaid for the translation
local L = LibStub("AceLocale-3.0"):NewLocale("Skinner", "zhTW", false)

if not L then return end

-- option titles
L["Colours"] = "顏色"
L["Backdrop"] = "背景"
L["Gradient"] = "漸層"
L["VP/TMBFrames"] = "VP/TMB 框架"
L["PlayerFrames"] = "玩家框架"
L["UIFrames"] = "介面框架"
L["NPCFrames"] = "NPC 框架"
L["Profiles"] = "配置文件"

-- option names and descriptions
L["UI Enhancement"] = "介面增強"
L["Provides a Minimalist UI by removing the Blizzard textures"] = "移除暴雪材質并提供簡約介面"
L["Default Colours"] = "預設顏色"
L["Change the default colour settings"] = "更改預設顏色設定"
L["Tooltip Border Colors"] = "提示邊框顏色"
L["Set Tooltip Border Colors"] = "設定提示邊框顏色"
L["Border Colors"] = "邊框顏色"
L["Set Backdrop Border Colors"] = "設定背景邊框顏色"
L["Backdrop Colors"] = "背景顏色"
L["Set Backdrop Colors"] = "設定背景顏色"
L["Text Heading Colors"] = "文字標題顏色"
L["Set Text Heading Colors"] = "設定文字標題顏色"
L["Text Body Colors"] = "文字主體顏色"
L["Set Text Body Colors"] = "設定文字主體顏色"
L["Gradient Minimum Colors"] = "漸層淺色"
L["Set Gradient Minimum Colors"] = "設定漸層最淺顏色"
L["Gradient Maximum Colors"] = "漸層深色"
L["Set Gradient Maximum Colors"] = "設定漸層最深顏色"
L["Baggins Bank Bags Colour"] = "Baggins 銀行包裹顏色"
L["Set Baggins Bank Bags Colour"] = "設定 Baggins 銀行包裹顏色"
L["Default Backdrop"] = "預設背景"
L["Change the default backdrop settings"] = "更改預設背景設定"
L["Use Default Backdrop"] = "使用預設背景"
L["Toggle the Default Backdrop"] = "切換預設背景"
L["Backdrop Texture File"] = "背景材質檔案"
L["Set Backdrop Texture Filename"] = "設定背景材質檔案名稱"
L["Backdrop Texture"] = "背景材質"
L["Choose the Texture for the Backdrop"] = "選擇背景材質"
L["Backdrop TileSize"] = "背景塊"
L["Set Backdrop TileSize"] = "設定背景塊大小"
L["Border Texture File"] = "邊框材質檔案"
L["Set Border Texture Filename"] = "設定邊框材質檔案名稱"
L["Border Texture"] = "邊框材質"
L["Choose the Texture for the Border"] = "選擇邊框材質"
L["Border Width"] = "邊框寬度"
L["Set Border Width"] = "設定邊框寬度"
L["Border Inset"] = "邊框外掛程式"
L["Set Border Inset"] = "設定邊框外掛程式"
L["Textured Tab"] = "標籤材質"
L["Toggle the Texture of the Tabs"] = "切換標籤材質"
L["Textured DropDown"] = "下拉式功能表材質"
L["Toggle the Texture of the DropDowns"] = "切換下拉式功能表材質"
L["Show Warnings"] = "顯示警告"
L["Toggle the Showing of Warnings"] = "切換警告顯示"
L["Show Errors"] = "顯示錯誤"
L["Toggle the Showing of Errors"] = "切換錯誤顯示"
L["Change the Gradient Effect settings"] = "更改漸層效果設定"
L["Gradient Effect"] = "漸層效果"
L["Toggle the Gradient Effect"] = "切換漸層效果"
L["Invert Gradient"] = "反轉"
L["Invert the Gradient Effect"] = "反轉漸層效果"
L["Rotate Gradient"] = "旋轉"
L["Rotate the Gradient Effect"] = "旋轉漸層效果"
L["Enable Character Frames Gradient"] = "開啟角色表單漸層"
L["Enable the Gradient Effect for the Character Frames"] = "開啟角色表單漸層效果"
L["Enable UserInterface Frames Gradient"] = "開啟使用者介面表單漸層"
L["Enable the Gradient Effect for the UserInterface Frames"] = "開啟使用者介面表單漸層效果"
L["Enable NPC Frames Gradient"] = "開啟 NPC 表單漸層"
L["Enable the Gradient Effect for the NPC Frames"] = "開啟 NPC 表單漸層效果"
L["Enable Skinner Frames Gradient"] = "開啟 Skinner 框架漸層"
L["Enable the Gradient Effect for the Skinner Frames"] = "開啟 Skinner 設定的框架漸層效果"
L["Gradient Texture"] = "漸層材質"
L["Choose the Texture for the Gradient"] = "選擇漸層材質"
L["Fade Height"] = "淡化高度"
L["Change the Fade Height settings"] = "淡化高度設定"
L["Global Fade Height"] = "全域淡化高度"
L["Toggle the Global Fade Height"] = "切換全域淡化高度"
L["Fade Height value"] = "淡化高度值"
L["Change the Height of the Fade Effect"] = "改變淡化效果高度"
L["Force the Global Fade Height"] = "強制全域淡化高度"
L["Force ALL Frame Fade Height's to be Global"]= "強制全部框架應用全域淡化高度"
L["Skinning Delays"] = "裝飾延遲"
L["Change the Skinning Delays settings"] = "更改裝飾框架延遲設定"
L["Initial Delay"] = "初始化延遲"
L["Set the Delay before Skinning Blizzard Frames"] = "設定裝飾暴雪預設框架前延遲"
L["Addons Delay"] = "插件延遲"
L["Set the Delay before Skinning Addons Frames"] = "設定裝飾插件框架前延遲"
L["LoD Addons Delay"] = "動態載入插件延遲"
L["Set the Delay before Skinning Load on Demand Frames"] = "設定裝飾動態載入插件框架前延遲"
L["ViewPort & TMB Frames"] = "視埠和 TMB 框架"
L["Change the ViewPort & TMB Frames settings"] = "更改視埠（VP）和 TMB 框架設定"
L["View Port"] = "視埠（VP）"
L["Change the ViewPort settings"] = "更改視埠設定"
L["VP Top"] = "VP 頂部"
L["Change Height of the Top Band"] = "更改頂部鑲邊高度"
L["VP Bottom"] = "VP 底部"
L["Change Height of the Bottom Band"] = "更改底部鑲邊高度"
L["VP YResolution"] = "VP Y 解析度"
L["Change Y Resolution"] = "設定 Y 解析度"
L["VP Left"] = "VP 左邊"
L["Change Width of the Left Band"] = "設定左鑲邊寬度"
L["VP Right"] = "VP 右邊"
L["Change Width of the Right Band"] = "設定右鑲邊寬度"
L["VP XResolution"] = "VP X 解析度"
L["Change X Resolution"] = "設定 X 解析度"
L["ViewPort Show"] = "視埠顯示"
L["Toggle the ViewPort"] = "切換視埠顯示"
L["ViewPort Overlay"] = "視埠覆蓋"
L["Toggle the ViewPort Overlay"] = "切換視埠覆蓋"
L["ViewPort Colors"] = "視埠顏色"
L["Set ViewPort Colors"] = "設定視埠顏色"
L["Top Frame"] = "頂部框架（TF）"
L["Change the TopFrame settings"] = "更改頂部框架設定"
L["TF Move Origin offscreen"] = "TF 移動原螢幕"
L["Hide Border on Left and Top"] = "隱藏左側與頂部邊框"
L["TF Height"] = "TF 高度"
L["Change Height of the TopFrame"] = "更改頂部框架高度"
L["TF Width"] = "TF 寬度"
L["Change Width of the TopFrame"] = "更改頂部框架寬度"
L["TF Fade Height"] = "TF 淡化高度"
L["Change the Height of the Fade Effect"] = "更改頂部框架淡化效果"
L["TopFrame Show"] = "頂部框架顯示"
L["Toggle the TopFrame"] = "切換頂部框架顯示"
L["TF Toggle Border"] = "TF 切換邊框"
L["BF Toggle Border"] = "BF 切換邊框"
L["Toggle the Border"] = "切換此邊框"
L["TF Alpha"] = "TF 透明度"
L["Change Alpha value of the TopFrame"] = "更改 TF 透明度"
L["TF Invert Gradient"] = "TF 反轉漸層"
L["Toggle the Inversion of the Gradient"] = "切換反轉漸層"
L["TF Rotate Gradient"] = "TF 旋轉漸層"
L["Toggle the Rotation of the Gradient"] = "切換旋轉漸層"
L["Middle Frame(s)"] = "中間框架（MF）"
L["Change the MiddleFrame(s) settings"] = "更改中間框架設定"
L["MF Fade Height"] = "MF 淡化高度"
L["Change the Height of the Fade Effect"] = "更改淡化效果高度"
L["MF Toggle Border"] = "MF 切換邊框"
L["Toggle the Border"] = "切換此邊框"
L["MF Colour"] = "MF 顏色"
L["Change the Colour of the MiddleFrame(s)"] = "更改中間框架顏色"
L["MF Lock Frames"] = "MF 鎖定框架"
L["Toggle the Frame Lock"] = "切換 MF 框架鎖定"
L["Middle Frame1"] = "中間框架1"
L["Change MiddleFrame1 settings"] = "變更中間框架1設定"
L["MiddleFrame1 Show"] = "中間框架1顯示"
L["Toggle the MiddleFrame1"] = "切換顯示中間框架1"
L["MF1 Frame Level"] = "中間框架1等級"
L["Change the MF1 Frame Level"] = "切換顯示中間框架1等級"
L["MF1 Frame Strata"] = "中間框架1階層"
L["Change the MF1 Frame Strata"] = "切換中間框架1階層"
L["Middle Frame2"] = "中間框架2"
L["Change MiddleFrame2 settings"] = "變更中間框架2設定"
L["MiddleFrame2 Show"] = "顯示中間框架2"
L["Toggle the MiddleFrame2"] = "切換顯示中間框架2"
L["MF2 Frame Level"] = "中間框架2等級"
L["Change the MF2 Frame Level"] = "切換顯示中間框架2等級"
L["MF2 Frame Strata"] = "中間框架2階層"
L["Change the MF2 Frame Strata"] = "切換中間框架2階層"
L["Middle Frame3"] = "中間框架3"
L["Change MiddleFrame3 settings"] = "變更中間框架3設定"
L["MiddleFrame3 Show"] = "顯示中間框架3"
L["Toggle the MiddleFrame3"] = "切換顯示中間框架3"
L["MF3 Frame Level"] = "中間框架3等級"
L["Change the MF3 Frame Level"] = "切換顯示中間框架3等級"
L["MF3 Frame Strata"] = "中間框架3階層"
L["Change the MF3 Frame Strata"] = "切換中間框架3階層"
L["Middle Frame4"] = "中間框架4"
L["Change MiddleFrame4 settings"] = "變更中間框架4設定"
L["MiddleFrame4 Show"] = "顯示中間框架4"
L["Toggle the MiddleFrame4"] = "切換顯示中間框架4"
L["MF4 Frame Level"] = "中間框架4等級"
L["Change the MF4 Frame Level"] = "切換顯示中間框架4等級"
L["MF4 Frame Strata"] = "中間框架4階層"
L["Change the MF4 Frame Strata"] = "切換中間框架4階層"
L["Middle Frame5"] = "中間框架5"
L["Change MiddleFrame5 settings"] = "變更中間框架5設定"
L["MiddleFrame5 Show"] = "顯示中間框架5"
L["Toggle the MiddleFrame5"] = "切換顯示中間框架5"
L["MF5 Frame Level"] = "中間框架5等級"
L["Change the MF5 Frame Level"] = "切換顯示中間框架5等級"
L["MF5 Frame Strata"] = "中間框架5階層"
L["Change the MF5 Frame Strata"] = "切換中間框架5階層"
L["Middle Frame6"] = "中間框架6"
L["Change MiddleFrame6 settings"] = "變更中間框架6設定"
L["MiddleFrame6 Show"] = "顯示中間框架6"
L["Toggle the MiddleFrame6"] = "切換顯示中間框架6"
L["MF6 Frame Level"] = "中間框架6等級"
L["Change the MF6 Frame Level"] = "切換顯示中間框架6等級"
L["MF6 Frame Strata"] = "中間框架6階層"
L["Change the MF6 Frame Strata"] = "切換中間框架6階層"
L["Middle Frame7"] = "中間框架7"
L["Change MiddleFrame7 settings"] = "變更中間框架7設定"
L["MiddleFrame7 Show"] = "顯示中間框架7"
L["Toggle the MiddleFrame7"] = "切換顯示中間框架7"
L["MF7 Frame Level"] = "中間框架7等級"
L["Change the MF7 Frame Level"] = "切換顯示中間框架7等級"
L["MF7 Frame Strata"] = "中間框架7階層"
L["Change the MF7 Frame Strata"] = "切換中間框架7階層"
L["Middle Frame8"] = "中間框架8"
L["Change MiddleFrame8 settings"] = "變更中間框架8設定"
L["MiddleFrame8 Show"] = "顯示中間框架8"
L["Toggle the MiddleFrame8"] = "切換顯示中間框架8"
L["MF8 Frame Level"] = "中間框架8等級"
L["Change the MF8 Frame Level"] = "切換顯示中間框架8等級"
L["MF8 Frame Strata"] = "中間框架8階層"
L["Change the MF8 Frame Strata"] = "切換中間框架8階層"
L["Middle Frame9"] = "中間框架9"
L["Change MiddleFrame9 settings"] = "變更中間框架9設定"
L["MiddleFrame9 Show"] = "顯示中間框架9"
L["Toggle the MiddleFrame9"] = "切換顯示中間框架9"
L["MF9 Frame Level"] = "中間框架9等級"
L["Change the MF9 Frame Level"] = "切換顯示中間框架9等級"
L["MF9 Frame Strata"] = "中間框架9階層"
L["Change the MF9 Frame Strata"] = "切換中間框架9階層"
L["Bottom Frame"] = "底部框架（BF）"
L["Change the BottomFrame settings"] = "更改底部框架設定"
L["BF Move Origin offscreen"] = "BF 移動原螢幕"
L["Hide Border on Left and Bottom"] = "隱藏左側與底部邊框"
L["BF Height"] = "BF 高度"
L["Change Height of the BottomFrame"] = "更改底部框架高度"
L["BF Width"] = "BF 寬度"
L["Change Width of the BottomFrame"] = "更改底部框架寬度"
L["BF Fade Height"] = "BF 淡化高度"
L["Change the Height of the Fade Effect"] = "更改底部框架淡化效果"
L["BottomFrame Show"] = "底部框架"
L["Toggle the BottomFrame"] = "切換顯示底部框架"
L["BF Alpha"] = "BF 透明度"
L["Change Alpha value of the BottomFrame"] = "更改 BF 透明度"
L["BF Invert Gradient"] = "BF 反轉漸層"
L["BF Rotate Gradient"] = "BF 旋轉漸層"
L["StatusBar"] = "狀態條"
L["Change the StatusBar settings"] = "更改狀態條設定"
L["Texture"]= "材質"
L["Choose the Texture for the Status Bars"] = "選擇狀態條材質"
L["Background Colour"]= "背景顏色"
L["Change the Colour of the Status Bar Background"]= "變更狀態條背景顏色"
L["Character Frames"] = "角色資訊框架"
L["Change the Character Frames settings"] = "更改角色資訊框架設定"
L["Disable all Character Frames"] = "取消全部角色框架"
L["Disable all the Character Frames from being skinned"] = "取消裝飾全部角色資訊框架"
L["Character Frames"] = "角色框架"
L["Toggle the skin of the Character Frames"] = "切換角色框架介面"
L["PVP Frame"] = "PvP 框架"
L["Toggle the skin of the PVP Frame"] = "切換 PvP 框架皮膚"
L["SpellBook Frame"] = "法術書框架"
L["Toggle the skin of the SpellBook Frame"] = "切換法術書框架介面"
L["Talent Frame"] = "天賦框架"
L["Toggle the skin of the Talent Frame"] = "切換天賦框架介面"
L["DressUp Frame"] = "更衣室框架"
L["Toggle the skin of the DressUp Frame"] = "切換更衣室框架介面"
L["Social Frame"] = "社交框架"
L["Toggle the skin of the Social Frame"] = "切換社交框架介面"
L["Trade Skill Frame"] = "商業技能框架"
L["Toggle the skin of the Trade Skill Frame"] = "切換商業技能框架介面"
L["Craft Frame"] = "製作框架"
L["Toggle the skin of the Craft Frame"] = "切換製作框架介面"
L["Trade Frame"] = "交易框架"
L["Toggle the skin of the Trade Frame"] = "切換交易框架介面"
L["Quest Log"] = "任務日誌"
L["Change the Quest Log settings"] = "更改任務日誌設定"
L["Quest Log Skin"] = "任務日誌介面"
L["Toggle the skin of the Quest Log Frame"] = "切換任務日誌框架介面"
L["Quest Watch Size"] = "任務監視尺寸"
L["Set the Quest Watch Font Size (Normal, Small)"] = "設定任務監視字體尺寸（普通，小）"
L["RaidUI Frame"] = "團隊介面框架"
L["Toggle the skin of the RaidUI Frame"] = "切換團隊介面框架介面"
L["ReadyCheck Frame"] = "就位確認框架"
L["Toggle the skin of the ReadyCheck Frame"] = "切換就位確認框架皮膚"
L["Buffs Buttons"]= "增益按鈕"
L["Toggle the skin of the Buffs Buttons"]= "切換增益按鈕介面"
L["AchievementUI"] = "成就介面"
L["Change the AchievementUI settings"] = "更改成就介面設定"
L["Achievements Frame"] = "成就框架"
L["Toggle the skin of the Achievements Frame"] = "切換成就框架皮膚"
L["Achievement Alerts"] = "成就提示"
L["Toggle the skin of the Achievement Alerts"] = "切換成就提示皮膚"
L["Achievement Watch"] = "成就監視"
L["Toggle the skin of the Achievement Watch"] = "切換成就監視皮膚"
L["Vehicle Menu Bar"] = "載具菜單條"
L["Toggle the skin of the Vehicle Menu Bar"] = "切換載具菜單條皮膚"
L["UI Frames"] = "介面框架"
L["Change the UI Elements settings"] = "切換介面框架介面"
L["Disable all UI Frames"] = "關閉全部介面框架"
L["Disable all the UI Frames from being skinned"] = "禁止裝飾全部介面框架"
L["Tooltips"] = "提示"
L["Change the Tooltip settings"] = "更改提示設定"
L["Tooltips Border Colour"] = "提示邊框顏色"
L["Set the Tooltips Border colour (Default, Custom)"] = "設定提示邊框顏色（預設，自訂）"
L["Tooltip Skin"] = "提示介面"
L["Toggle the skin of the Tooltips"] = "切換提示介面"
L["Tooltips Style"] = "提示風格"
L["Set the Tooltips style (Rounded, Flat, Custom)"] = "設定提示風格（環繞，平面，自訂）"
L["Glaze Status Bar"] = "玻璃化狀態列"
L["Toggle the glazing Status Bar"] = "切換玻璃化狀態列"
L["Timer Frames"] = "計時器框架"
L["Change the Timer Settings"] = "更改計時器框架設定"
L["Timer Skin"] = "計時器介面"
L["Toggle the skin of the Timer"] = "切換計時器框架介面"
L["Glaze Timer"] = "玻璃化計時器"
L["Toggle the glazing Timer"] = "切換玻璃化計時器"
L["Casting Bar Frame"] = "施法條框架"
L["Change the Casting Bar Settings"] = "更改施法條設定"
L["Casting Bar Skin"] = "施法條介面"
L["Toggle the skin of the Casting Bar"] = "切換施法條框架介面"
L["Glaze Casting Bar"] = "玻璃化施法條"
L["Toggle the glazing Casting Bar"] = "切換玻璃化施法條"
L["Static Popups"] = "靜態彈出"
L["Toggle the skin of Static Popups"] = "切換靜態彈出介面"
L["Chat Sub Frames"] = "聊天子框架"
L["Change the Chat Sub Frames"] = "更改聊天子框架"
L["Chat Menus"] = "聊天功能表"
L["Toggle the skin of the Chat Menus"] = "切換聊天功能表介面"
L["Chat Config"] = "聊天設定"
L["Toggle the skinning of the Chat Config Frame"] = "切換聊天設定框架介面"
L["Chat Tabs"] = "聊天標籤"
L["Toggle the skin of the Chat Tabs"] = "切換聊天標籤介面"
L["Chat Frames"] = "聊天框架"
L["Toggle the skin of the Chat Frames"] = "切換聊天框架介面"
L["CombatLog Quick Button Frame"] = "戰鬥紀錄快速鈕框架"
L["Toggle the skin of the CombatLog Quick Button Frame"] = "切換戰鬥紀錄快速鈕框架介面"
L["Chat Edit Box"] = "聊天輸入方塊"
L["Change the Chat Edit Box settings"] = "更改聊天對話框設定"
L["Chat Edit Box Skin"] = "聊天輸入方塊介面"
L["Toggle the skin of the Chat Edit Box Frame"]= "切換聊天輸入方塊框架介面"
L["Chat Edit Box Style"] = "聊天輸入方塊風格"
L["Set the Chat Edit Box style (Frame, EditBox)"] = "設定聊天輸入方塊風格（框架，輸入方塊）"
L["Loot Frame"] = "拾取框架"
L["Toggle the skin of the Loot Frame"] = "切換拾取框架介面"
L["Group Loot Frame"] = "隊伍拾取框架"
L["Change the GroupLoot settings"] = "更改隊伍拾取設定"
L["GroupLoot Skin"] = "隊伍拾取介面"
L["Toggle the skin of the GroupLoot Frame"] = "切換隊伍拾取框架介面"
L["GroupLoot Size"] = "隊伍拾取大小"
L["Set the GroupLoot size (Normal, Small, Micro)"] = "設定隊伍拾取框架大小（普通，小型，微型）"
L["Container Frames"] = "容器框架"
L["Change the Container Frames settings"] = "更改容器框架設定"
L["Containers Skin"] = "容器皮膚"
L["Toggle the skin of the Container Frames"] = "切換容器框架介面"
L["CF Fade Height"] = "CF 淡化高度"
L["Change the Height of the Fade Effect"] = "更改淡化效果高度"
L["Stack Split Frame"] = "堆疊分割框架"
L["Toggle the skin of the Stack Split Frame"] = "切換堆疊分割框架介面"
L["Item Text Frame"] = "物品文字框架"
L["Toggle the skin of the Item Text Frame"] = "切換物品文字框架介面"
L["Color Picker Frame"] = "拾取顏色框架"
L["Toggle the skin of the Color Picker Frame"] = "切換拾取顏色框架介面"
L["World Map Frame"] = "世界地圖框架"
L["Change the World Map settings"] = "更改世界地圖設定"
L["World Map Skin"] = "世界地圖皮膚"
L["Toggle the skin of the World Map Frame"] = "切換世界地圖框架皮膚"
L["World Map Size"] = "世界地圖大小"
L["Set the World Map size (Normal, Fullscreen)"] = "設定世界地圖大小（普通，全螢幕）"
L["Inspect Frame"] = "觀察框架"
L["Toggle the skin of the Inspect Frame"] = "切換觀察框架介面"
L["Battle Score Frame"] = "戰場積分框架"
L["Toggle the skin of the Battle Score Frame"] = "切換戰場積分框架介面"
L["Script Errors Frame"] = "腳本錯誤框架"
L["Toggle the skin of the Script Errors Frame"] = "切換腳本錯誤框架介面"
L["Tutorial Frame"] = "私人框架"
L["Toggle the skin of the Tutorial Frame"] = "切換私人框架介面"
L["DropDowns"] = "下拉式功能表"
L["Toggle the skin of the DropDowns"] = "切換下拉式功能表介面"
L["Minimap Options"] = "小地圖選項"
L["Change the Minimap Options"] = "更改小地圖選項"
L["Minimap Buttons"] = "小地圖按鈕"
L["Toggle the skin of the Minimap Buttons"] = "切換小地圖按鈕介面"
L["Minimap Gloss Effect"]= "小地圖光澤效果"
L["Toggle the Gloss Effect for the Minimap"]= "切換小地圖光澤效果"
L["Help Request Frames"] = "幫助請求框架"
L["Change the Help Request Frames"] = "更改幫助請求框架"
L["Help Frame"] = "説明框架"
L["Toggle the skin of the Help Frame"] = "切換説明框架的介面"
L["Menu Frames"] = "功能表框架"
L["Toggle the skin of the Menu Frames"] = "切換功能表框架介面"
L["Bank Frame"] = "銀行框架"
L["Toggle the skin of the Bank Frame"] = "切換銀行框架介面"
L["Mail Frame"] = "郵件框架"
L["Toggle the skin of the Mail Frame"] = "切換郵件框架介面"
L["Auction Frame"] = "拍賣場框架"
L["Toggle the skin of the Auction Frame"] = "切換拍賣場框架介面"
L["Main Menu Bar"] = "主功能表列"
L["Change the Main Menu Bar Frame Settings"] = "更改主菜單欄框架設定"
L["Main Menu Bar Skin"] = "主功能表列介面"
L["Toggle the skin of the Main Menu Bar"] = "切換主功能表列介面"
L["Glaze Main Menu Bar Status Bar"] = "玻璃化主功能表狀態列"
L["Toggle the glazing Main Menu Bar Status Bar"] = "切換玻璃化主功能表狀態列"
L["Coin Pickup Frame"] = "拾取錢幣框架"
L["Toggle the skin of the Coin Pickup Frame"] = "切換拾取錢幣框架介面"
L["GM Survey UI Frame"] = "GM 調查介面框架"
L["Toggle the skin of the GM Survey UI Frame"] = "切換 GM 調查介面框架介面"
L["LFG Frame"] = "尋求組隊框架"
L["Toggle the skin of the LFG Frame"] = "切換尋求組隊框架介面"
L["ItemSocketingUI Frame"] = "物品鑲嵌框架"
L["Toggle the skin of the ItemSocketingUI Frame"] = "切換物品鑲嵌框架介面"
L["GuildBankUI Frame"] = "公會銀行框架"
L["Toggle the skin of the GuildBankUI Frame"] = "切換公會銀行框架介面"
L["Nameplates"] = "姓名板"
L["Toggle the skin of the Nameplates"] = "切換姓名板介面"
L["Time Manager"] = "時間管理器"
L["Toggle the skin of the Time Manager Frame"] = "切換時間管理器介面"
L["Calendar"] = "日歷"
L["Toggle the skin of the Calendar Frame"] = "切換日歷框架皮膚"
L["Feedback"] = "反饋"
L["Toggle the skin of the Feedback Frame"] = "切換反饋框架皮膚"
L["Movie Progress"] = "Movie Progress"
L["Toggle the skinning of Movie Progress"] = "切換 Movie Progress 介面"
L["NPC Frames"] = "NPC 框架"
L["Change the NPC Frames settings"] = "更改 NPC 框架設定"
L["Disable all NPC Frames"] = "禁止全部 NPC 框架"
L["Disable all the NPC Frames from being skinned"] = "禁止裝飾全部 NPC 框架"
L["Merchant Frames"] = "商人框架"
L["Toggle the skin of the Merchant Frame"] = "切換商人框架介面"
L["Gossip Frame"] = "閒聊框架"
L["Toggle the skin of the Gossip Frame"] = "切換閒聊框架介面"
L["Class Trainer Frame"] = "職業訓練師框架"
L["Toggle the skin of the Class Trainer Frame"] = "切換職業訓練師框架介面"
L["Stable Frame"] = "坐騎框架"
L["Toggle the skin of the Stable Frame"] = "切換坐騎框架介面"
L["Taxi Frame"] = "鳥點框架"
L["Toggle the skin of the Taxi Frame"] = "切換鳥點框架介面"
L["Quest Frame"] = "任務框架"
L["Toggle the skin of the Quest Frame"] = "切換任務框架介面"
L["Battlefields Frame"] = "戰場框架"
L["Toggle the skin of the Battlefields Frame"] = "切換戰場框架介面"
L["Battlefield Minimap Frame"] = "戰場小地圖框架"
L["Toggle the skin of the Battlefield Minimap Frame"] = "切換戰場小地圖框架介面"
L["Arena Frame"] = "競技場框架"
L["Toggle the skin of the Arena Frame"] = "切換競技場框架介面"
L["Arena Registrar Frame"] = "競技場註冊框架"
L["Toggle the skin of the Arena Registrar Frame"] = "切換競技場註冊框架介面"
L["Guild Registrar Frame"] = "公會註冊框架"
L["Toggle the skin of the Guild Registrar Frame"] = "切換公會註冊框架介面"
L["Petition Frame"] = "請求框架"
L["Toggle the skin of the Petition Frame"] = "切換請求框架介面"
L["Tabard Frame"] = "公會徽章框架"
L["Toggle the skin of the Tabard Frame"] = "切換公會徽章框架介面"
L["Barbershop Frame"] = "理發店框架"
L["Toggle the skin of the Barbershop Frame"] = "切換理發店框架皮膚"
L["Tracker Frame"] = "追蹤框架"
L["Change the Tracker Frame settings"] = "更改追蹤框架設定"
L["Skin Tracker Frame"] = "介面追蹤框架"
L["Toggle the skin of the Tracker Frame"] = "切換追蹤框架介面"
L["Clean Textures"] = "清除文本"
L["Remove Blizzard Textures"] = "移除暴雪文本"
L["Minimap icon"] = "小地圖圖示"
L["Toggle the minimap icon"] = "切換小地圖圖示"
L["Skin Settings"] = "皮膚設定"
L["Frames"] = "框架"
L["Other Settings"] = "其它設定"
L["Confirm reload of UI to activate profile changes"] = "確認配置文件改變并重新加載介面"
L["GMChatUI Frame"] = "GM 聊天介面框架"
L["Toggle the skin of the GMChatUI Frame"] = "切換 GM 聊天介面框架皮膚"
L["Gear Manager Frame"] = "工具管理框架"
L["Toggle the skin of the Gear Manager Frame"] = "切換工具管理框架皮膚"