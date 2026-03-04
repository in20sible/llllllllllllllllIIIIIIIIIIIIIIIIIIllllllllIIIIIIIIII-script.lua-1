-- NexusHub | Loader.lua | Fichier unique Xeno
-- CTRL DROIT = ouvrir/fermer | Toggle haut = ON/OFF global

local TS  = game:GetService("TweenService")
local RS  = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local PLS = game:GetService("Players")
local plr = PLS.LocalPlayer
local cam = workspace.CurrentCamera
local GH  = "https://raw.githubusercontent.com/in20sible/llllllllllllllllIIIIIIIIIIIIIIIIIIllllllllIIIIIIIIII-script.lua-1-/main/Loader.lua"

-- ══════════════════════════════════════
-- THEME
-- ══════════════════════════════════════
local T = {
    Bg      = Color3.fromRGB(12,12,18),
    Sidebar = Color3.fromRGB(15,15,22),
    Title   = Color3.fromRGB(18,18,28),
    Accent  = Color3.fromRGB(80,120,255),
    Text    = Color3.fromRGB(200,200,220),
    Dim     = Color3.fromRGB(120,130,160),
    TglOff  = Color3.fromRGB(40,40,55),
    TglOn   = Color3.fromRGB(30,60,100),
    KnOff   = Color3.fromRGB(140,140,160),
    KnOn    = Color3.fromRGB(100,180,255),
    Fill    = Color3.fromRGB(80,140,255),
    BtnBg   = Color3.fromRGB(30,55,110),
    BtnTxt  = Color3.fromRGB(150,200,255),
    BtnStr  = Color3.fromRGB(60,100,200),
    CatOn   = Color3.fromRGB(18,28,55),
    CatOff  = Color3.fromRGB(20,20,32),
    DdBg    = Color3.fromRGB(22,22,34),
    DdHov   = Color3.fromRGB(30,40,70),
    Sec     = Color3.fromRGB(80,100,160),
}

-- ══════════════════════════════════════
-- CATEGORIES
-- ══════════════════════════════════════
local CATS = {
    {name="Update",    icon="🔄", color=Color3.fromRGB(80,200,120),  special="changelog"},
    {name="Mouvement", icon="🏃", color=Color3.fromRGB(100,150,255), content={
        {type="section",text="Vitesse"},
        {type="toggle",text="Speed Hack",     key="speedHack",  default=false},
        {type="slider",text="WalkSpeed",      key="walkSpeed",  min=16,  max=500, default=16},
        {type="section",text="Vol"},
        {type="toggle",text="Fly",            key="fly",        default=false},
        {type="slider",text="Fly Speed",      key="flySpeed",   min=10,  max=300, default=50},
        {type="section",text="Saut & Gravité"},
        {type="toggle",text="Inf Jump",       key="infJump",    default=false},
        {type="slider",text="Jump Power",     key="jumpPower",  min=7,   max=300, default=50},
        {type="toggle",text="Gravity réduite",key="lowGravity", default=false},
        {type="slider",text="Gravity",        key="gravityVal", min=5,   max=196, default=196},
        {type="section",text="Autre"},
        {type="toggle",text="No Clip",        key="noclip",     default=false},
    }},
    {name="Silent Aim",icon="🎯", color=Color3.fromRGB(255,80,80),   content={
        {type="toggle",  text="Silent Aim",      key="silentAim",  default=false},
        {type="slider",  text="FOV Radius",      key="aimFov",     min=10, max=600, default=120},
        {type="toggle",  text="Show FOV Circle", key="showFov",    default=true},
        {type="toggle",  text="Trigger Bot",     key="triggerBot", default=false},
        {type="dropdown",text="Mode visée",      key="aimMode",    options={"Off","Caméra","Souris"}, default="Caméra"},
        {type="toggle",  text="Head Only",       key="headOnly",   default=false},
        {type="section", text="Cible actuelle"},
        {type="targetDisplay"},
    }},
    {name="ESP",       icon="👁️",color=Color3.fromRGB(255,180,50),  content={
        {type="toggle",text="Activer ESP",  key="espEnabled", default=false},
        {type="toggle",text="Barre de vie", key="espHealth",  default=true},
        {type="toggle",text="Nombre HP",    key="espHpNum",   default=true},
        {type="toggle",text="Distance",     key="espDist",    default=true},
        {type="toggle",text="Tracer",       key="espTracer",  default=false},
        {type="toggle",text="Nom joueur",   key="espName",    default=true},
        {type="section",text="Liste joueurs"},
        {type="playerList"},
    }},
    {name="Budda",     icon="🧿", color=Color3.fromRGB(200,100,255), content={
        {type="toggle",text="Buddha Mode",       key="buddha",      default=false},
        {type="label", text="HP bloqué à 1 (anti-mort)"},
        {type="toggle",text="Anti-Ragdoll",      key="antiRagdoll", default=false},
        {type="section",text="Blox Fruits – Combat"},
        {type="toggle",text="Fast Attack",       key="fastAttack",  default=false},
        {type="slider",text="Délai attaque (ms)",key="attackDelay", min=50, max=500, default=200},
        {type="toggle",text="Extend Range",      key="extendRange", default=false},
        {type="slider",text="Range Multiplier",  key="rangeMulti",  min=1,  max=20,  default=3},
    }},
    {name="Settings",  icon="⚙️", color=Color3.fromRGB(160,160,160), content={
        {type="label", text="Touche menu : CTRL Droit"},
        {type="toggle",text="Auto-inject (serv hop)", key="autoRejoin", default=false},
        {type="toggle",text="Notifications",          key="notifs",     default=true},
        {type="section",text="À propos"},
        {type="label", text="NexusHub v1.0.0 | Xeno"},
        {type="button",text="📋 Copier lien GitHub",  key="copyGithub"},
    }},
}

local CHANGELOG = {
    {version="1.0.0", date="2025-01-01", changes={
        "✅ Menu principal créé",
        "✅ Mouvement : Speed, Fly, NoClip, InfJump, Gravity",
        "✅ Silent Aim avec FOV circle et trigger",
        "✅ ESP complet (vie, distance, tracers, liste joueurs)",
        "✅ Budda + boost Blox Fruits",
        "✅ Settings avec auto-rejoin",
    }},
}

-- ══════════════════════════════════════
-- STATE
-- ══════════════════════════════════════
local SV = {}
local PlayerColors = {}
CurrentTarget = nil

local function sg(k) return SV[k] end
local function ss(k,v) SV[k]=v end
local function stgl(k) SV[k]=not SV[k]; return SV[k] end

for _, cat in ipairs(CATS) do
    if cat.content then
        for _, item in ipairs(cat.content) do
            if item.key ~= nil and item.default ~= nil then
                SV[item.key] = item.default
            end
        end
    end
end
SV.aimMode = "Caméra"
SV.autoRejoin = false

-- ══════════════════════════════════════
-- MASTER TOGGLE
-- ══════════════════════════════════════
local MasterOn = true
local MasterCBs = {}
local function fireMaster(v) for _,f in ipairs(MasterCBs) do pcall(f,v) end end

-- ══════════════════════════════════════
-- GUI FRAMES
-- ══════════════════════════════════════
local MainFrame, Sidebar, ContentArea, currentPanel

local function mk(cls, props, parent)
    local i = Instance.new(cls)
    for k,v in pairs(props) do i[k]=v end
    if parent then i.Parent=parent end
    return i
end

local function corner(r, p) local c=Instance.new("UICorner",p); c.CornerRadius=UDim.new(0,r) end
local function stroke(col, thick, p) local s=Instance.new("UIStroke",p); s.Color=col; s.Thickness=thick or 1 end

-- ══════════════════════════════════════
-- BUILD WINDOW
-- ══════════════════════════════════════
local function buildGUI()
    local old = plr.PlayerGui:FindFirstChild("NexusHub")
    if old then old:Destroy() end

    local sg2 = mk("ScreenGui",{Name="NexusHub",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling},plr.PlayerGui)

    MainFrame = mk("Frame",{
        Name="MainFrame", Size=UDim2.new(0,0,0,0),
        Position=UDim2.new(0.5,0,0.5,0), BackgroundColor3=T.Bg,
        BorderSizePixel=0, ClipsDescendants=true
    }, sg2)
    corner(10, MainFrame)
    stroke(T.Accent, 1.5, MainFrame)

    -- Title bar
    local tb = mk("Frame",{Size=UDim2.new(1,0,0,40),BackgroundColor3=T.Title,BorderSizePixel=0},MainFrame)
    mk("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=T.Accent,BorderSizePixel=0},tb)
    mk("TextLabel",{
        Text="⚡ NEXUS HUB", Size=UDim2.new(1,-170,1,0), Position=UDim2.new(0,15,0,0),
        BackgroundTransparency=1, TextColor3=T.Accent, TextSize=16,
        Font=Enum.Font.GothamBold, TextXAlignment=Enum.TextXAlignment.Left
    }, tb)

    -- Master toggle ON/OFF
    local mbg = mk("Frame",{Size=UDim2.new(0,54,0,24),Position=UDim2.new(1,-104,0.5,-12),BackgroundColor3=Color3.fromRGB(40,180,80),BorderSizePixel=0},tb)
    corner(100,mbg); local mst=Instance.new("UIStroke",mbg); mst.Color=Color3.fromRGB(255,255,255); mst.Transparency=0.7
    local mkn = mk("Frame",{Size=UDim2.new(0,18,0,18),Position=UDim2.new(1,-21,0.5,-9),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0},mbg)
    corner(100,mkn)
    local mlt = mk("TextLabel",{Size=UDim2.new(0,28,1,0),Position=UDim2.new(0,4,0,0),BackgroundTransparency=1,Text="ON",TextColor3=Color3.fromRGB(255,255,255),TextSize=10,Font=Enum.Font.GothamBold},mbg)

    local function refreshMaster()
        local on = MasterOn
        TS:Create(mkn,TweenInfo.new(0.18),{Position=on and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)}):Play()
        TS:Create(mbg,TweenInfo.new(0.18),{BackgroundColor3=on and Color3.fromRGB(40,180,80) or Color3.fromRGB(160,40,40)}):Play()
        mlt.Text = on and "ON" or "OFF"
        mlt.Position = on and UDim2.new(0,4,0,0) or UDim2.new(0,22,0,0)
        fireMaster(on)
    end
    mbg.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then
            MasterOn=not MasterOn; refreshMaster()
        end
    end)

    -- Close button
    local cl = mk("TextButton",{Text="✕",Size=UDim2.new(0,28,0,28),Position=UDim2.new(1,-36,0,6),BackgroundColor3=Color3.fromRGB(180,40,40),TextColor3=Color3.fromRGB(255,255,255),TextSize=13,Font=Enum.Font.GothamBold,BorderSizePixel=0},tb)
    corner(6,cl)
    cl.MouseButton1Click:Connect(function()
        TS:Create(MainFrame,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.new(0,0,0,0),Position=UDim2.new(0.5,0,0.5,0)}):Play()
        task.delay(0.22,function() MainFrame.Visible=false end)
    end)

    -- Sidebar
    Sidebar = mk("Frame",{Size=UDim2.new(0,155,1,-40),Position=UDim2.new(0,0,0,40),BackgroundColor3=T.Sidebar,BorderSizePixel=0},MainFrame)
    -- separateur (hors UIListLayout)
    local sbSep=Instance.new("Frame")
    sbSep.Size=UDim2.new(0,1,1,-40); sbSep.Position=UDim2.new(0,154,0,40)
    sbSep.BackgroundColor3=Color3.fromRGB(30,50,100); sbSep.BorderSizePixel=0; sbSep.Parent=MainFrame
    local sbl=Instance.new("UIListLayout",Sidebar); sbl.Padding=UDim.new(0,4)
    local sbp=Instance.new("UIPadding",Sidebar); sbp.PaddingTop=UDim.new(0,8); sbp.PaddingLeft=UDim.new(0,8); sbp.PaddingRight=UDim.new(0,8)

    -- Content area
    ContentArea = mk("Frame",{Size=UDim2.new(1,-155,1,-40),Position=UDim2.new(0,155,0,40),BackgroundTransparency=1},MainFrame)

    -- Drag
    local drag,ds,sp = false,nil,nil
    tb.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true;ds=i.Position;sp=MainFrame.Position end
    end)
    tb.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
            local d=i.Position-ds
            MainFrame.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
        end
    end)

    -- CTRL DROIT toggle
    UIS.InputBegan:Connect(function(i,gpe)
        if gpe then return end
        if i.KeyCode==Enum.KeyCode.RightControl then
            if MainFrame.Visible then
                TS:Create(MainFrame,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.new(0,0,0,0),Position=UDim2.new(0.5,0,0.5,0)}):Play()
                task.delay(0.22,function() MainFrame.Visible=false end)
            else
                MainFrame.Visible=true
                TS:Create(MainFrame,TweenInfo.new(0.35,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,640,0,420),Position=UDim2.new(0.5,-320,0.5,-210)}):Play()
            end
        end
    end)
end

-- ══════════════════════════════════════
-- SIDEBAR BUTTONS
-- ══════════════════════════════════════
local function resetSidebar()
    for _,c in ipairs(Sidebar:GetChildren()) do
        if c:IsA("TextButton") then
            TS:Create(c,TweenInfo.new(0.15),{BackgroundColor3=T.CatOff,TextColor3=T.Dim}):Play()
            local ac=c:FindFirstChildOfClass("Frame")
            if ac then TS:Create(ac,TweenInfo.new(0.15),{BackgroundTransparency=1}):Play() end
        end
    end
end

local function makeSidebarBtn(cat, onSelect)
    local btn = mk("TextButton",{
        Text=cat.icon.."  "..cat.name, Size=UDim2.new(1,0,0,36),
        BackgroundColor3=T.CatOff, TextColor3=T.Dim, TextSize=13,
        Font=Enum.Font.Gotham, TextXAlignment=Enum.TextXAlignment.Left,
        BorderSizePixel=0
    }, Sidebar)
    corner(6,btn)
    local acc=mk("Frame",{Size=UDim2.new(0,3,0.6,0),Position=UDim2.new(0,0,0.2,0),BackgroundColor3=cat.color,BackgroundTransparency=1,BorderSizePixel=0},btn)
    corner(100,acc)
    local lp=Instance.new("UIPadding",btn); lp.PaddingLeft=UDim.new(0,12)
    btn.MouseButton1Click:Connect(function() onSelect(cat,btn,acc) end)
    return btn, acc
end

-- ══════════════════════════════════════
-- COMPONENTS
-- ══════════════════════════════════════
local function makeToggle(parent, cfg)
    local row=mk("Frame",{Size=UDim2.new(1,-20,0,34),BackgroundTransparency=1},parent)
    mk("TextLabel",{Text=cfg.text,Size=UDim2.new(0.72,0,1,0),BackgroundTransparency=1,TextColor3=T.Text,TextSize=13,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},row)
    local bg=mk("Frame",{Size=UDim2.new(0,44,0,22),Position=UDim2.new(1,-44,0.5,-11),BackgroundColor3=T.TglOff,BorderSizePixel=0},row)
    corner(100,bg)
    local kn=mk("Frame",{Size=UDim2.new(0,18,0,18),Position=UDim2.new(0,2,0.5,-9),BackgroundColor3=T.KnOff,BorderSizePixel=0},bg)
    corner(100,kn)
    local function rf()
        local on=sg(cfg.key)
        TS:Create(kn,TweenInfo.new(0.15),{Position=on and UDim2.new(0,24,0.5,-9) or UDim2.new(0,2,0.5,-9),BackgroundColor3=on and T.KnOn or T.KnOff}):Play()
        TS:Create(bg,TweenInfo.new(0.15),{BackgroundColor3=on and T.TglOn or T.TglOff}):Play()
    end
    rf()
    bg.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then stgl(cfg.key);rf() end end)
end

local function makeSlider(parent, cfg)
    local row=mk("Frame",{Size=UDim2.new(1,-20,0,48),BackgroundTransparency=1},parent)
    local lb=mk("TextLabel",{Text=cfg.text.." : "..tostring(cfg.default),Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,TextColor3=T.Text,TextSize=13,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},row)
    local tr=mk("Frame",{Size=UDim2.new(1,0,0,6),Position=UDim2.new(0,0,0,32),BackgroundColor3=T.TglOff,BorderSizePixel=0},row)
    corner(100,tr)
    local p0=(cfg.default-cfg.min)/(cfg.max-cfg.min)
    local fi=mk("Frame",{Size=UDim2.new(p0,0,1,0),BackgroundColor3=T.Fill,BorderSizePixel=0},tr); corner(100,fi)
    local kn=mk("Frame",{Size=UDim2.new(0,14,0,14),Position=UDim2.new(p0,-7,0.5,-7),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0},tr); corner(100,kn)
    local drag=false
    local function ap(mx)
        local r=math.clamp((mx-tr.AbsolutePosition.X)/tr.AbsoluteSize.X,0,1)
        local v=math.floor(cfg.min+r*(cfg.max-cfg.min))
        ss(cfg.key,v); lb.Text=cfg.text.." : "..v
        fi.Size=UDim2.new(r,0,1,0); kn.Position=UDim2.new(r,-7,0.5,-7)
    end
    kn.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true end end)
    tr.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true;ap(i.Position.X) end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
    UIS.InputChanged:Connect(function(i) if drag and i.UserInputType==Enum.UserInputType.MouseMovement then ap(i.Position.X) end end)
end

local function makeLabel(parent, cfg)
    mk("TextLabel",{Text="• "..cfg.text,Size=UDim2.new(1,-20,0,22),BackgroundTransparency=1,TextColor3=T.Dim,TextSize=12,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},parent)
end

local function makeSection(parent, cfg)
    local row=mk("Frame",{Size=UDim2.new(1,-20,0,26),BackgroundTransparency=1},parent)
    mk("TextLabel",{Text=cfg.text,Size=UDim2.new(0,120,1,0),BackgroundTransparency=1,TextColor3=T.Sec,TextSize=11,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},row)
    local ln=mk("Frame",{Size=UDim2.new(1,-130,0,1),Position=UDim2.new(0,130,0.5,0),BackgroundColor3=T.Sec,BackgroundTransparency=0.5,BorderSizePixel=0},row)
end

local function makeButton(parent, cfg, onClick)
    local bt=mk("TextButton",{Text=cfg.text,Size=UDim2.new(1,-20,0,32),BackgroundColor3=T.BtnBg,TextColor3=T.BtnTxt,TextSize=13,Font=Enum.Font.GothamBold,BorderSizePixel=0},parent)
    corner(6,bt); stroke(T.BtnStr,1,bt)
    bt.MouseButton1Click:Connect(function() if onClick then onClick(cfg.key) end end)
end

local function makeDropdown(parent, cfg)
    ss(cfg.key, cfg.default)
    local wr=mk("Frame",{Size=UDim2.new(1,-20,0,34),BackgroundTransparency=1,ClipsDescendants=false},parent)
    mk("TextLabel",{Text=cfg.text,Size=UDim2.new(0.45,0,1,0),BackgroundTransparency=1,TextColor3=T.Text,TextSize=13,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},wr)
    local sel=mk("TextButton",{Text=cfg.default.." ▾",Size=UDim2.new(0.52,0,0,28),Position=UDim2.new(0.48,0,0.5,-14),BackgroundColor3=T.DdBg,TextColor3=T.Text,TextSize=12,Font=Enum.Font.Gotham,BorderSizePixel=0,ZIndex=5},wr)
    corner(6,sel); stroke(T.Accent,1,sel)
    local mn=mk("Frame",{Size=UDim2.new(0.52,0,0,#cfg.options*28),Position=UDim2.new(0.48,0,1,2),BackgroundColor3=T.DdBg,BorderSizePixel=0,ZIndex=10,Visible=false},wr)
    corner(6,mn); stroke(T.Accent,1,mn)
    Instance.new("UIListLayout",mn)
    for _,opt in ipairs(cfg.options) do
        local ob=mk("TextButton",{Text=opt,Size=UDim2.new(1,0,0,28),BackgroundColor3=T.DdBg,TextColor3=T.Text,TextSize=12,Font=Enum.Font.Gotham,BorderSizePixel=0,ZIndex=11},mn)
        ob.MouseEnter:Connect(function() TS:Create(ob,TweenInfo.new(0.1),{BackgroundColor3=T.DdHov}):Play() end)
        ob.MouseLeave:Connect(function() TS:Create(ob,TweenInfo.new(0.1),{BackgroundColor3=T.DdBg}):Play() end)
        ob.MouseButton1Click:Connect(function() ss(cfg.key,opt);sel.Text=opt.." ▾";mn.Visible=false end)
    end
    sel.MouseButton1Click:Connect(function() mn.Visible=not mn.Visible end)
end

local function makeTargetDisplay(parent)
    local fr=mk("Frame",{Size=UDim2.new(1,-20,0,42),BackgroundColor3=T.DdBg,BorderSizePixel=0},parent)
    corner(6,fr); stroke(T.Sec,1,fr)
    local dt=mk("Frame",{Size=UDim2.new(0,10,0,10),Position=UDim2.new(0,12,0.5,-5),BackgroundColor3=Color3.fromRGB(100,100,120),BorderSizePixel=0},fr); corner(100,dt)
    local nl=mk("TextLabel",{Text="Aucune cible",Size=UDim2.new(1,-36,1,0),Position=UDim2.new(0,32,0,0),BackgroundTransparency=1,TextColor3=T.Dim,TextSize=13,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},fr)
    RS.Heartbeat:Connect(function()
        local t=CurrentTarget
        if t and t.Character then
            local h=t.Character:FindFirstChildOfClass("Humanoid")
            nl.Text=t.Name.."  |  "..(h and math.floor(h.Health) or "?").." HP"
            nl.TextColor3=Color3.fromRGB(100,220,130); dt.BackgroundColor3=Color3.fromRGB(50,220,80)
        else
            nl.Text="Aucune cible"; nl.TextColor3=T.Dim; dt.BackgroundColor3=Color3.fromRGB(100,100,120)
        end
    end)
end

local function makePlayerList(parent)
    local ct=mk("Frame",{Size=UDim2.new(1,-20,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1},parent)
    local ll=Instance.new("UIListLayout",ct); ll.Padding=UDim.new(0,3)
    local function rb()
        for _,c in ipairs(ct:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        for _,p in ipairs(PLS:GetPlayers()) do
            if p==plr then continue end
            local cs=PlayerColors[p.UserId] or "default"
            local bgC=cs=="green" and Color3.fromRGB(20,60,30) or cs=="red" and Color3.fromRGB(60,20,20) or T.DdBg
            local rw=mk("TextButton",{Text="",Size=UDim2.new(1,0,0,28),BackgroundColor3=bgC,BorderSizePixel=0},ct); corner(5,rw)
            local dt=mk("Frame",{Size=UDim2.new(0,8,0,8),Position=UDim2.new(0,8,0.5,-4),BackgroundColor3=cs=="green" and Color3.fromRGB(50,220,80) or cs=="red" and Color3.fromRGB(220,50,50) or Color3.fromRGB(100,100,130),BorderSizePixel=0},rw); corner(100,dt)
            mk("TextLabel",{Text=p.Name,Size=UDim2.new(1,-24,1,0),Position=UDim2.new(0,22,0,0),BackgroundTransparency=1,TextColor3=T.Text,TextSize=12,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},rw)
            rw.MouseButton1Click:Connect(function() PlayerColors[p.UserId]=PlayerColors[p.UserId]=="green" and "default" or "green";rb() end)
            rw.MouseButton2Click:Connect(function() PlayerColors[p.UserId]=PlayerColors[p.UserId]=="red" and "default" or "red";rb() end)
        end
    end
    rb()
    PLS.PlayerAdded:Connect(rb)
    PLS.PlayerRemoving:Connect(function() task.wait(0.1);rb() end)
    mk("TextLabel",{Text="Clic gauche=🟢  Clic droit=🔴",Size=UDim2.new(1,-20,0,18),BackgroundTransparency=1,TextColor3=T.Dim,TextSize=10,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left},parent)
end

local function makeChangelog(parent)
    for _,e in ipairs(CHANGELOG) do
        local hd=mk("Frame",{Size=UDim2.new(1,-20,0,30),BackgroundColor3=Color3.fromRGB(20,40,20),BorderSizePixel=0},parent); corner(6,hd)
        mk("TextLabel",{Text="v"..e.version,Size=UDim2.new(0.4,0,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,TextColor3=Color3.fromRGB(80,220,110),TextSize=14,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},hd)
        mk("TextLabel",{Text=e.date,Size=UDim2.new(0.5,0,1,0),Position=UDim2.new(0.5,0,0,0),BackgroundTransparency=1,TextColor3=T.Dim,TextSize=11,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Right},hd)
        for _,ln in ipairs(e.changes) do
            mk("TextLabel",{Text="  "..ln,Size=UDim2.new(1,-20,0,20),BackgroundTransparency=1,TextColor3=T.Text,TextSize=12,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true},parent)
        end
        mk("Frame",{Size=UDim2.new(1,0,0,6),BackgroundTransparency=1},parent)
    end
end

-- ══════════════════════════════════════
-- OPEN PANEL
-- ══════════════════════════════════════
local function openPanel(cat, onBtn)
    if currentPanel then currentPanel:Destroy() end
    local sc=mk("ScrollingFrame",{
        Size=UDim2.new(1,-10,1,-10), Position=UDim2.new(0,5,0,5),
        BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=3,
        ScrollBarImageColor3=T.Accent, CanvasSize=UDim2.new(0,0,0,0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y
    }, ContentArea)
    local ly=Instance.new("UIListLayout",sc); ly.Padding=UDim.new(0,5)
    local pd=Instance.new("UIPadding",sc); pd.PaddingTop=UDim.new(0,8); pd.PaddingLeft=UDim.new(0,10)

    -- Category header
    mk("TextLabel",{Text=cat.icon.."  "..cat.name,Size=UDim2.new(1,-20,0,28),BackgroundTransparency=1,TextColor3=cat.color,TextSize=16,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},sc)
    mk("Frame",{Size=UDim2.new(1,-20,0,1),BackgroundColor3=cat.color,BackgroundTransparency=0.6,BorderSizePixel=0},sc)

    if cat.special=="changelog" then
        makeChangelog(sc)
    elseif cat.content then
        for _,item in ipairs(cat.content) do
            if     item.type=="toggle"        then makeToggle(sc,item)
            elseif item.type=="slider"        then makeSlider(sc,item)
            elseif item.type=="label"         then makeLabel(sc,item)
            elseif item.type=="section"       then makeSection(sc,item)
            elseif item.type=="button"        then makeButton(sc,item,onBtn)
            elseif item.type=="dropdown"      then makeDropdown(sc,item)
            elseif item.type=="targetDisplay" then makeTargetDisplay(sc)
            elseif item.type=="playerList"    then makePlayerList(sc)
            end
        end
    end
    currentPanel=sc
end

-- ══════════════════════════════════════
-- FEATURES
-- ══════════════════════════════════════
local orig={ws=16,jp=50,grav=196.2}
local function getHum() local c=plr.Character; return c and c:FindFirstChildOfClass("Humanoid") end
local function getRoot() local c=plr.Character; return c and c:FindFirstChild("HumanoidRootPart") end
local function captureOrig()
    local h=getHum()
    if h then
        if not sg("speedHack") then orig.ws=h.WalkSpeed end
        if not sg("infJump")   then orig.jp=h.JumpPower  end
    end
    if not sg("lowGravity") then orig.grav=workspace.Gravity end
end

-- Fly
local flyBV,flyConn
local function stopFly()
    if flyConn then flyConn:Disconnect();flyConn=nil end
    if flyBV   then flyBV:Destroy();flyBV=nil end
end
local function startFly()
    if flyBV then return end
    local root=getRoot(); if not root then return end
    flyBV=Instance.new("BodyVelocity"); flyBV.MaxForce=Vector3.new(1e5,1e5,1e5); flyBV.Velocity=Vector3.zero; flyBV.Parent=root
    flyConn=RS.Heartbeat:Connect(function()
        if not sg("fly") or not MasterOn then stopFly();return end
        local sp=sg("flySpeed") or 50; local cf=cam.CFrame; local dir=Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir+=cf.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir-=cf.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir-=cf.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir+=cf.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir+=Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir-=Vector3.new(0,1,0) end
        flyBV.Velocity=dir.Magnitude>0 and dir.Unit*sp or Vector3.zero
    end)
end

-- NoClip
local ncConn
local function stopNC()
    if ncConn then ncConn:Disconnect();ncConn=nil end
    local c=plr.Character; if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=true end end end
end
local function startNC()
    if ncConn then return end
    ncConn=RS.Stepped:Connect(function()
        if not sg("noclip") or not MasterOn then stopNC();return end
        local c=plr.Character; if not c then return end
        for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
    end)
end

-- Silent Aim FOV circle
local fovCircle=Drawing.new("Circle")
fovCircle.Visible=false; fovCircle.Thickness=1.5; fovCircle.Color=Color3.fromRGB(255,80,80); fovCircle.Filled=false; fovCircle.NumSides=64

local function getOrigin()
    if sg("aimMode")=="Caméra" then return cam.ViewportSize/2 end
    local mp=UIS:GetMouseLocation(); return Vector2.new(mp.X,mp.Y)
end
local function getBest()
    local org=getOrigin(); local fovR=sg("aimFov") or 120; local best,bd=nil,fovR
    for _,p in ipairs(PLS:GetPlayers()) do
        if p==plr then continue end
        local c=p.Character; if not c then continue end
        local pt=sg("headOnly") and c:FindFirstChild("Head") or c:FindFirstChild("HumanoidRootPart"); if not pt then continue end
        local h=c:FindFirstChildOfClass("Humanoid"); if not h or h.Health<=0 then continue end
        local sp,os=cam:WorldToViewportPoint(pt.Position); if not os then continue end
        local d=(Vector2.new(sp.X,sp.Y)-org).Magnitude; if d<bd then bd=d;best=p end
    end; return best
end

-- ESP
local espO={}
local function clearESP()
    for _,v in pairs(espO) do
        if typeof(v)=="Instance" and v.Parent then v:Destroy()
        elseif typeof(v)=="RBXScriptConnection" then v:Disconnect()
        else pcall(function() v:Remove() end) end
    end; espO={}
end
local function buildESP(tgt)
    if tgt==plr then return end
    local ch=tgt.Character; if not ch then return end
    local rt=ch:FindFirstChild("HumanoidRootPart"); if not rt then return end
    local hm=ch:FindFirstChildOfClass("Humanoid")
    local bb=mk("BillboardGui",{Name="ESP_"..tgt.Name,Size=UDim2.new(0,130,0,62),StudsOffset=Vector3.new(0,3.5,0),AlwaysOnTop=true},rt)
    local nl=mk("TextLabel",{Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,TextColor3=Color3.fromRGB(255,255,255),TextStrokeTransparency=0.4,TextSize=13,Font=Enum.Font.GothamBold,Text=tgt.Name},bb)
    local bbg=mk("Frame",{Size=UDim2.new(1,0,0,6),Position=UDim2.new(0,0,0,19),BackgroundColor3=Color3.fromRGB(40,10,10),BorderSizePixel=0},bb); corner(100,bbg)
    local bfi=mk("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.fromRGB(50,220,80),BorderSizePixel=0},bbg); corner(100,bfi)
    local hl=mk("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,27),BackgroundTransparency=1,TextColor3=Color3.fromRGB(210,210,210),TextStrokeTransparency=0.5,TextSize=11,Font=Enum.Font.Gotham},bb)
    local dl=mk("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,43),BackgroundTransparency=1,TextColor3=Color3.fromRGB(160,160,255),TextStrokeTransparency=0.5,TextSize=10,Font=Enum.Font.Gotham},bb)
    local ln=Drawing.new("Line"); ln.Visible=false; ln.Color=Color3.fromRGB(255,180,50); ln.Thickness=1
    local cn=RS.Heartbeat:Connect(function()
        local on=MasterOn and sg("espEnabled"); bb.Enabled=on; ln.Visible=false
        if not on or not (hm and hm.Parent and rt and rt.Parent) then return end
        nl.Visible=sg("espName"); bbg.Visible=sg("espHealth"); hl.Visible=sg("espHpNum"); dl.Visible=sg("espDist")
        local pct=math.clamp(hm.Health/math.max(hm.MaxHealth,1),0,1)
        bfi.Size=UDim2.new(pct,0,1,0)
        bfi.BackgroundColor3=Color3.fromRGB(math.clamp(math.floor((1-pct)*220+30),0,255),math.clamp(math.floor(pct*200+20),0,255),30)
        hl.Text=math.floor(hm.Health).." / "..math.floor(hm.MaxHealth).." HP"
        local mr=getRoot(); if mr then dl.Text=math.floor((mr.Position-rt.Position).Magnitude).." studs" end
        if sg("espTracer") then
            local sp2,os=cam:WorldToViewportPoint(rt.Position)
            if os then ln.Visible=true; ln.From=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y); ln.To=Vector2.new(sp2.X,sp2.Y) end
        end
    end)
    table.insert(espO,bb); table.insert(espO,ln); table.insert(espO,cn)
end
local function refreshESP() clearESP(); for _,p in ipairs(PLS:GetPlayers()) do buildESP(p) end end

local function resetAll()
    local h=getHum()
    if h then h.WalkSpeed=orig.ws; h.JumpPower=orig.jp; h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true); h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true) end
    workspace.Gravity=orig.grav; stopFly(); stopNC(); CurrentTarget=nil; fovCircle.Visible=false; clearESP()
end

table.insert(MasterCBs,function(en) if not en then resetAll() end end)

-- Main loop
RS.Heartbeat:Connect(function()
    if not MasterOn then return end
    local h=getHum()
    if h then
        h.WalkSpeed=sg("speedHack") and (sg("walkSpeed") or orig.ws) or orig.ws
        h.JumpPower=sg("infJump")   and (sg("jumpPower") or orig.jp) or orig.jp
        if sg("buddha") and h.Health<1 then h.Health=1 end
        local ar=sg("antiRagdoll"); h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,not ar); h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,not ar)
    end
    workspace.Gravity=sg("lowGravity") and (sg("gravityVal") or 196.2) or orig.grav
    if sg("fly") and not flyBV then startFly() elseif not sg("fly") and flyBV then stopFly() end
    if sg("noclip") and not ncConn then startNC() elseif not sg("noclip") and ncConn then stopNC() end
    local showFov=MasterOn and sg("silentAim") and sg("showFov")
    fovCircle.Visible=showFov
    if showFov then fovCircle.Position=getOrigin(); fovCircle.Radius=sg("aimFov") or 120 end
    if sg("silentAim") then CurrentTarget=getBest() else CurrentTarget=nil; fovCircle.Visible=false end
end)
UIS.JumpRequest:Connect(function()
    if not MasterOn or not sg("infJump") then return end
    local h=getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
end)
RS.Heartbeat:Connect(function()
    if not MasterOn or not sg("fastAttack") then return end
    local c=plr.Character; if not c then return end
    local h=c:FindFirstChildOfClass("Humanoid"); if not h then return end
    local a=h:FindFirstChildOfClass("Animator"); if not a then return end
    local sp=1000/math.max(sg("attackDelay") or 200,1)
    for _,t in ipairs(a:GetPlayingAnimationTracks()) do if t.Speed<sp then t:AdjustSpeed(sp) end end
end)
RS.Heartbeat:Connect(function()
    if not MasterOn or not sg("extendRange") then return end
    local c=plr.Character; if not c then return end
    for _,d in ipairs(c:GetDescendants()) do
        if d:IsA("BasePart") and d.Name:lower():find("hitbox") then d.Size=d.Size*(sg("rangeMulti") or 3) end
    end
end)
task.spawn(function() while true do task.wait(4); if MasterOn and sg("espEnabled") then refreshESP() end end end)

-- ══════════════════════════════════════
-- INIT
-- ══════════════════════════════════════
buildGUI()

-- Rempli la sidebar
local btns={}
for _,cat in ipairs(CATS) do
    local btn,acc=makeSidebarBtn(cat,function(sc,sb,sa)
        resetSidebar()
        TS:Create(sb,TweenInfo.new(0.15),{BackgroundColor3=T.CatOn,TextColor3=sc.color}):Play()
        TS:Create(sa,TweenInfo.new(0.15),{BackgroundTransparency=0}):Play()
        openPanel(sc,function(key)
            if key=="copyGithub" then setclipboard(GH); print("[NexusHub] Lien copié !") end
        end)
    end)
    table.insert(btns,{btn=btn,acc=acc,cat=cat})
end

-- Sélectionne la première catégorie
if #btns>0 then
    local f=btns[1]
    TS:Create(f.btn,TweenInfo.new(0.15),{BackgroundColor3=T.CatOn,TextColor3=f.cat.color}):Play()
    TS:Create(f.acc,TweenInfo.new(0.15),{BackgroundTransparency=0}):Play()
    openPanel(f.cat,function() end)
end

-- Animation ouverture
MainFrame.Visible=true
TS:Create(MainFrame,TweenInfo.new(0.35,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
    Size=UDim2.new(0,640,0,420), Position=UDim2.new(0.5,-320,0.5,-210)
}):Play()

-- Capture valeurs originales
if plr.Character then captureOrig() end
plr.CharacterAdded:Connect(function(c)
    c:WaitForChild("Humanoid"); task.wait(0.5)
    flyBV=nil; flyConn=nil; ncConn=nil
    captureOrig(); clearESP(); task.delay(2,refreshESP)
end)
task.delay(2,refreshESP)

-- Auto-rejoin
task.spawn(function()
    local TS2=game:GetService("TeleportService")
    TS2.LocalPlayerArrivedFromTeleport:Connect(function()
        if sg("autoRejoin") then task.wait(2); loadstring(game:HttpGet(GH))() end
    end)
end)

print("[NexusHub] ✓ Chargé !  CTRL DROIT = ouvrir/fermer  |  Toggle haut = ON/OFF")
