-- =============================================================================
-- GRANNY MULTIPLAYER ESP - FULL GUI
-- =============================================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- =============================================================================
-- ESP STATE
-- =============================================================================
local ESP_TRACKING_CACHE = {}

local TOGGLES = {
    -- Enemies
    granny        = true,
    grandpa       = true,
    slendrina     = true,
    spider        = true,
    -- Keys
    keys          = true,
    -- Tools
    tools         = true,
    -- Vehicles
    vehicles      = true,
    -- Puzzles
    puzzles       = true,
    -- Weapons
    weapons       = true,
    -- Fuel & Parts
    fuel          = true,
}

local ITEM_CONFIG = {
    -- Keys
    ["master key"]       = { color = Color3.fromRGB(255, 0, 0),     category = "keys" },
    ["padlock key"]      = { color = Color3.fromRGB(255, 215, 0),   category = "keys" },
    ["playhouse key"]    = { color = Color3.fromRGB(255, 215, 0),   category = "keys" },
    ["car key"]          = { color = Color3.fromRGB(255, 215, 0),   category = "keys" },
    ["weapon key"]       = { color = Color3.fromRGB(255, 215, 0),   category = "keys" },
    ["special key"]      = { color = Color3.fromRGB(255, 215, 0),   category = "keys" },
    ["safe key"]         = { color = Color3.fromRGB(255, 215, 0),   category = "keys" },
    ["spider key"]       = { color = Color3.fromRGB(255, 215, 0),   category = "keys" },
    ["security key"]     = { color = Color3.fromRGB(255, 215, 0),   category = "keys" },
    ["shed key"]         = { color = Color3.fromRGB(255, 215, 0),   category = "keys" },
    ["helicopter key"]   = { color = Color3.fromRGB(255, 215, 0),   category = "keys" },
    ["boat key"]         = { color = Color3.fromRGB(255, 215, 0),   category = "keys" },
    ["train key"]        = { color = Color3.fromRGB(255, 215, 0),   category = "keys" },
    ["ticket"]           = { color = Color3.fromRGB(255, 215, 0),   category = "keys" },
    -- Tools
    ["hammer"]           = { color = Color3.fromRGB(255, 127, 80),  category = "tools" },
    ["cutting pliers"]   = { color = Color3.fromRGB(255, 127, 80),  category = "tools" },
    ["wire cutter"]      = { color = Color3.fromRGB(255, 127, 80),  category = "tools" },
    ["chain cutter"]     = { color = Color3.fromRGB(255, 127, 80),  category = "tools" },
    ["cogwheel"]         = { color = Color3.fromRGB(255, 127, 80),  category = "tools" },
    ["wrench"]           = { color = Color3.fromRGB(255, 127, 80),  category = "tools" },
    ["crowbar"]          = { color = Color3.fromRGB(255, 127, 80),  category = "tools" },
    ["screwdriver"]      = { color = Color3.fromRGB(255, 127, 80),  category = "tools" },
    ["winch handle"]     = { color = Color3.fromRGB(255, 127, 80),  category = "tools" },
    ["lockpick"]         = { color = Color3.fromRGB(255, 127, 80),  category = "tools" },
    ["remote control"]   = { color = Color3.fromRGB(255, 127, 80),  category = "tools" },
    ["code"]             = { color = Color3.fromRGB(255, 255, 255), category = "tools" },
    -- Fuel & Parts
    ["car battery"]      = { color = Color3.fromRGB(255, 20, 147),  category = "fuel" },
    ["battery"]          = { color = Color3.fromRGB(255, 20, 147),  category = "fuel" },
    ["gas canister"]     = { color = Color3.fromRGB(255, 20, 147),  category = "fuel" },
    ["gasoline"]         = { color = Color3.fromRGB(255, 20, 147),  category = "fuel" },
    ["spark plug"]       = { color = Color3.fromRGB(255, 20, 147),  category = "fuel" },
    ["engine part"]      = { color = Color3.fromRGB(0, 0, 0),       category = "fuel" },
    ["generator cable"]  = { color = Color3.fromRGB(255, 20, 147),  category = "fuel" },
    ["duct tape"]        = { color = Color3.fromRGB(255, 20, 147),  category = "fuel" },
    -- Puzzles
    ["fuse"]             = { color = Color3.fromRGB(0, 250, 154),   category = "puzzles" },
    ["plank"]            = { color = Color3.fromRGB(0, 250, 154),   category = "puzzles" },
    ["teddy bear"]       = { color = Color3.fromRGB(0, 250, 154),   category = "puzzles" },
    ["coconut"]          = { color = Color3.fromRGB(0, 250, 154),   category = "puzzles" },
    ["coin"]             = { color = Color3.fromRGB(0, 250, 154),   category = "puzzles" },
    ["melon"]            = { color = Color3.fromRGB(0, 250, 154),   category = "puzzles" },
    ["meat"]             = { color = Color3.fromRGB(0, 250, 154),   category = "puzzles" },
    ["birdseed"]         = { color = Color3.fromRGB(0, 250, 154),   category = "puzzles" },
    ["book"]             = { color = Color3.fromRGB(0, 250, 154),   category = "puzzles" },
    ["matches"]          = { color = Color3.fromRGB(0, 250, 154),   category = "puzzles" },
    -- Weapons
    ["shotgun"]          = { color = Color3.fromRGB(0, 191, 255),   category = "weapons" },
    ["crossbow"]         = { color = Color3.fromRGB(0, 191, 255),   category = "weapons" },
    ["slingshot"]        = { color = Color3.fromRGB(0, 191, 255),   category = "weapons" },
    ["stun gun"]         = { color = Color3.fromRGB(0, 191, 255),   category = "weapons" },
    ["pepper spray"]     = { color = Color3.fromRGB(0, 191, 255),   category = "weapons" },
    ["freeze trap"]      = { color = Color3.fromRGB(0, 191, 255),   category = "weapons" },
    ["hand grenade"]     = { color = Color3.fromRGB(0, 191, 255),   category = "weapons" },
    -- Vehicles
    ["car"]              = { color = Color3.fromRGB(138, 43, 226),  category = "vehicles" },
    ["helicopter"]       = { color = Color3.fromRGB(138, 43, 226),  category = "vehicles" },
    ["boat"]             = { color = Color3.fromRGB(138, 43, 226),  category = "vehicles" },
    ["train"]            = { color = Color3.fromRGB(138, 43, 226),  category = "vehicles" },
}

-- =============================================================================
-- ESP LOGIC
-- =============================================================================
local function isHeldByPlayer(object)
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and object:IsDescendantOf(player.Character) then return true end
        local bp = player:FindFirstChildWhichIsA("Backpack")
        if bp and object:IsDescendantOf(bp) then return true end
    end
    return false
end

local function createESP(object, displayName, espColor, isAI)
    if ESP_TRACKING_CACHE[object] or object:FindFirstChild("_ESP") then return end
    ESP_TRACKING_CACHE[object] = true

    local targetPart = isAI
        and (object:WaitForChild("HumanoidRootPart", 3) or object:FindFirstChildWhichIsA("BasePart"))
        or (object:IsA("BasePart") and object or object:FindFirstChildWhichIsA("BasePart"))

    if not targetPart then ESP_TRACKING_CACHE[object] = nil return end

    local folder = Instance.new("Folder")
    folder.Name = "_ESP"
    folder.Parent = object

    local hl = Instance.new("Highlight")
    hl.Adornee = object
    hl.FillColor = espColor
    hl.FillTransparency = isAI and 0.6 or 0.5
    hl.OutlineColor = (espColor == Color3.fromRGB(0,0,0)) and Color3.fromRGB(255,255,255) or espColor
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = folder

    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 150, 0, 40)
    bb.AlwaysOnTop = true
    bb.ExtentsOffset = Vector3.new(0, isAI and 3 or 1.5, 0)
    bb.MaxDistance = 10000
    bb.Adornee = targetPart
    bb.Parent = folder

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = (espColor == Color3.fromRGB(0,0,0)) and Color3.fromRGB(255,255,255) or espColor
    lbl.TextStrokeTransparency = 0
    lbl.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    lbl.TextScaled = true
    lbl.Font = Enum.Font.SourceSansBold
    lbl.Parent = bb

    task.spawn(function()
        local cam = workspace.CurrentCamera
        while object and object.Parent and folder.Parent do
            if not isAI and isHeldByPlayer(object) then folder:Destroy() break end
            if cam and targetPart and targetPart.Parent then
                local dist = (cam.CFrame.Position - targetPart.Position).Magnitude
                lbl.Text = string.format(isAI and "⚠ %s\n[%d]" or "%s\n[%d]", string.upper(displayName), math.floor(dist))
            end
            task.wait(isAI and 0.05 or 0.3)
        end
        ESP_TRACKING_CACHE[object] = nil
    end)
end

local function clearESP(object)
    local folder = object:FindFirstChild("_ESP")
    if folder then folder:Destroy() end
    ESP_TRACKING_CACHE[object] = nil
end

local function checkAndApply(desc)
    local ln = string.lower(desc.Name)
    if string.find(ln, "prop") then return end

    -- Enemies
    if (ln == "granny" or ln == "grandpa" or ln == "slendrina") and desc:IsA("Model") and
        (desc:FindFirstChild("Humanoid") or desc:FindFirstChild("HumanoidRootPart")) then
        local cat = ln
        if not TOGGLES[cat] then return end
        local color = ln == "grandpa" and Color3.fromRGB(148,0,211)
            or ln == "slendrina" and Color3.fromRGB(255,105,180)
            or Color3.fromRGB(0,255,0)
        createESP(desc, desc.Name, color, true)
        return
    end

    -- Spider
    if string.find(ln, "spider") and desc:IsA("Model") and not string.find(ln,"key")
        and not string.find(ln,"room") and desc.Name ~= "Spiders" then
        if not TOGGLES.spider then return end
        if desc:FindFirstChildWhichIsA("BasePart") or desc:FindFirstChild("Humanoid") then
            createESP(desc, "BIG SPIDER", Color3.fromRGB(255,69,0), true)
        end
        return
    end

    -- Items
    local cfg = ITEM_CONFIG[ln]
    if cfg then
        if not TOGGLES[cfg.category] then return end
        if desc.Parent and string.lower(desc.Parent.Name) == ln then return end
        createESP(desc, desc.Name, cfg.color, false)
    end
end

local function refreshAllESP()
    -- Clear all existing
    for obj, _ in pairs(ESP_TRACKING_CACHE) do
        pcall(function() clearESP(obj) end)
    end
    ESP_TRACKING_CACHE = {}
    for _, desc in ipairs(workspace:GetDescendants()) do
        pcall(function() checkAndApply(desc) end)
    end
end

-- Initial scan
refreshAllESP()

workspace.DescendantAdded:Connect(function(desc)
    task.wait(0.4)
    pcall(function() checkAndApply(desc) end)
end)

-- =============================================================================
-- GUI
-- =============================================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GrannyESP"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = PlayerGui

-- ── Main Window ──────────────────────────────────
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 420)
mainFrame.Position = UDim2.new(0, 20, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(180, 0, 0)
stroke.Thickness = 1.5
stroke.Parent = mainFrame

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 38)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

-- fix bottom corners of title bar
local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 8)
titleFix.Position = UDim2.new(0, 0, 1, -8)
titleFix.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
titleFix.BorderSizePixel = 0
titleFix.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "👁  GRANNY ESP"
titleLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
titleLabel.TextSize = 15
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -34, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 13
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- Scroll area
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -8, 1, -46)
scrollFrame.Position = UDim2.new(0, 4, 0, 42)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 3
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(180, 0, 0)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 4)
listLayout.Parent = scrollFrame

local listPadding = Instance.new("UIPadding")
listPadding.PaddingTop = UDim.new(0, 4)
listPadding.PaddingLeft = UDim.new(0, 4)
listPadding.PaddingRight = UDim.new(0, 4)
listPadding.Parent = scrollFrame

-- ── Reopen Button ────────────────────────────────
local reopenBtn = Instance.new("TextButton")
reopenBtn.Size = UDim2.new(0, 110, 0, 32)
reopenBtn.Position = UDim2.new(0, 20, 0.5, -16)
reopenBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
reopenBtn.Text = "👁  GRANNY ESP"
reopenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
reopenBtn.TextSize = 12
reopenBtn.Font = Enum.Font.GothamBold
reopenBtn.BorderSizePixel = 0
reopenBtn.Visible = false
reopenBtn.Parent = screenGui

local reopenCorner = Instance.new("UICorner")
reopenCorner.CornerRadius = UDim.new(0, 8)
reopenCorner.Parent = reopenBtn

local reopenStroke = Instance.new("UIStroke")
reopenStroke.Color = Color3.fromRGB(255, 60, 60)
reopenStroke.Thickness = 1
reopenStroke.Parent = reopenBtn

-- ── Close / Reopen Logic ─────────────────────────
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    reopenBtn.Visible = true
end)

reopenBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    reopenBtn.Visible = false
end)

-- ── Dragging ─────────────────────────────────────
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)
titleBar.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- =============================================================================
-- TOGGLE BUILDER
-- =============================================================================
local CATEGORY_COLORS = {
    granny   = Color3.fromRGB(0, 255, 0),
    grandpa  = Color3.fromRGB(148, 0, 211),
    slendrina= Color3.fromRGB(255, 105, 180),
    spider   = Color3.fromRGB(255, 69, 0),
    keys     = Color3.fromRGB(255, 215, 0),
    tools    = Color3.fromRGB(255, 127, 80),
    fuel     = Color3.fromRGB(255, 20, 147),
    puzzles  = Color3.fromRGB(0, 250, 154),
    weapons  = Color3.fromRGB(0, 191, 255),
    vehicles = Color3.fromRGB(138, 43, 226),
}

local CATEGORY_LABELS = {
    granny   = "Granny",
    grandpa  = "Grandpa",
    slendrina= "Slendrina",
    spider   = "Big Spider",
    keys     = "Keys",
    tools    = "Tools",
    fuel     = "Fuel & Parts",
    puzzles  = "Puzzle Items",
    weapons  = "Weapons",
    vehicles = "Vehicles",
}

local function makeSectionLabel(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = string.upper(text)
    lbl.TextColor3 = Color3.fromRGB(120, 120, 130)
    lbl.TextSize = 10
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = scrollFrame
end

local function makeToggle(key)
    local accentColor = CATEGORY_COLORS[key]
    local labelText = CATEGORY_LABELS[key]

    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 36)
    row.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    row.BorderSizePixel = 0
    row.Parent = scrollFrame

    local rowCorner = Instance.new("UICorner")
    rowCorner.CornerRadius = UDim.new(0, 6)
    rowCorner.Parent = row

    -- color dot
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(0, 10, 0.5, -4)
    dot.BackgroundColor3 = accentColor
    dot.BorderSizePixel = 0
    dot.Parent = row
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -90, 1, 0)
    lbl.Position = UDim2.new(0, 26, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(220, 220, 230)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    -- Toggle pill
    local pillBg = Instance.new("Frame")
    pillBg.Size = UDim2.new(0, 44, 0, 22)
    pillBg.Position = UDim2.new(1, -54, 0.5, -11)
    pillBg.BackgroundColor3 = TOGGLES[key] and accentColor or Color3.fromRGB(50, 50, 60)
    pillBg.BorderSizePixel = 0
    pillBg.Parent = row
    local pillCorner = Instance.new("UICorner")
    pillCorner.CornerRadius = UDim.new(1, 0)
    pillCorner.Parent = pillBg

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = TOGGLES[key] and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = pillBg
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    -- Click anywhere on row to toggle
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = row

    btn.MouseButton1Click:Connect(function()
        TOGGLES[key] = not TOGGLES[key]
        local on = TOGGLES[key]

        TweenService:Create(pillBg, TweenInfo.new(0.15), {
            BackgroundColor3 = on and accentColor or Color3.fromRGB(50, 50, 60)
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.15), {
            Position = on and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        }):Play()

        -- Refresh ESP so items appear/disappear based on new toggle
        refreshAllESP()
    end)
end

-- Section: Enemies
makeSectionLabel("— Enemies")
makeToggle("granny")
makeToggle("grandpa")
makeToggle("slendrina")
makeToggle("spider")

-- Section: Items
makeSectionLabel("— Items")
makeToggle("keys")
makeToggle("tools")
makeToggle("fuel")
makeToggle("puzzles")
makeToggle("weapons")
makeToggle("vehicles")

-- Refresh button at bottom
local refreshRow = Instance.new("Frame")
refreshRow.Size = UDim2.new(1, 0, 0, 36)
refreshRow.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
refreshRow.BorderSizePixel = 0
refreshRow.Parent = scrollFrame
local refreshRowCorner = Instance.new("UICorner")
refreshRowCorner.CornerRadius = UDim.new(0, 6)
refreshRowCorner.Parent = refreshRow

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(1, -16, 0, 26)
refreshBtn.Position = UDim2.new(0, 8, 0.5, -13)
refreshBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
refreshBtn.Text = "↺  Refresh ESP"
refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshBtn.TextSize = 13
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.BorderSizePixel = 0
refreshBtn.Parent = refreshRow
local refreshBtnCorner = Instance.new("UICorner")
refreshBtnCorner.CornerRadius = UDim.new(0, 6)
refreshBtnCorner.Parent = refreshBtn

refreshBtn.MouseButton1Click:Connect(function()
    refreshAllESP()
end)

print("Granny ESP GUI loaded.")
