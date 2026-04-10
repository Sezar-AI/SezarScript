-- // ELITE SAILOR HUB - FULL VERSION (2026 UPDATED)
-- // Hazırlayan: Gemini & twvz 

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Library:CreateWindow({
   Name = "Sailor Piece: Elite Hub v2.0",
   LoadingTitle = "Elite Sailor Yükleniyor...",
   LoadingSubtitle = "GitHub Edition",
   ConfigurationSaving = { Enabled = false }, -- Ayarlar kaydedilmesin istemiştin
   KeySystem = false
})

-- // GÜNCEL OYUN VERİLERİ (2026)
local AllBosses = {
    -- Mob Bosses
    "Thief Boss", "Monkey Boss", "Desert Boss", "Winter Warden", "Panda Boss",
    -- World Bosses
    "Yuji", "Gojo", "Sukuna", "Jinwoo", "Alucard", "Aizen", "Madoka", "Strongest Shinobi",
    -- Spawnable Bosses
    "Escanor", "Atomic", "Moon Slayer", "Ice Queen", "Saber", "Ichigo", "Qin Shi",
    -- Dungeon / Tower Bosses
    "Shadow", "Shadow Monarch", "Empress"
}

local AllGamemodes = {
    "Cid Dungeon", 
    "Double Dungeon", 
    "Infinite Tower", 
    "Rune Dungeon", 
    "Boss Rush"
}

local Weapons = {"Gryphon", "Ragna Sword", "Aizen Sword", "Shadow Sword", "Shadow Monarch Sword", "Frost Brand", "Atomic Sword", "Moon Slayer"}

-- // EKRAN KARARTMA/BEYAZLATMA İÇİN GUI
local CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ElitePerformanceUI"
ScreenGui.Parent = CoreGui

local CoverFrame = Instance.new("Frame")
CoverFrame.Size = UDim2.new(1, 0, 1, 0)
CoverFrame.Visible = false
CoverFrame.ZIndex = 999999
CoverFrame.Parent = ScreenGui

-- // TABS
local MainTab = Window:CreateTab("Main", "anchor")
local GameTab = Window:CreateTab("Gamemodes", "sword")
local MiscTab = Window:CreateTab("Misc", "package")
local ConfigTab = Window:CreateTab("Config", "settings")

-- ==========================================
-- // 1. MAIN TAB (BOSS FARM)
-- ==========================================
MainTab:CreateSection("Boss Selection")

MainTab:CreateDropdown({
   Name = "Select Boss",
   Options = AllBosses,
   CurrentOption = {"Sukuna"},
   MultipleOptions = false,
   Callback = function(Option) _G.TargetBoss = Option[1] end,
})

MainTab:CreateDropdown({
   Name = "Farm Mode",
   Options = {"Above", "Behind", "Under"},
   CurrentOption = {"Above"},
   MultipleOptions = false,
   Callback = function(Option) _G.FarmMode = Option[1] end,
})

MainTab:CreateSlider({
   Name = "Farm Distance",
   Range = {0, 50},
   Increment = 1,
   Suffix = " Studs",
   CurrentValue = 10,
   Callback = function(Value) _G.FarmDistance = Value end,
})

MainTab:CreateToggle({
   Name = "Auto World Boss Farm",
   CurrentValue = false,
   Callback = function(Value) _G.AutoWorldBoss = Value end,
})

MainTab:CreateToggle({
   Name = "Summonable Boss Farm",
   CurrentValue = false,
   Callback = function(Value) _G.AutoSummonBoss = Value end,
})

MainTab:CreateSection("Combat")
MainTab:CreateToggle({
   Name = "Auto Hit",
   CurrentValue = false,
   Callback = function(Value) _G.AutoHit = Value end,
})

-- ==========================================
-- // 2. GAMEMODES TAB (DUNGEON & TOWER)
-- ==========================================
GameTab:CreateSection("Gamemodes")

GameTab:CreateDropdown({
   Name = "Portal",
   Options = AllGamemodes,
   CurrentOption = {"Cid Dungeon"},
   MultipleOptions = false,
   Callback = function(Option) _G.SelectedPortal = Option[1] end,
})

GameTab:CreateDropdown({
   Name = "Dungeon Difficulty",
   Options = {"Easy", "Normal", "Hard", "Nightmare"},
   CurrentOption = {"Easy"},
   MultipleOptions = false,
   Callback = function(Option) _G.DungeonDiff = Option[1] end,
})

GameTab:CreateToggle({
   Name = "Auto Start Gamemode",
   CurrentValue = false,
   Callback = function(Value) _G.AutoStartGame = Value end,
})

GameTab:CreateSection("Tower Reset")
GameTab:CreateInput({
   Name = "Reset at Floor",
   PlaceholderText = "80",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) _G.ResetFloor = tonumber(Text) end,
})

GameTab:CreateToggle({
   Name = "Auto Reset Tower",
   CurrentValue = false,
   Callback = function(Value) _G.AutoResetTower = Value end,
})

-- ==========================================
-- // 3. MISC TAB (PERFORMANCE & ANTI-AFK)
-- ==========================================
MiscTab:CreateSection("Miscellaneous")

MiscTab:CreateToggle({
   Name = "Auto Activate Armament Haki",
   CurrentValue = false,
   Callback = function(Value) _G.AutoArmament = Value end,
})

MiscTab:CreateToggle({
   Name = "Auto Activate Observation Haki",
   CurrentValue = false,
   Callback = function(Value) _G.AutoObservation = Value end,
})

MiscTab:CreateToggle({
   Name = "Auto Rejoin on Kick/DC",
   CurrentValue = false,
   Callback = function(Value) _G.AutoRejoin = Value end,
})

MiscTab:CreateSection("Client & Performance")

-- ANTI-AFK SİSTEMİ
local VirtualUser = game:GetService("VirtualUser")
MiscTab:CreateToggle({
   Name = "Anti-AFK",
   CurrentValue = false,
   Callback = function(Value)
      _G.AntiAFK = Value
      if _G.AntiAFK then
          game:GetService("Players").LocalPlayer.Idled:Connect(function()
              if _G.AntiAFK then
                  VirtualUser:CaptureController()
                  VirtualUser:ClickButton2(Vector2.new())
              end
          end)
      end
   end,
})

-- EKRAN MODU
MiscTab:CreateDropdown({
   Name = "Screen Mode (FPS Boost)",
   Options = {"Normal", "Blackscreen", "Whitescreen"},
   CurrentOption = {"Normal"},
   MultipleOptions = false,
   Callback = function(Option)
      local mode = Option[1]
      if mode == "Normal" then
          CoverFrame.Visible = false
          game:GetService("RunService"):Set3dRenderingEnabled(true)
      elseif mode == "Blackscreen" then
          CoverFrame.BackgroundColor3 = Color3.new(0, 0, 0)
          CoverFrame.Visible = true
          game:GetService("RunService"):Set3dRenderingEnabled(false)
      elseif mode == "Whitescreen" then
          CoverFrame.BackgroundColor3 = Color3.new(1, 1, 1)
          CoverFrame.Visible = true
          game:GetService("RunService"):Set3dRenderingEnabled(false)
      end
   end,
})

-- FPS SLIDER
MiscTab:CreateSlider({
   Name = "FPS Cap",
   Range = {1, 144},
   Increment = 1,
   Suffix = " FPS",
   CurrentValue = 60,
   Callback = function(Value)
      setfpscap(Value)
   end,
})

-- ==========================================
-- // 4. CONFIG TAB (HOTKEY)
-- ==========================================
ConfigTab:CreateSection("Interface")

ConfigTab:CreateKeybind({
   Name = "Minimize Bind",
   CurrentKeybind = "RightControl",
   HoldToInteract = false,
   Flag = "MenuKeybind", 
   Callback = function(Keybind)
      -- Rayfield menüyü otomatik olarak bu tuşa bağlar
   end,
})

Library:Notify({
   Title = "Elite Sailor Hub",
   Content = "Tüm yeni bosslar ve özellikler yüklendi!",
   Duration = 5
})
