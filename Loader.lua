-- ================================================
--  NexusHub | Loader.lua — Fichier unique Xeno
--  Colle dans Xeno puis Execute !
--  CTRL DROIT = ouvrir/fermer le menu
--  Toggle en haut = ON/OFF toutes les features
-- ================================================

-- ================================================
--  Config.lua  |  NexusHub
--  ModuleScript > NexusHub > Config
-- ================================================

local Config = {}

Config.Version = "1.0.0"
Config.GitHub  = "https://raw.githubusercontent.com/TON_USERNAME/NexusHub/main/Loader.lua"

Config.ToggleKey = Enum.KeyCode.RightControl
Config.AutoRejoin = false

Config.Theme = {
    Background       = Color3.fromRGB(12, 12, 18),
    Sidebar          = Color3.fromRGB(15, 15, 22),
    TitleBar         = Color3.fromRGB(18, 18, 28),
    Accent           = Color3.fromRGB(80, 120, 255),
    Text             = Color3.fromRGB(200, 200, 220),
    TextDim          = Color3.fromRGB(120, 130, 160),
    ToggleOff        = Color3.fromRGB(40, 40, 55),
    ToggleOn         = Color3.fromRGB(30, 60, 100),
    KnobOff          = Color3.fromRGB(140, 140, 160),
    KnobOn           = Color3.fromRGB(100, 180, 255),
    SliderFill       = Color3.fromRGB(80, 140, 255),
    ButtonBg         = Color3.fromRGB(30, 55, 110),
    ButtonText       = Color3.fromRGB(150, 200, 255),
    ButtonStroke     = Color3.fromRGB(60, 100, 200),
    CategoryActive   = Color3.fromRGB(18, 28, 55),
    CategoryInactive = Color3.fromRGB(20, 20, 32),
    DropdownBg       = Color3.fromRGB(22, 22, 34),
    DropdownHover    = Color3.fromRGB(30, 40, 70),
    SectionText      = Color3.fromRGB(80, 100, 160),
    HealthGreen      = Color3.fromRGB(50, 200, 80),
    HealthRed        = Color3.fromRGB(220, 50, 50),
}

Config.Window = {
    Title  = "⚡ NEXUS HUB",
    Width  = 640,
    Height = 420,
}

-- ================================================
--  CHANGELOG  ← modifie ici pour Update
-- ================================================
Config.Changelog = {
    {
        version = "1.0.0",
        date    = "2025-01-01",
        changes = {
            "✅ Menu principal créé",
            "✅ Mouvement : Speed, Fly, NoClip, InfJump, Gravity",
            "✅ Silent Aim avec FOV circle et trigger",
            "✅ ESP complet (vie, distance, tracers, liste joueurs)",
            "✅ Budda + boost Blox Fruits (Fast Attack, Range)",
            "✅ Settings avec auto-rejoin et raccourci clavier",
        }
    },
    -- { version="1.1.0", date="2025-02-01", changes={"Nouvelle feature..."} },
}

-- ================================================
--  CATÉGORIES
-- ================================================
Config.Categories = {

    { name="Update",      icon="🔄", color=Color3.fromRGB(80,200,120),  special="changelog" },

    {
        name="Mouvement", icon="🏃", color=Color3.fromRGB(100,150,255),
        content={
            { type="section", text="Vitesse" },
            { type="toggle", text="Speed Hack",      key="speedHack",   default=false },
            { type="slider", text="WalkSpeed",       key="walkSpeed",   min=16, max=500, default=16 },
            { type="section", text="Vol" },
            { type="toggle", text="Fly",             key="fly",         default=false },
            { type="slider", text="Fly Speed",       key="flySpeed",    min=10, max=300, default=50 },
            { type="section", text="Saut & Gravité" },
            { type="toggle", text="Inf Jump",        key="infJump",     default=false },
            { type="slider", text="Jump Power",      key="jumpPower",   min=7,  max=300, default=50 },
            { type="toggle", text="Gravity réduite", key="lowGravity",  default=false },
            { type="slider", text="Gravity",         key="gravityVal",  min=5,  max=196, default=196 },
            { type="section", text="Autre" },
            { type="toggle", text="No Clip",         key="noclip",      default=false },
        }
    },

    {
        name="Silent Aim", icon="🎯", color=Color3.fromRGB(255,80,80),
        content={
            { type="toggle",   text="Silent Aim",       key="silentAim",  default=false },
            { type="slider",   text="FOV Radius",       key="aimFov",     min=10, max=600, default=120 },
            { type="toggle",   text="Show FOV Circle",  key="showFov",    default=true },
            { type="toggle",   text="Trigger Bot",      key="triggerBot", default=false },
            { type="dropdown", text="Mode visée",       key="aimMode",    options={"Off","Caméra","Souris"}, default="Caméra" },
            { type="toggle",   text="Head Only",        key="headOnly",   default=false },
            { type="section",  text="Cible actuelle" },
            { type="targetDisplay" },
        }
    },

    {
        name="ESP", icon="👁️", color=Color3.fromRGB(255,180,50),
        content={
            { type="toggle", text="Activer ESP",    key="espEnabled", default=false },
            { type="toggle", text="Barre de vie",   key="espHealth",  default=true  },
            { type="toggle", text="Nombre HP",      key="espHpNum",   default=true  },
            { type="toggle", text="Distance",       key="espDist",    default=true  },
            { type="toggle", text="Tracer",         key="espTracer",  default=false },
            { type="toggle", text="Box ESP",        key="espBox",     default=false },
            { type="toggle", text="Nom joueur",     key="espName",    default=true  },
            { type="section", text="Liste joueurs (clic = couleur)" },
            { type="playerList" },
        }
    },

    {
        name="Budda", icon="🧿", color=Color3.fromRGB(200,100,255),
        content={
            { type="toggle", text="Buddha Mode",         key="buddha",      default=false },
            { type="label",  text="HP bloqué à 1 (anti-mort)" },
            { type="toggle", text="Anti-Ragdoll",        key="antiRagdoll", default=false },
            { type="section", text="Blox Fruits – Combat" },
            { type="toggle", text="Fast Attack",         key="fastAttack",  default=false },
            { type="slider", text="Délai attaque (ms)",  key="attackDelay", min=50, max=500, default=200 },
            { type="toggle", text="Extend Range",        key="extendRange", default=false },
            { type="slider", text="Range Multiplier",    key="rangeMulti",  min=1,  max=20,  default=3 },
        }
    },

    {
        name="Settings", icon="⚙️", color=Color3.fromRGB(160,160,160),
        content={
            { type="label",  text="Touche menu : CTRL Droit" },
            { type="toggle", text="Auto-inject (serv hop)", key="autoRejoin", default=false },
            { type="toggle", text="Notifications",          key="notifs",     default=true  },
            { type="toggle", text="Menu draggable",         key="draggable",  default=true  },
            { type="section", text="À propos" },
            { type="label",  text="NexusHub v1.0.0" },
            { type="label",  text="Exécuteur : Xeno" },
            { type="button", text="📋 Copier lien GitHub",  key="copyGithub" },
        }
    },
}



-- ================================================
--  State.lua  |  NexusHub
--  ModuleScript > NexusHub > State
-- ================================================

local State  = {}

State.Values = {}

-- Couleurs ESP par joueur  { [userId] = "green"|"red"|"default" }
State.PlayerColors = {}

-- Cible Silent Aim actuelle
State.CurrentTarget = nil

function State.init()
    for _, cat in ipairs(Config.Categories) do
        if cat.content then
            for _, item in ipairs(cat.content) do
                if item.key and item.default ~= nil then
                    State.Values[item.key] = item.default
                end
            end
        end
    end
    -- Valeurs supplémentaires non liées à un item de config
    State.Values["aimMode"]     = "Caméra"
    State.Values["autoRejoin"]  = Config.AutoRejoin
end

function State.get(key)    return State.Values[key] end
function State.set(key, v) State.Values[key] = v end
function State.toggle(key)
    State.Values[key] = not State.Values[key]
    return State.Values[key]
end



-- ================================================
--  Components.lua  |  NexusHub
--  ModuleScript > NexusHub > Components
-- ================================================

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")


local T          = Config.Theme
local Components = {}

-- ================================================
--  TOGGLE
-- ================================================
function Components.createToggle(parent, cfg)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 34)
    row.BackgroundTransparency = 1
    row.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Text              = cfg.text
    lbl.Size              = UDim2.new(0.72, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3        = T.Text
    lbl.TextSize          = 13
    lbl.Font              = Enum.Font.Gotham
    lbl.TextXAlignment    = Enum.TextXAlignment.Left
    lbl.Parent            = row

    local bg = Instance.new("Frame")
    bg.Size              = UDim2.new(0, 44, 0, 22)
    bg.Position          = UDim2.new(1, -44, 0.5, -11)
    bg.BackgroundColor3  = T.ToggleOff
    bg.BorderSizePixel   = 0
    bg.Parent            = row
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size             = UDim2.new(0, 18, 0, 18)
    knob.Position         = UDim2.new(0, 2, 0.5, -9)
    knob.BackgroundColor3 = T.KnobOff
    knob.BorderSizePixel  = 0
    knob.Parent           = bg
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local function refresh()
        local on = State.get(cfg.key)
        TweenService:Create(knob, TweenInfo.new(0.15), {
            Position         = on and UDim2.new(0,24,0.5,-9) or UDim2.new(0,2,0.5,-9),
            BackgroundColor3 = on and T.KnobOn or T.KnobOff,
        }):Play()
        TweenService:Create(bg, TweenInfo.new(0.15), {
            BackgroundColor3 = on and T.ToggleOn or T.ToggleOff,
        }):Play()
    end
    refresh()

    bg.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            State.toggle(cfg.key)
            refresh()
        end
    end)
    return row
end

-- ================================================
--  SLIDER
-- ================================================
function Components.createSlider(parent, cfg)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 48)
    row.BackgroundTransparency = 1
    row.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Text           = cfg.text .. " : " .. tostring(cfg.default)
    lbl.Size           = UDim2.new(1, 0, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3     = T.Text
    lbl.TextSize       = 13
    lbl.Font           = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent         = row

    local track = Instance.new("Frame")
    track.Size             = UDim2.new(1, 0, 0, 6)
    track.Position         = UDim2.new(0, 0, 0, 32)
    track.BackgroundColor3 = T.ToggleOff
    track.BorderSizePixel  = 0
    track.Parent           = row
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local pct = (cfg.default - cfg.min) / (cfg.max - cfg.min)

    local fill = Instance.new("Frame")
    fill.Size             = UDim2.new(pct, 0, 1, 0)
    fill.BackgroundColor3 = T.SliderFill
    fill.BorderSizePixel  = 0
    fill.Parent           = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size             = UDim2.new(0, 14, 0, 14)
    knob.Position         = UDim2.new(pct, -7, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BorderSizePixel  = 0
    knob.Parent           = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function apply(mx)
        local rel = math.clamp((mx - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local val = math.floor(cfg.min + rel * (cfg.max - cfg.min))
        State.set(cfg.key, val)
        lbl.Text      = cfg.text .. " : " .. tostring(val)
        fill.Size     = UDim2.new(rel, 0, 1, 0)
        knob.Position = UDim2.new(rel, -7, 0.5, -7)
    end

    knob.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; apply(i.Position.X) end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then apply(i.Position.X) end
    end)
    return row
end

-- ================================================
--  LABEL
-- ================================================
function Components.createLabel(parent, cfg)
    local lbl = Instance.new("TextLabel")
    lbl.Text           = "• " .. cfg.text
    lbl.Size           = UDim2.new(1, -20, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3     = T.TextDim
    lbl.TextSize       = 12
    lbl.Font           = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent         = parent
    return lbl
end

-- ================================================
--  SECTION (sous-titre séparateur)
-- ================================================
function Components.createSection(parent, cfg)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 26)
    row.BackgroundTransparency = 1
    row.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Text           = cfg.text
    lbl.Size           = UDim2.new(0, 120, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3     = T.SectionText
    lbl.TextSize       = 11
    lbl.Font           = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent         = row

    local line = Instance.new("Frame")
    line.Size             = UDim2.new(1, -130, 0, 1)
    line.Position         = UDim2.new(0, 130, 0.5, 0)
    line.BackgroundColor3 = T.SectionText
    line.BackgroundTransparency = 0.5
    line.BorderSizePixel  = 0
    line.Parent           = row
    return row
end

-- ================================================
--  BUTTON
-- ================================================
function Components.createButton(parent, cfg, onClick)
    local btn = Instance.new("TextButton")
    btn.Text             = cfg.text
    btn.Size             = UDim2.new(1, -20, 0, 32)
    btn.BackgroundColor3 = T.ButtonBg
    btn.TextColor3       = T.ButtonText
    btn.TextSize         = 13
    btn.Font             = Enum.Font.GothamBold
    btn.BorderSizePixel  = 0
    btn.Parent           = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local s = Instance.new("UIStroke", btn)
    s.Color = T.ButtonStroke

    btn.MouseButton1Click:Connect(function()
        if onClick then onClick(cfg.key) end
    end)
    return btn
end

-- ================================================
--  DROPDOWN
-- ================================================
function Components.createDropdown(parent, cfg)
    State.set(cfg.key, cfg.default)

    local wrapper = Instance.new("Frame")
    wrapper.Size = UDim2.new(1, -20, 0, 34)
    wrapper.BackgroundTransparency = 1
    wrapper.ClipsDescendants = false
    wrapper.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Text           = cfg.text
    lbl.Size           = UDim2.new(0.45, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3     = T.Text
    lbl.TextSize       = 13
    lbl.Font           = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent         = wrapper

    -- Bouton principal
    local selected = Instance.new("TextButton")
    selected.Text             = cfg.default .. " ▾"
    selected.Size             = UDim2.new(0.52, 0, 0, 28)
    selected.Position         = UDim2.new(0.48, 0, 0.5, -14)
    selected.BackgroundColor3 = T.DropdownBg
    selected.TextColor3       = T.Text
    selected.TextSize         = 12
    selected.Font             = Enum.Font.Gotham
    selected.BorderSizePixel  = 0
    selected.ZIndex           = 5
    selected.Parent           = wrapper
    Instance.new("UICorner", selected).CornerRadius = UDim.new(0, 6)
    local selStroke = Instance.new("UIStroke", selected)
    selStroke.Color = T.Accent

    -- Menu déroulant
    local menu = Instance.new("Frame")
    menu.Size             = UDim2.new(0.52, 0, 0, #cfg.options * 28)
    menu.Position         = UDim2.new(0.48, 0, 1, 2)
    menu.BackgroundColor3 = T.DropdownBg
    menu.BorderSizePixel  = 0
    menu.ZIndex           = 10
    menu.Visible          = false
    menu.Parent           = wrapper
    Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 6)
    local menuStroke = Instance.new("UIStroke", menu)
    menuStroke.Color = T.Accent

    local menuLayout = Instance.new("UIListLayout")
    menuLayout.Parent = menu

    for _, opt in ipairs(cfg.options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Text             = opt
        optBtn.Size             = UDim2.new(1, 0, 0, 28)
        optBtn.BackgroundColor3 = T.DropdownBg
        optBtn.TextColor3       = T.Text
        optBtn.TextSize         = 12
        optBtn.Font             = Enum.Font.Gotham
        optBtn.BorderSizePixel  = 0
        optBtn.ZIndex           = 11
        optBtn.Parent           = menu

        optBtn.MouseEnter:Connect(function()
            TweenService:Create(optBtn, TweenInfo.new(0.1), {BackgroundColor3 = T.DropdownHover}):Play()
        end)
        optBtn.MouseLeave:Connect(function()
            TweenService:Create(optBtn, TweenInfo.new(0.1), {BackgroundColor3 = T.DropdownBg}):Play()
        end)
        optBtn.MouseButton1Click:Connect(function()
            State.set(cfg.key, opt)
            selected.Text = opt .. " ▾"
            menu.Visible = false
        end)
    end

    selected.MouseButton1Click:Connect(function()
        menu.Visible = not menu.Visible
    end)

    return wrapper
end

-- ================================================
--  TARGET DISPLAY (Silent Aim)
-- ================================================
function Components.createTargetDisplay(parent)
    local frame = Instance.new("Frame")
    frame.Size             = UDim2.new(1, -20, 0, 42)
    frame.BackgroundColor3 = T.DropdownBg
    frame.BorderSizePixel  = 0
    frame.Parent           = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", frame).Color = T.SectionText

    local dot = Instance.new("Frame")
    dot.Size             = UDim2.new(0, 10, 0, 10)
    dot.Position         = UDim2.new(0, 12, 0.5, -5)
    dot.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
    dot.BorderSizePixel  = 0
    dot.Parent           = frame
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Text           = "Aucune cible"
    nameLbl.Size           = UDim2.new(1, -36, 1, 0)
    nameLbl.Position       = UDim2.new(0, 32, 0, 0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.TextColor3     = T.TextDim
    nameLbl.TextSize       = 13
    nameLbl.Font           = Enum.Font.Gotham
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.Parent         = frame

    -- Mise à jour en temps réel
    game:GetService("RunService").Heartbeat:Connect(function()
        local t = State.CurrentTarget
        if t and t.Character then
            local hum = t.Character:FindFirstChildOfClass("Humanoid")
            local hp  = hum and math.floor(hum.Health) or 0
            local maxHp = hum and math.floor(hum.MaxHealth) or 100
            nameLbl.Text   = t.Name .. "  |  " .. hp .. "/" .. maxHp .. " HP"
            nameLbl.TextColor3 = Color3.fromRGB(100, 220, 130)
            dot.BackgroundColor3 = Color3.fromRGB(50, 220, 80)
        else
            nameLbl.Text   = "Aucune cible"
            nameLbl.TextColor3 = T.TextDim
            dot.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
        end
    end)

    return frame
end

-- ================================================
--  PLAYER LIST (ESP)
-- ================================================
function Components.createPlayerList(parent)
    local container = Instance.new("Frame")
    container.Size             = UDim2.new(1, -20, 0, 0)
    container.AutomaticSize    = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.Parent           = parent

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 3)
    layout.Parent  = container

    local function rebuild()
        for _, c in ipairs(container:GetChildren()) do
            if c:IsA("Frame") or c:IsA("TextButton") then c:Destroy() end
        end

        for _, p in ipairs(Players:GetPlayers()) do
            if p == Players.LocalPlayer then continue end

            local colorState = State.PlayerColors[p.UserId] or "default"
            local bgColor =
                colorState == "green" and Color3.fromRGB(20,60,30) or
                colorState == "red"   and Color3.fromRGB(60,20,20) or
                T.DropdownBg

            local row = Instance.new("TextButton")
            row.Text             = p.Name
            row.Size             = UDim2.new(1, 0, 0, 28)
            row.BackgroundColor3 = bgColor
            row.TextColor3       = T.Text
            row.TextSize         = 12
            row.Font             = Enum.Font.Gotham
            row.BorderSizePixel  = 0
            row.Parent           = container
            Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)

            -- Indicateur couleur (pastille)
            local dot = Instance.new("Frame")
            dot.Size             = UDim2.new(0, 8, 0, 8)
            dot.Position         = UDim2.new(0, 8, 0.5, -4)
            dot.BackgroundColor3 =
                colorState == "green" and Color3.fromRGB(50,220,80) or
                colorState == "red"   and Color3.fromRGB(220,50,50) or
                Color3.fromRGB(100,100,130)
            dot.BorderSizePixel  = 0
            dot.Parent           = row
            Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)

            local nameLbl = Instance.new("TextLabel")
            nameLbl.Text           = p.Name
            nameLbl.Size           = UDim2.new(1,-24,1,0)
            nameLbl.Position       = UDim2.new(0,22,0,0)
            nameLbl.BackgroundTransparency = 1
            nameLbl.TextColor3     = T.Text
            nameLbl.TextSize       = 12
            nameLbl.Font           = Enum.Font.Gotham
            nameLbl.TextXAlignment = Enum.TextXAlignment.Left
            nameLbl.Parent         = row

            -- Clic gauche = vert, clic droit = rouge, millieu = reset
            row.MouseButton1Click:Connect(function()
                local cur = State.PlayerColors[p.UserId] or "default"
                if cur == "green" then
                    State.PlayerColors[p.UserId] = "default"
                else
                    State.PlayerColors[p.UserId] = "green"
                end
                rebuild()
            end)
            row.MouseButton2Click:Connect(function()
                local cur = State.PlayerColors[p.UserId] or "default"
                if cur == "red" then
                    State.PlayerColors[p.UserId] = "default"
                else
                    State.PlayerColors[p.UserId] = "red"
                end
                rebuild()
            end)
        end
    end

    rebuild()
    Players.PlayerAdded:Connect(rebuild)
    Players.PlayerRemoving:Connect(function() task.wait(0.1); rebuild() end)

    -- Légende
    local legend = Instance.new("TextLabel")
    legend.Text           = "Clic gauche = 🟢  |  Clic droit = 🔴"
    legend.Size           = UDim2.new(1, -20, 0, 18)
    legend.BackgroundTransparency = 1
    legend.TextColor3     = T.TextDim
    legend.TextSize       = 10
    legend.Font           = Enum.Font.Gotham
    legend.TextXAlignment = Enum.TextXAlignment.Left
    legend.Parent         = parent

    return container
end

-- ================================================
--  CHANGELOG (Update)
-- ================================================
function Components.createChangelog(parent)
    for _, entry in ipairs(Config.Changelog) do
        -- En-tête version
        local header = Instance.new("Frame")
        header.Size             = UDim2.new(1, -20, 0, 30)
        header.BackgroundColor3 = Color3.fromRGB(20, 40, 20)
        header.BorderSizePixel  = 0
        header.Parent           = parent
        Instance.new("UICorner", header).CornerRadius = UDim.new(0, 6)

        local vLbl = Instance.new("TextLabel")
        vLbl.Text           = "v" .. entry.version
        vLbl.Size           = UDim2.new(0.4, 0, 1, 0)
        vLbl.Position       = UDim2.new(0, 10, 0, 0)
        vLbl.BackgroundTransparency = 1
        vLbl.TextColor3     = Color3.fromRGB(80, 220, 110)
        vLbl.TextSize       = 14
        vLbl.Font           = Enum.Font.GothamBold
        vLbl.TextXAlignment = Enum.TextXAlignment.Left
        vLbl.Parent         = header

        local dLbl = Instance.new("TextLabel")
        dLbl.Text           = entry.date
        dLbl.Size           = UDim2.new(0.5, 0, 1, 0)
        dLbl.Position       = UDim2.new(0.5, 0, 0, 0)
        dLbl.BackgroundTransparency = 1
        dLbl.TextColor3     = T.TextDim
        dLbl.TextSize       = 11
        dLbl.Font           = Enum.Font.Gotham
        dLbl.TextXAlignment = Enum.TextXAlignment.Right
        dLbl.Parent         = header

        -- Lignes de changements
        for _, line in ipairs(entry.changes) do
            local row = Instance.new("TextLabel")
            row.Text           = "  " .. line
            row.Size           = UDim2.new(1, -20, 0, 20)
            row.BackgroundTransparency = 1
            row.TextColor3     = T.Text
            row.TextSize       = 12
            row.Font           = Enum.Font.Gotham
            row.TextXAlignment = Enum.TextXAlignment.Left
            row.TextWrapped    = true
            row.Parent         = parent
        end

        -- Espacement
        local spacer = Instance.new("Frame")
        spacer.Size = UDim2.new(1, 0, 0, 6)
        spacer.BackgroundTransparency = 1
        spacer.Parent = parent
    end
end

-- ================================================
--  EN-TÊTE DE CATÉGORIE
-- ================================================
function Components.createCategoryHeader(parent, cat)
    local title = Instance.new("TextLabel")
    title.Text           = cat.icon .. "  " .. cat.name
    title.Size           = UDim2.new(1, -20, 0, 28)
    title.BackgroundTransparency = 1
    title.TextColor3     = cat.color
    title.TextSize       = 16
    title.Font           = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent         = parent

    local sep = Instance.new("Frame")
    sep.Size             = UDim2.new(1, -20, 0, 1)
    sep.BackgroundColor3 = cat.color
    sep.BackgroundTransparency = 0.6
    sep.BorderSizePixel  = 0
    sep.Parent           = parent
end



-- ================================================
--  GUI.lua  |  NexusHub
--  ModuleScript > NexusHub > GUI
-- ================================================

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")


local T   = Config.Theme
local W   = Config.Window
local GUI = {}

local MainFrame, ContentArea, Sidebar
local currentPanel = nil

-- État master ON/OFF (toutes les features)
GUI.MasterEnabled = true
GUI.MasterToggleCallbacks = {}  -- Features.lua s'y abonne

local function fireMasterCallbacks(state)
    for _, cb in ipairs(GUI.MasterToggleCallbacks) do
        pcall(cb, state)
    end
end

-- ================================================
--  BUILD FENÊTRE
-- ================================================
function GUI.build()
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

    local sg = Instance.new("ScreenGui")
    sg.Name           = "NexusHub"
    sg.ResetOnSpawn   = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.Parent         = playerGui

    -- Fenêtre principale
    MainFrame = Instance.new("Frame")
    MainFrame.Name             = "MainFrame"
    MainFrame.Size             = UDim2.new(0, 0, 0, 0)
    MainFrame.Position         = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = T.Background
    MainFrame.BorderSizePixel  = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent           = sg
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", MainFrame)
    stroke.Color = T.Accent; stroke.Thickness = 1.5

    -- Barre de titre
    local titleBar = Instance.new("Frame")
    titleBar.Name             = "TitleBar"
    titleBar.Size             = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = T.TitleBar
    titleBar.BorderSizePixel  = 0
    titleBar.Parent           = MainFrame

    -- Glow sous le titre
    local glow = Instance.new("Frame")
    glow.Size             = UDim2.new(1, 0, 0, 1)
    glow.Position         = UDim2.new(0, 0, 1, -1)
    glow.BackgroundColor3 = T.Accent
    glow.BorderSizePixel  = 0
    glow.Parent           = titleBar

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Text           = W.Title
    titleLbl.Size           = UDim2.new(1, -80, 1, 0)
    titleLbl.Position       = UDim2.new(0, 15, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.TextColor3     = T.Accent
    titleLbl.TextSize       = 16
    titleLbl.Font           = Enum.Font.GothamBold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent         = titleBar

    -- ── MASTER TOGGLE ON/OFF ──────────────────────
    local masterBg = Instance.new("Frame")
    masterBg.Size             = UDim2.new(0, 50, 0, 24)
    masterBg.Position         = UDim2.new(1, -100, 0.5, -12)
    masterBg.BackgroundColor3 = Color3.fromRGB(40, 180, 80)   -- vert = ON
    masterBg.BorderSizePixel  = 0
    masterBg.Parent           = titleBar
    Instance.new("UICorner", masterBg).CornerRadius = UDim.new(1, 0)
    local masterStroke = Instance.new("UIStroke", masterBg)
    masterStroke.Color = Color3.fromRGB(255,255,255); masterStroke.Transparency = 0.7

    local masterKnob = Instance.new("Frame")
    masterKnob.Size             = UDim2.new(0, 18, 0, 18)
    masterKnob.Position         = UDim2.new(1, -21, 0.5, -9)  -- droite = ON
    masterKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    masterKnob.BorderSizePixel  = 0
    masterKnob.Parent           = masterBg
    Instance.new("UICorner", masterKnob).CornerRadius = UDim.new(1, 0)

    local masterLbl = Instance.new("TextLabel")
    masterLbl.Size             = UDim2.new(0, 26, 1, 0)
    masterLbl.Position         = UDim2.new(0, 4, 0, 0)
    masterLbl.BackgroundTransparency = 1
    masterLbl.Text             = "ON"
    masterLbl.TextColor3       = Color3.fromRGB(255, 255, 255)
    masterLbl.TextSize         = 10
    masterLbl.Font             = Enum.Font.GothamBold
    masterLbl.Parent           = masterBg

    local function refreshMaster()
        local on = GUI.MasterEnabled
        TweenService:Create(masterKnob, TweenInfo.new(0.18), {
            Position         = on and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9),
        }):Play()
        TweenService:Create(masterBg, TweenInfo.new(0.18), {
            BackgroundColor3 = on and Color3.fromRGB(40,180,80) or Color3.fromRGB(160,40,40),
        }):Play()
        masterLbl.Text     = on and "ON" or "OFF"
        masterLbl.Position = on and UDim2.new(0,4,0,0) or UDim2.new(0,22,0,0)
        fireMasterCallbacks(on)
    end

    masterBg.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            GUI.MasterEnabled = not GUI.MasterEnabled
            refreshMaster()
        end
    end)

    -- ── BOUTON FERMER ─────────────────────────────
    local closeBtn = Instance.new("TextButton")
    closeBtn.Text             = "✕"
    closeBtn.Size             = UDim2.new(0, 28, 0, 28)
    closeBtn.Position         = UDim2.new(1, -36, 0, 6)
    closeBtn.BackgroundColor3 = Color3.fromRGB(180,40,40)
    closeBtn.TextColor3       = Color3.fromRGB(255,255,255)
    closeBtn.TextSize         = 13
    closeBtn.Font             = Enum.Font.GothamBold
    closeBtn.BorderSizePixel  = 0
    closeBtn.Parent           = titleBar
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
    closeBtn.MouseButton1Click:Connect(function() GUI.hide() end)

    -- Sidebar
    Sidebar = Instance.new("Frame")
    Sidebar.Name             = "Sidebar"
    Sidebar.Size             = UDim2.new(0, 155, 1, -40)
    Sidebar.Position         = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = T.Sidebar
    Sidebar.BorderSizePixel  = 0
    Sidebar.Parent           = MainFrame

    local sbLine = Instance.new("Frame")
    sbLine.Size             = UDim2.new(0, 1, 1, 0)
    sbLine.Position         = UDim2.new(1,-1,0,0)
    sbLine.BackgroundColor3 = Color3.fromRGB(30,50,100)
    sbLine.BorderSizePixel  = 0
    sbLine.Parent           = Sidebar

    local sbLayout = Instance.new("UIListLayout")
    sbLayout.Padding = UDim.new(0,4)
    sbLayout.Parent  = Sidebar

    local sbPad = Instance.new("UIPadding")
    sbPad.PaddingTop = UDim.new(0,8)
    sbPad.PaddingLeft = UDim.new(0,8)
    sbPad.PaddingRight = UDim.new(0,8)
    sbPad.Parent = Sidebar

    -- Zone contenu
    ContentArea = Instance.new("Frame")
    ContentArea.Name   = "ContentArea"
    ContentArea.Size   = UDim2.new(1,-155,1,-40)
    ContentArea.Position = UDim2.new(0,155,0,40)
    ContentArea.BackgroundTransparency = 1
    ContentArea.Parent = MainFrame

    GUI._setupDrag(titleBar, MainFrame)

    -- Raccourci clavier CTRL DROIT
    UserInputService.InputBegan:Connect(function(inp, gpe)
        if gpe then return end
        if inp.KeyCode == Config.ToggleKey then GUI.toggle() end
    end)

    return MainFrame, Sidebar, ContentArea
end

-- ================================================
--  SHOW / HIDE / TOGGLE
-- ================================================
function GUI.show()
    MainFrame.Visible = true
    TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size     = UDim2.new(0, W.Width,  0, W.Height),
        Position = UDim2.new(0.5, -W.Width/2, 0.5, -W.Height/2),
    }):Play()
end

function GUI.hide()
    TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size     = UDim2.new(0,0,0,0),
        Position = UDim2.new(0.5,0,0.5,0),
    }):Play()
    task.delay(0.22, function() MainFrame.Visible = false end)
end

function GUI.toggle()
    if MainFrame.Visible then GUI.hide() else GUI.show() end
end

-- ================================================
--  DRAG
-- ================================================
function GUI._setupDrag(handle, frame)
    local dragging, dragStart, startPos = false, nil, nil
    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = i.Position; startPos = frame.Position
        end
    end)
    handle.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = i.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
        end
    end)
end

-- ================================================
--  PANNEAU DE CONTENU
-- ================================================
function GUI.openPanel(cat, onButtonClick)
    if currentPanel then currentPanel:Destroy() end

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size                 = UDim2.new(1,-10,1,-10)
    scroll.Position             = UDim2.new(0,5,0,5)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel      = 0
    scroll.ScrollBarThickness   = 3
    scroll.ScrollBarImageColor3 = T.Accent
    scroll.CanvasSize           = UDim2.new(0,0,0,0)
    scroll.AutomaticCanvasSize  = Enum.AutomaticSize.Y
    scroll.Parent               = ContentArea

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0,5)
    layout.Parent  = scroll

    local pad = Instance.new("UIPadding")
    pad.PaddingTop  = UDim.new(0,8)
    pad.PaddingLeft = UDim.new(0,10)
    pad.Parent      = scroll

    Components.createCategoryHeader(scroll, cat)

    -- Rendu spécial changelog
    if cat.special == "changelog" then
        Components.createChangelog(scroll)
    elseif cat.content then
        for _, item in ipairs(cat.content) do
            if item.type == "toggle"        then Components.createToggle(scroll, item)
            elseif item.type == "slider"    then Components.createSlider(scroll, item)
            elseif item.type == "label"     then Components.createLabel(scroll, item)
            elseif item.type == "section"   then Components.createSection(scroll, item)
            elseif item.type == "button"    then Components.createButton(scroll, item, onButtonClick)
            elseif item.type == "dropdown"  then Components.createDropdown(scroll, item)
            elseif item.type == "targetDisplay" then Components.createTargetDisplay(scroll)
            elseif item.type == "playerList"    then Components.createPlayerList(scroll)
            end
        end
    end

    currentPanel = scroll
end

-- ================================================
--  BOUTON SIDEBAR
-- ================================================
function GUI.createSidebarButton(cat, onSelect)
    local btn = Instance.new("TextButton")
    btn.Text             = cat.icon .. "  " .. cat.name
    btn.Size             = UDim2.new(1,0,0,36)
    btn.BackgroundColor3 = T.CategoryInactive
    btn.TextColor3       = T.TextDim
    btn.TextSize         = 13
    btn.Font             = Enum.Font.Gotham
    btn.TextXAlignment   = Enum.TextXAlignment.Left
    btn.BorderSizePixel  = 0
    btn.Parent           = Sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(0,3,0.6,0)
    accent.Position = UDim2.new(0,0,0.2,0)
    accent.BackgroundColor3 = cat.color
    accent.BackgroundTransparency = 1
    accent.BorderSizePixel = 0
    accent.Parent = btn
    Instance.new("UICorner", accent).CornerRadius = UDim.new(1,0)

    local lpad = Instance.new("UIPadding")
    lpad.PaddingLeft = UDim.new(0,12)
    lpad.Parent = btn

    btn.MouseButton1Click:Connect(function()
        onSelect(cat, btn, accent)
    end)
    return btn, accent
end

function GUI.resetSidebarButtons()
    for _, child in ipairs(Sidebar:GetChildren()) do
        if child:IsA("TextButton") then
            TweenService:Create(child, TweenInfo.new(0.15), {
                BackgroundColor3 = T.CategoryInactive,
                TextColor3       = T.TextDim,
            }):Play()
            local ac = child:FindFirstChildOfClass("Frame")
            if ac then TweenService:Create(ac,TweenInfo.new(0.15),{BackgroundTransparency=1}):Play() end
        end
    end
end



-- ================================================
--  Features.lua  |  NexusHub
--  ModuleScript > NexusHub > Features
-- ================================================

local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")

local Features = {}

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- ================================================
--  VALEURS ORIGINALES DU JOUEUR
--  Capturées au chargement, avant toute modification
-- ================================================
local originalValues = {
    walkSpeed = 16,
    jumpPower = 50,
    gravity   = 196.2,
}

local function captureOriginals()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    -- On capture seulement si les features correspondantes sont désactivées
    if hum then
        if not State.get("speedHack") then
            originalValues.walkSpeed = hum.WalkSpeed
        end
        if not State.get("infJump") then
            originalValues.jumpPower = hum.JumpPower
        end
    end
    if not State.get("lowGravity") then
        originalValues.gravity = workspace.Gravity
    end
end

-- ================================================
--  HELPERS
-- ================================================
local function getChar()  return player.Character end
local function getHum()   local c = getChar(); return c and c:FindFirstChildOfClass("Humanoid") end
local function getRoot()  local c = getChar(); return c and c:FindFirstChild("HumanoidRootPart") end

-- ================================================
--  FLY
-- ================================================
local flyBV, flyConn

local function startFly()
    if flyBV then return end
    local root = getRoot(); if not root then return end
    flyBV = Instance.new("BodyVelocity")
    flyBV.MaxForce = Vector3.new(1e5,1e5,1e5)
    flyBV.Velocity = Vector3.zero
    flyBV.Parent   = root
    flyConn = RunService.Heartbeat:Connect(function()
        if not State.get("fly") or not GUI.MasterEnabled then stopFly(); return end
        local sp  = State.get("flySpeed") or 50
        local cf  = camera.CFrame
        local dir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cf.LookVector  end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cf.LookVector  end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cf.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cf.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space)       then dir += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
        flyBV.Velocity = dir.Magnitude > 0 and dir.Unit * sp or Vector3.zero
    end)
end

function stopFly()
    if flyConn then flyConn:Disconnect(); flyConn = nil end
    if flyBV   then flyBV:Destroy();      flyBV   = nil end
end

-- ================================================
--  NO CLIP
-- ================================================
local noclipConn

local function startNoclip()
    if noclipConn then return end
    noclipConn = RunService.Stepped:Connect(function()
        if not State.get("noclip") or not GUI.MasterEnabled then stopNoclip(); return end
        local c = getChar(); if not c then return end
        for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end)
end

function stopNoclip()
    if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
    local c = getChar()
    if c then
        for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = true end
        end
    end
end

-- ================================================
--  SILENT AIM + FOV CIRCLE
-- ================================================
local fovCircle = Drawing.new("Circle")
fovCircle.Visible   = false
fovCircle.Thickness = 1.5
fovCircle.Color     = Color3.fromRGB(255, 80, 80)
fovCircle.Filled    = false
fovCircle.NumSides  = 64

local function getAimOrigin()
    if State.get("aimMode") == "Caméra" then
        return camera.ViewportSize / 2
    end
    local mp = UserInputService:GetMouseLocation()
    return Vector2.new(mp.X, mp.Y)
end

local function getBestTarget()
    local origin = getAimOrigin()
    local fov    = State.get("aimFov") or 120
    local best, bestDist = nil, fov
    for _, p in ipairs(Players:GetPlayers()) do
        if p == player then continue end
        local c = p.Character; if not c then continue end
        local part = State.get("headOnly") and c:FindFirstChild("Head") or c:FindFirstChild("HumanoidRootPart")
        if not part then continue end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local sp, onScreen = camera:WorldToViewportPoint(part.Position)
        if not onScreen then continue end
        local dist = (Vector2.new(sp.X, sp.Y) - origin).Magnitude
        if dist < bestDist then bestDist = dist; best = p end
    end
    return best
end

local function updateFovCircle()
    local active = GUI.MasterEnabled and State.get("silentAim") and State.get("showFov")
    fovCircle.Visible = active
    if active then
        fovCircle.Position = getAimOrigin()
        fovCircle.Radius   = State.get("aimFov") or 120
    end
end

-- ================================================
--  ESP
-- ================================================
local espObjects = {}

local function clearESP()
    for _, v in pairs(espObjects) do
        if typeof(v) == "Instance" and v.Parent then
            v:Destroy()
        elseif typeof(v) == "RBXScriptConnection" then
            v:Disconnect()
        else
            pcall(function() v:Remove() end)
        end
    end
    espObjects = {}
end

local function buildESP(target)
    if target == player then return end
    local char = target.Character; if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
    local hum  = char:FindFirstChildOfClass("Humanoid")

    local bb = Instance.new("BillboardGui")
    bb.Name        = "ESP_" .. target.Name
    bb.Size        = UDim2.new(0, 130, 0, 62)
    bb.StudsOffset = Vector3.new(0, 3.5, 0)
    bb.AlwaysOnTop = true
    bb.Parent      = root

    -- Nom
    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1,0,0,16); nameLbl.BackgroundTransparency = 1
    nameLbl.TextColor3 = Color3.fromRGB(255,255,255); nameLbl.TextStrokeTransparency = 0.4
    nameLbl.TextSize = 13; nameLbl.Font = Enum.Font.GothamBold
    nameLbl.Text = target.Name; nameLbl.Parent = bb

    -- Barre de vie
    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(1,0,0,6); barBg.Position = UDim2.new(0,0,0,19)
    barBg.BackgroundColor3 = Color3.fromRGB(40,10,10); barBg.BorderSizePixel = 0
    barBg.Parent = bb
    Instance.new("UICorner",barBg).CornerRadius = UDim.new(1,0)

    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(1,0,1,0); barFill.BackgroundColor3 = Color3.fromRGB(50,220,80)
    barFill.BorderSizePixel = 0; barFill.Parent = barBg
    Instance.new("UICorner",barFill).CornerRadius = UDim.new(1,0)

    -- HP texte
    local hpLbl = Instance.new("TextLabel")
    hpLbl.Size = UDim2.new(1,0,0,14); hpLbl.Position = UDim2.new(0,0,0,27)
    hpLbl.BackgroundTransparency = 1; hpLbl.TextColor3 = Color3.fromRGB(210,210,210)
    hpLbl.TextStrokeTransparency = 0.5; hpLbl.TextSize = 11
    hpLbl.Font = Enum.Font.Gotham; hpLbl.Parent = bb

    -- Distance
    local distLbl = Instance.new("TextLabel")
    distLbl.Size = UDim2.new(1,0,0,14); distLbl.Position = UDim2.new(0,0,0,43)
    distLbl.BackgroundTransparency = 1; distLbl.TextColor3 = Color3.fromRGB(160,160,255)
    distLbl.TextStrokeTransparency = 0.5; distLbl.TextSize = 10
    distLbl.Font = Enum.Font.Gotham; distLbl.Parent = bb

    -- Tracer
    local line = Drawing.new("Line")
    line.Visible = false; line.Color = Color3.fromRGB(255,180,50); line.Thickness = 1

    local conn = RunService.Heartbeat:Connect(function()
        local espOn = GUI.MasterEnabled and State.get("espEnabled")
        bb.Enabled   = espOn
        line.Visible = false
        if not espOn then return end
        if not (hum and hum.Parent and root and root.Parent) then return end

        -- Visibilité individuelle de chaque option
        nameLbl.Visible = State.get("espName")
        barBg.Visible   = State.get("espHealth")
        hpLbl.Visible   = State.get("espHpNum")
        distLbl.Visible = State.get("espDist")

        -- Barre vie dégradée
        local pct = math.clamp(hum.Health / math.max(hum.MaxHealth,1), 0, 1)
        barFill.Size = UDim2.new(pct, 0, 1, 0)
        barFill.BackgroundColor3 = Color3.fromRGB(
            math.clamp(math.floor((1-pct)*220+30), 0, 255),
            math.clamp(math.floor(pct*200+20),     0, 255),
            30
        )
        hpLbl.Text = math.floor(hum.Health) .. " / " .. math.floor(hum.MaxHealth) .. " HP"

        -- Distance
        local myRoot = getRoot()
        if myRoot then
            distLbl.Text = math.floor((myRoot.Position - root.Position).Magnitude) .. " studs"
        end

        -- Tracer
        if State.get("espTracer") then
            local sp, onScreen = camera:WorldToViewportPoint(root.Position)
            if onScreen then
                line.Visible = true
                line.From    = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                line.To      = Vector2.new(sp.X, sp.Y)
            end
        end
    end)

    table.insert(espObjects, bb)
    table.insert(espObjects, line)
    table.insert(espObjects, conn)
end

local function refreshESP()
    clearESP()
    for _, p in ipairs(Players:GetPlayers()) do buildESP(p) end
end

-- ================================================
--  BLOX FRUITS
-- ================================================
local function applyBloxFruitsHooks()
    RunService.Heartbeat:Connect(function()
        if not GUI.MasterEnabled or not State.get("fastAttack") then return end
        local char = getChar(); if not char then return end
        local hum  = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
        local anim = hum:FindFirstChildOfClass("Animator"); if not anim then return end
        local spd  = 1000 / math.max(State.get("attackDelay") or 200, 1)
        for _, track in ipairs(anim:GetPlayingAnimationTracks()) do
            if track.Speed < spd then track:AdjustSpeed(spd) end
        end
    end)

    RunService.Heartbeat:Connect(function()
        if not GUI.MasterEnabled or not State.get("extendRange") then return end
        local char = getChar(); if not char then return end
        local multi = State.get("rangeMulti") or 3
        for _, d in ipairs(char:GetDescendants()) do
            if d:IsA("BasePart") and d.Name:lower():find("hitbox") then
                d.Size = d.Size * multi
            end
        end
    end)
end

-- ================================================
--  RESET PROPRE vers les valeurs originales
-- ================================================
local function resetAll()
    local hum = getHum()
    if hum then
        hum.WalkSpeed = originalValues.walkSpeed  -- valeur réelle du jeu, pas 16 forcément
        hum.JumpPower = originalValues.jumpPower  -- valeur réelle du jeu, pas 50 forcément
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,     true)
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
    end
    workspace.Gravity = originalValues.gravity    -- gravité réelle du jeu
    stopFly()
    stopNoclip()
    State.CurrentTarget = nil
    fovCircle.Visible   = false
    clearESP()
end

-- ================================================
--  DÉMARRAGE
-- ================================================
function Features.start()

    -- Capture initiale
    if player.Character then captureOriginals() end

    player.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid"); task.wait(0.5)
        flyBV = nil; flyConn = nil; noclipConn = nil
        captureOriginals()
        clearESP()
        task.delay(2, refreshESP)
    end)

    -- Master toggle OFF → reset propre
    table.insert(GUI.MasterToggleCallbacks, function(enabled)
        if not enabled then resetAll() end
    end)

    -- ── HEARTBEAT ────────────────────────────────
    RunService.Heartbeat:Connect(function()
        if not GUI.MasterEnabled then return end
        local hum = getHum()

        -- Speed (remet l'original si désactivé)
        if hum then
            if State.get("speedHack") then
                hum.WalkSpeed = State.get("walkSpeed") or originalValues.walkSpeed
            else
                hum.WalkSpeed = originalValues.walkSpeed
            end
        end

        -- Jump Power (remet l'original si désactivé)
        if hum then
            if State.get("infJump") then
                hum.JumpPower = State.get("jumpPower") or originalValues.jumpPower
            else
                hum.JumpPower = originalValues.jumpPower
            end
        end

        -- Gravity (remet l'originale si désactivé)
        if State.get("lowGravity") then
            workspace.Gravity = State.get("gravityVal") or originalValues.gravity
        else
            workspace.Gravity = originalValues.gravity
        end

        -- Fly
        if State.get("fly") and not flyBV then startFly()
        elseif not State.get("fly") and flyBV then stopFly() end

        -- NoClip
        if State.get("noclip") and not noclipConn then startNoclip()
        elseif not State.get("noclip") and noclipConn then stopNoclip() end

        -- Buddha
        if hum and State.get("buddha") and hum.Health < 1 then hum.Health = 1 end

        -- Anti-Ragdoll
        if hum then
            local ar = State.get("antiRagdoll")
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,     not ar)
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not ar)
        end

        -- Silent Aim
        updateFovCircle()
        if State.get("silentAim") then
            State.CurrentTarget = getBestTarget()
        else
            State.CurrentTarget = nil
            fovCircle.Visible   = false
        end
    end)

    -- Inf Jump (event séparé)
    UserInputService.JumpRequest:Connect(function()
        if not GUI.MasterEnabled or not State.get("infJump") then return end
        local hum = getHum()
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)

    -- ESP refresh périodique
    task.spawn(function()
        while true do
            task.wait(4)
            if GUI.MasterEnabled and State.get("espEnabled") then refreshESP() end
        end
    end)

    -- Blox Fruits
    applyBloxFruitsHooks()

    -- Auto-Rejoin
    task.spawn(function()
        local TS = game:GetService("TeleportService")
        TS.LocalPlayerArrivedFromTeleport:Connect(function()
            if State.get("autoRejoin") then
                task.wait(2)
                loadstring(game:HttpGet(Config.GitHub))()
            end
        end)
    end)

    task.delay(2, refreshESP)
    print("[NexusHub] ✓ Démarré  |  CTRL DROIT = menu  |  Toggle haut = ON/OFF global")
end

-- ================================================
--  CALLBACKS BOUTONS
-- ================================================
function Features.onButtonClick(key)
    if key == "copyGithub" then
        setclipboard(Config.GitHub)
        print("[NexusHub] Lien GitHub copié !")
    end
end



-- ================================================
--  Main.lua  |  NexusHub
--  LocalScript > StarterPlayerScripts > NexusHub
--  Point d'entrée principal
-- ================================================
--
--  ARBORESCENCE ROBLOX STUDIO :
--
--  StarterPlayerScripts
--  └── NexusHub/                  (Folder)
--      ├── Main          → LocalScript   ← CE FICHIER
--      ├── Config        → ModuleScript
--      ├── State         → ModuleScript
--      ├── Components    → ModuleScript
--      ├── GUI           → ModuleScript
--      └── Features      → ModuleScript
--
--  RACCOURCI CLAVIER : CTRL DROIT  (configurable dans Config.lua)
-- ================================================

local TweenService = game:GetService("TweenService")


-- 1. Init state
State.init()

-- 2. Construit l'interface
GUI.build()

-- 3. Sidebar + liaison catégories
local buttons = {}

for _, cat in ipairs(Config.Categories) do
    local btn, accent = GUI.createSidebarButton(cat, function(selectedCat, selectedBtn, selectedAccent)
        GUI.resetSidebarButtons()

        TweenService:Create(selectedBtn, TweenInfo.new(0.15), {
            BackgroundColor3 = Config.Theme.CategoryActive,
            TextColor3       = selectedCat.color,
        }):Play()
        TweenService:Create(selectedAccent, TweenInfo.new(0.15), {
            BackgroundTransparency = 0,
        }):Play()

        GUI.openPanel(selectedCat, Features.onButtonClick)
    end)
    table.insert(buttons, { btn=btn, accent=accent, cat=cat })
end

-- 4. Sélection par défaut : première catégorie
if #buttons > 0 then
    local first = buttons[1]
    TweenService:Create(first.btn, TweenInfo.new(0.15), {
        BackgroundColor3 = Config.Theme.CategoryActive,
        TextColor3       = first.cat.color,
    }):Play()
    TweenService:Create(first.accent, TweenInfo.new(0.15), {
        BackgroundTransparency = 0,
    }):Play()
    GUI.openPanel(first.cat, Features.onButtonClick)
end

-- 5. Animation ouverture
GUI.show()

-- 6. Démarrage des features
Features.start()
