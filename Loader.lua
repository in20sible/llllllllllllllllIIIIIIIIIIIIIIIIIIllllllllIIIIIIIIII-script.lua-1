local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local plr              = Players.LocalPlayer
local cam              = workspace.CurrentCamera
local GITHUB_URL       = "https://raw.githubusercontent.com/in20sible/llllllllllllllllIIIIIIIIIIIIIIIIIIllllllllIIIIIIIIII-script.lua-1/main/Loader.lua"

if plr.PlayerGui:FindFirstChild("NexusHub") then
    plr.PlayerGui.NexusHub:Destroy()
end

local F = {
    speedHack=false, walkSpeed=16, fly=false, flySpeed=50,
    infJump=false, jumpPower=50, lowGravity=false, gravityVal=100, noclip=false,
    silentAim=false, aimFov=120, showFov=true, triggerBot=false, aimMode="Camera", headOnly=false,
    espEnabled=false, espHealth=true, espHpNum=true, espDist=true, espTracer=false, espName=true,
    buddha=false, antiRagdoll=false, fastAttack=false, attackDelay=200, extendRange=false, rangeMulti=3,
    autoRejoin=false, notifs=true,
}
local ORIG = {ws=16, jp=50, grav=196.2}
local function captureOrig()
    local c = plr.Character
    local h = c and c:FindFirstChildOfClass("Humanoid")
    if h then
        if not F.speedHack then ORIG.ws = h.WalkSpeed end
        if not F.infJump   then ORIG.jp = h.JumpPower  end
    end
    if not F.lowGravity then ORIG.grav = workspace.Gravity end
end

local MASTER = true
local masterCBs = {}
local function fireMaster(v) for _,f in ipairs(masterCBs) do pcall(f,v) end end
local espColors = {}
local currentTarget = nil
local function getChar()  return plr.Character end
local function getHum()   local c=getChar(); return c and c:FindFirstChildOfClass("Humanoid") end
local function getRoot()  local c=getChar(); return c and c:FindFirstChild("HumanoidRootPart") end

local SG = Instance.new("ScreenGui")
SG.Name = "NexusHub"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.Parent = plr.PlayerGui

local Win = Instance.new("Frame")
Win.Name = "Win"
Win.Size = UDim2.new(0,650,0,430)
Win.Position = UDim2.new(0.5,-325,0.5,-215)
Win.BackgroundColor3 = Color3.fromRGB(12,12,18)
Win.BorderSizePixel = 0
Win.Parent = SG
do local c=Instance.new("UICorner",Win); c.CornerRadius=UDim.new(0,10) end
do local s=Instance.new("UIStroke",Win); s.Color=Color3.fromRGB(80,120,255); s.Thickness=1.5 end

local TB = Instance.new("Frame")
TB.Size = UDim2.new(1,0,0,42)
TB.BackgroundColor3 = Color3.fromRGB(18,18,28)
TB.BorderSizePixel = 0
TB.Parent = Win

local TL = Instance.new("TextLabel")
TL.Text = "   NEXUS HUB"
TL.Size = UDim2.new(1,-210,1,0)
TL.Position = UDim2.new(0,0,0,0)
TL.BackgroundTransparency = 1
TL.TextColor3 = Color3.fromRGB(80,120,255)
TL.TextSize = 17
TL.Font = Enum.Font.GothamBold
TL.TextXAlignment = Enum.TextXAlignment.Left
TL.Parent = TB

do local l=Instance.new("Frame",TB); l.Size=UDim2.new(1,0,0,1); l.Position=UDim2.new(0,0,1,-1); l.BackgroundColor3=Color3.fromRGB(80,120,255); l.BorderSizePixel=0 end

local MBG = Instance.new("Frame")
MBG.Size = UDim2.new(0,56,0,26)
MBG.Position = UDim2.new(1,-104,0.5,-13)
MBG.BackgroundColor3 = Color3.fromRGB(40,180,80)
MBG.BorderSizePixel = 0
MBG.Parent = TB
do local c=Instance.new("UICorner",MBG); c.CornerRadius=UDim.new(1,0) end

local MKN = Instance.new("Frame")
MKN.Size = UDim2.new(0,20,0,20)
MKN.Position = UDim2.new(1,-23,0.5,-10)
MKN.BackgroundColor3 = Color3.fromRGB(255,255,255)
MKN.BorderSizePixel = 0
MKN.Parent = MBG
do local c=Instance.new("UICorner",MKN); c.CornerRadius=UDim.new(1,0) end

local MLT = Instance.new("TextLabel")
MLT.Text = "ON"; MLT.Size = UDim2.new(0,30,1,0); MLT.Position = UDim2.new(0,4,0,0)
MLT.BackgroundTransparency = 1; MLT.TextColor3 = Color3.fromRGB(255,255,255)
MLT.TextSize = 11; MLT.Font = Enum.Font.GothamBold; MLT.Parent = MBG

local function refreshMaster()
    local on = MASTER
    TweenService:Create(MKN,TweenInfo.new(0.18),{Position=on and UDim2.new(1,-23,0.5,-10) or UDim2.new(0,3,0.5,-10)}):Play()
    TweenService:Create(MBG,TweenInfo.new(0.18),{BackgroundColor3=on and Color3.fromRGB(40,180,80) or Color3.fromRGB(160,40,40)}):Play()
    MLT.Text = on and "ON" or "OFF"
    MLT.Position = on and UDim2.new(0,4,0,0) or UDim2.new(0,24,0,0)
    fireMaster(on)
end
MBG.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then MASTER=not MASTER; refreshMaster() end
end)

local CL = Instance.new("TextButton")
CL.Text="X"; CL.Size=UDim2.new(0,30,0,30); CL.Position=UDim2.new(1,-40,0.5,-15)
CL.BackgroundColor3=Color3.fromRGB(180,40,40); CL.TextColor3=Color3.fromRGB(255,255,255)
CL.TextSize=14; CL.Font=Enum.Font.GothamBold; CL.BorderSizePixel=0; CL.Parent=TB
do local c=Instance.new("UICorner",CL); c.CornerRadius=UDim.new(0,6) end
CL.MouseButton1Click:Connect(function() Win.Visible=false end)

local SB = Instance.new("Frame")
SB.Name = "Sidebar"
SB.Size = UDim2.new(0,158,1,-42)
SB.Position = UDim2.new(0,0,0,42)
SB.BackgroundColor3 = Color3.fromRGB(15,15,22)
SB.BorderSizePixel = 0
SB.Parent = Win

do
    local l=Instance.new("UIListLayout",SB)
    l.Padding=UDim.new(0,5)
    l.SortOrder=Enum.SortOrder.LayoutOrder
    local p=Instance.new("UIPadding",SB)
    p.PaddingTop=UDim.new(0,10); p.PaddingLeft=UDim.new(0,8); p.PaddingRight=UDim.new(0,8)
end

do
    local l=Instance.new("Frame",Win)
    l.Size=UDim2.new(0,1,1,-42); l.Position=UDim2.new(0,158,0,42)
    l.BackgroundColor3=Color3.fromRGB(40,60,120); l.BorderSizePixel=0
end

local CA = Instance.new("Frame")
CA.Name = "Content"
CA.Size = UDim2.new(1,-160,1,-43)
CA.Position = UDim2.new(0,160,0,43)
CA.BackgroundTransparency = 1
CA.ClipsDescendants = true
CA.Parent = Win

local currentPanel = nil
local function openPanel(buildFn)
    if currentPanel then currentPanel:Destroy() end
    local sc = Instance.new("ScrollingFrame")
    sc.Size = UDim2.new(1,-6,1,-6); sc.Position = UDim2.new(0,3,0,3)
    sc.BackgroundTransparency=1; sc.BorderSizePixel=0
    sc.ScrollBarThickness=3; sc.ScrollBarImageColor3=Color3.fromRGB(80,120,255)
    sc.CanvasSize=UDim2.new(0,0,0,0); sc.AutomaticCanvasSize=Enum.AutomaticSize.Y
    sc.Parent = CA
    do
        local l=Instance.new("UIListLayout",sc); l.Padding=UDim.new(0,6)
        local p=Instance.new("UIPadding",sc)
        p.PaddingTop=UDim.new(0,10); p.PaddingLeft=UDim.new(0,12); p.PaddingRight=UDim.new(0,8)
    end
    buildFn(sc)
    currentPanel = sc
end

local function mkToggle(parent, label, get, set)
    local row=Instance.new("Frame"); row.Size=UDim2.new(1,-6,0,36); row.BackgroundTransparency=1; row.Parent=parent
    local lb=Instance.new("TextLabel"); lb.Text=label; lb.Size=UDim2.new(1,-56,1,0)
    lb.BackgroundTransparency=1; lb.TextColor3=Color3.fromRGB(200,200,220); lb.TextSize=13
    lb.Font=Enum.Font.Gotham; lb.TextXAlignment=Enum.TextXAlignment.Left; lb.Parent=row
    local bg=Instance.new("Frame"); bg.Size=UDim2.new(0,46,0,24); bg.Position=UDim2.new(1,-46,0.5,-12)
    bg.BorderSizePixel=0; bg.Parent=row
    do local c=Instance.new("UICorner",bg); c.CornerRadius=UDim.new(1,0) end
    local kn=Instance.new("Frame"); kn.Size=UDim2.new(0,18,0,18); kn.BorderSizePixel=0; kn.Parent=bg
    do local c=Instance.new("UICorner",kn); c.CornerRadius=UDim.new(1,0) end
    local function rf()
        local on=get()
        TweenService:Create(bg,TweenInfo.new(0.15),{BackgroundColor3=on and Color3.fromRGB(30,60,100) or Color3.fromRGB(40,40,55)}):Play()
        TweenService:Create(kn,TweenInfo.new(0.15),{
            Position=on and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9),
            BackgroundColor3=on and Color3.fromRGB(100,180,255) or Color3.fromRGB(140,140,160)
        }):Play()
    end; rf()
    bg.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then set(not get()); rf() end
    end)
end

local function mkSlider(parent, label, min, max, get, set)
    local row=Instance.new("Frame"); row.Size=UDim2.new(1,-6,0,50); row.BackgroundTransparency=1; row.Parent=parent
    local lb=Instance.new("TextLabel"); lb.Text=label.." : "..tostring(get()); lb.Size=UDim2.new(1,0,0,20)
    lb.BackgroundTransparency=1; lb.TextColor3=Color3.fromRGB(200,200,220); lb.TextSize=13
    lb.Font=Enum.Font.Gotham; lb.TextXAlignment=Enum.TextXAlignment.Left; lb.Parent=row
    local tr=Instance.new("Frame"); tr.Size=UDim2.new(1,0,0,6); tr.Position=UDim2.new(0,0,0,34)
    tr.BackgroundColor3=Color3.fromRGB(40,40,55); tr.BorderSizePixel=0; tr.Parent=row
    do local c=Instance.new("UICorner",tr); c.CornerRadius=UDim.new(1,0) end
    local p0=math.clamp((get()-min)/(max-min),0,1)
    local fi=Instance.new("Frame"); fi.Size=UDim2.new(p0,0,1,0); fi.BackgroundColor3=Color3.fromRGB(80,140,255); fi.BorderSizePixel=0; fi.Parent=tr
    do local c=Instance.new("UICorner",fi); c.CornerRadius=UDim.new(1,0) end
    local kn=Instance.new("Frame"); kn.Size=UDim2.new(0,14,0,14); kn.Position=UDim2.new(p0,-7,0.5,-7)
    kn.BackgroundColor3=Color3.fromRGB(255,255,255); kn.BorderSizePixel=0; kn.Parent=tr
    do local c=Instance.new("UICorner",kn); c.CornerRadius=UDim.new(1,0) end
    local drag=false
    local function ap(mx)
        local r=math.clamp((mx-tr.AbsolutePosition.X)/tr.AbsoluteSize.X,0,1)
        local v=math.floor(min+r*(max-min)); set(v)
        lb.Text=label.." : "..v; fi.Size=UDim2.new(r,0,1,0); kn.Position=UDim2.new(r,-7,0.5,-7)
    end
    kn.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true end end)
    tr.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true;ap(i.Position.X) end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
    UserInputService.InputChanged:Connect(function(i) if drag and i.UserInputType==Enum.UserInputType.MouseMovement then ap(i.Position.X) end end)
end

local function mkSection(parent, text)
    local r=Instance.new("Frame"); r.Size=UDim2.new(1,-6,0,26); r.BackgroundTransparency=1; r.Parent=parent
    local l=Instance.new("TextLabel"); l.Text=text; l.Size=UDim2.new(1,0,1,0)
    l.BackgroundTransparency=1; l.TextColor3=Color3.fromRGB(80,100,160); l.TextSize=11
    l.Font=Enum.Font.GothamBold; l.TextXAlignment=Enum.TextXAlignment.Left; l.Parent=r
    local ln=Instance.new("Frame",r); ln.Size=UDim2.new(1,0,0,1); ln.Position=UDim2.new(0,0,1,-1)
    ln.BackgroundColor3=Color3.fromRGB(40,60,120); ln.BorderSizePixel=0
end

local function mkLabel(parent, text)
    local l=Instance.new("TextLabel"); l.Text="  "..text; l.Size=UDim2.new(1,-6,0,22)
    l.BackgroundTransparency=1; l.TextColor3=Color3.fromRGB(120,130,160); l.TextSize=12
    l.Font=Enum.Font.Gotham; l.TextXAlignment=Enum.TextXAlignment.Left; l.Parent=parent
end

local function mkDropdown(parent, label, opts, get, set)
    local wr=Instance.new("Frame"); wr.Size=UDim2.new(1,-6,0,36); wr.BackgroundTransparency=1; wr.ClipsDescendants=false; wr.Parent=parent
    local lb=Instance.new("TextLabel"); lb.Text=label; lb.Size=UDim2.new(0.5,0,1,0)
    lb.BackgroundTransparency=1; lb.TextColor3=Color3.fromRGB(200,200,220); lb.TextSize=13; lb.Font=Enum.Font.Gotham; lb.TextXAlignment=Enum.TextXAlignment.Left; lb.Parent=wr
    local sb=Instance.new("TextButton"); sb.Text=get().." v"; sb.Size=UDim2.new(0.48,0,0,28); sb.Position=UDim2.new(0.52,0,0.5,-14)
    sb.BackgroundColor3=Color3.fromRGB(22,22,34); sb.TextColor3=Color3.fromRGB(200,200,220); sb.TextSize=12; sb.Font=Enum.Font.Gotham; sb.BorderSizePixel=0; sb.ZIndex=5; sb.Parent=wr
    do local c=Instance.new("UICorner",sb); c.CornerRadius=UDim.new(0,6) end
    do local s=Instance.new("UIStroke",sb); s.Color=Color3.fromRGB(80,120,255) end
    local mn=Instance.new("Frame"); mn.Size=UDim2.new(0.48,0,0,#opts*28); mn.Position=UDim2.new(0.52,0,1,2)
    mn.BackgroundColor3=Color3.fromRGB(22,22,34); mn.BorderSizePixel=0; mn.ZIndex=20; mn.Visible=false; mn.Parent=wr
    do local c=Instance.new("UICorner",mn); c.CornerRadius=UDim.new(0,6) end
    do local s=Instance.new("UIStroke",mn); s.Color=Color3.fromRGB(80,120,255) end
    Instance.new("UIListLayout",mn)
    for _,opt in ipairs(opts) do
        local ob=Instance.new("TextButton"); ob.Text=opt; ob.Size=UDim2.new(1,0,0,28)
        ob.BackgroundColor3=Color3.fromRGB(22,22,34); ob.TextColor3=Color3.fromRGB(200,200,220); ob.TextSize=12; ob.Font=Enum.Font.Gotham; ob.BorderSizePixel=0; ob.ZIndex=21; ob.Parent=mn
        ob.MouseEnter:Connect(function() TweenService:Create(ob,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(30,40,70)}):Play() end)
        ob.MouseLeave:Connect(function() TweenService:Create(ob,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(22,22,34)}):Play() end)
        ob.MouseButton1Click:Connect(function() set(opt); sb.Text=opt.." v"; mn.Visible=false end)
    end
    sb.MouseButton1Click:Connect(function() mn.Visible=not mn.Visible end)
end

local function buildUpdate(p)
    mkSection(p,"v1.0.0 — 2025-01-01")
    for _,t in ipairs({"Menu principal avec sidebar","Mouvement : Speed Fly NoClip InfJump Gravity","Silent Aim + FOV + trigger + cible","ESP : vie HP distance tracer tracers liste joueurs","Budda + anti-ragdoll + Blox Fruits fast attack range","Settings : CTRL DROIT auto-rejoin"}) do mkLabel(p,t) end
end

local function buildMouvement(p)
    mkSection(p,"Vitesse")
    mkToggle(p,"Speed Hack",function() return F.speedHack end,function(v) F.speedHack=v end)
    mkSlider(p,"WalkSpeed",16,500,function() return F.walkSpeed end,function(v) F.walkSpeed=v end)
    mkSection(p,"Vol")
    mkToggle(p,"Fly",function() return F.fly end,function(v) F.fly=v end)
    mkSlider(p,"Fly Speed",10,300,function() return F.flySpeed end,function(v) F.flySpeed=v end)
    mkSection(p,"Saut et Gravite")
    mkToggle(p,"Inf Jump",function() return F.infJump end,function(v) F.infJump=v end)
    mkSlider(p,"Jump Power",7,300,function() return F.jumpPower end,function(v) F.jumpPower=v end)
    mkToggle(p,"Gravity reduite",function() return F.lowGravity end,function(v) F.lowGravity=v end)
    mkSlider(p,"Gravity",5,196,function() return F.gravityVal end,function(v) F.gravityVal=v end)
    mkSection(p,"Autre")
    mkToggle(p,"No Clip",function() return F.noclip end,function(v) F.noclip=v end)
end

local function buildSilentAim(p)
    mkToggle(p,"Silent Aim",function() return F.silentAim end,function(v) F.silentAim=v end)
    mkSlider(p,"FOV Radius",10,600,function() return F.aimFov end,function(v) F.aimFov=v end)
    mkToggle(p,"Show FOV",function() return F.showFov end,function(v) F.showFov=v end)
    mkToggle(p,"Trigger Bot",function() return F.triggerBot end,function(v) F.triggerBot=v end)
    mkToggle(p,"Head Only",function() return F.headOnly end,function(v) F.headOnly=v end)
    mkDropdown(p,"Mode visee",{"Camera","Souris"},function() return F.aimMode end,function(v) F.aimMode=v end)
    mkSection(p,"Cible actuelle")
    local box=Instance.new("Frame"); box.Size=UDim2.new(1,-6,0,44); box.BackgroundColor3=Color3.fromRGB(22,22,34); box.BorderSizePixel=0; box.Parent=p
    do local c=Instance.new("UICorner",box); c.CornerRadius=UDim.new(0,6) end
    do local s=Instance.new("UIStroke",box); s.Color=Color3.fromRGB(80,100,160) end
    local dot=Instance.new("Frame"); dot.Size=UDim2.new(0,10,0,10); dot.Position=UDim2.new(0,12,0.5,-5); dot.BackgroundColor3=Color3.fromRGB(100,100,120); dot.BorderSizePixel=0; dot.Parent=box
    do local c=Instance.new("UICorner",dot); c.CornerRadius=UDim.new(1,0) end
    local tl=Instance.new("TextLabel"); tl.Text="Aucune cible"; tl.Size=UDim2.new(1,-36,1,0); tl.Position=UDim2.new(0,32,0,0)
    tl.BackgroundTransparency=1; tl.TextColor3=Color3.fromRGB(120,130,160); tl.TextSize=13; tl.Font=Enum.Font.Gotham; tl.TextXAlignment=Enum.TextXAlignment.Left; tl.Parent=box
    RunService.Heartbeat:Connect(function()
        local t=currentTarget
        if t and t.Character then
            local h=t.Character:FindFirstChildOfClass("Humanoid")
            tl.Text=t.Name.."  |  "..(h and math.floor(h.Health) or "?").." HP"
            tl.TextColor3=Color3.fromRGB(80,220,110); dot.BackgroundColor3=Color3.fromRGB(50,220,80)
        else tl.Text="Aucune cible"; tl.TextColor3=Color3.fromRGB(120,130,160); dot.BackgroundColor3=Color3.fromRGB(100,100,120) end
    end)
end

local function buildESPPanel(p)
    mkToggle(p,"Activer ESP",function() return F.espEnabled end,function(v) F.espEnabled=v end)
    mkToggle(p,"Barre de vie",function() return F.espHealth end,function(v) F.espHealth=v end)
    mkToggle(p,"Nombre HP",function() return F.espHpNum end,function(v) F.espHpNum=v end)
    mkToggle(p,"Distance",function() return F.espDist end,function(v) F.espDist=v end)
    mkToggle(p,"Tracer",function() return F.espTracer end,function(v) F.espTracer=v end)
    mkToggle(p,"Nom joueur",function() return F.espName end,function(v) F.espName=v end)
    mkSection(p,"Liste joueurs  clic gauche=vert  clic droit=rouge")
    local lf=Instance.new("Frame"); lf.Size=UDim2.new(1,-6,0,0); lf.AutomaticSize=Enum.AutomaticSize.Y; lf.BackgroundTransparency=1; lf.Parent=p
    do local l=Instance.new("UIListLayout",lf); l.Padding=UDim.new(0,3) end
    local function rb()
        for _,c in ipairs(lf:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        for _,tgt in ipairs(Players:GetPlayers()) do
            if tgt==plr then continue end
            local cs=espColors[tgt.UserId] or "default"
            local bgC=cs=="green" and Color3.fromRGB(20,55,28) or cs=="red" and Color3.fromRGB(55,20,20) or Color3.fromRGB(22,22,34)
            local dtC=cs=="green" and Color3.fromRGB(50,220,80) or cs=="red" and Color3.fromRGB(220,50,50) or Color3.fromRGB(100,100,130)
            local rw=Instance.new("TextButton"); rw.Text=""; rw.Size=UDim2.new(1,0,0,30); rw.BackgroundColor3=bgC; rw.BorderSizePixel=0; rw.Parent=lf
            do local c=Instance.new("UICorner",rw); c.CornerRadius=UDim.new(0,5) end
            local d=Instance.new("Frame"); d.Size=UDim2.new(0,8,0,8); d.Position=UDim2.new(0,10,0.5,-4); d.BackgroundColor3=dtC; d.BorderSizePixel=0; d.Parent=rw
            do local c=Instance.new("UICorner",d); c.CornerRadius=UDim.new(1,0) end
            local nl=Instance.new("TextLabel"); nl.Text=tgt.Name; nl.Size=UDim2.new(1,-28,1,0); nl.Position=UDim2.new(0,26,0,0)
            nl.BackgroundTransparency=1; nl.TextColor3=Color3.fromRGB(200,200,220); nl.TextSize=12; nl.Font=Enum.Font.Gotham; nl.TextXAlignment=Enum.TextXAlignment.Left; nl.Parent=rw
            rw.MouseButton1Click:Connect(function() espColors[tgt.UserId]=espColors[tgt.UserId]=="green" and "default" or "green"; rb() end)
            rw.MouseButton2Click:Connect(function() espColors[tgt.UserId]=espColors[tgt.UserId]=="red" and "default" or "red"; rb() end)
        end
    end
    rb(); Players.PlayerAdded:Connect(rb); Players.PlayerRemoving:Connect(function() task.wait(0.1);rb() end)
end

local function buildBudda(p)
    mkToggle(p,"Buddha Mode",function() return F.buddha end,function(v) F.buddha=v end)
    mkLabel(p,"HP bloque a 1 anti-mort")
    mkToggle(p,"Anti-Ragdoll",function() return F.antiRagdoll end,function(v) F.antiRagdoll=v end)
    mkSection(p,"Blox Fruits Combat")
    mkToggle(p,"Fast Attack",function() return F.fastAttack end,function(v) F.fastAttack=v end)
    mkSlider(p,"Delai attaque ms",50,500,function() return F.attackDelay end,function(v) F.attackDelay=v end)
    mkToggle(p,"Extend Range",function() return F.extendRange end,function(v) F.extendRange=v end)
    mkSlider(p,"Range Multiplier",1,20,function() return F.rangeMulti end,function(v) F.rangeMulti=v end)
end

local function buildSettings(p)
    mkLabel(p,"Touche menu : CTRL DROIT")
    mkToggle(p,"Auto-inject serv hop",function() return F.autoRejoin end,function(v) F.autoRejoin=v end)
    mkToggle(p,"Notifications",function() return F.notifs end,function(v) F.notifs=v end)
    mkSection(p,"A propos")
    mkLabel(p,"NexusHub v1.0.0")
    mkLabel(p,"Executeur : Xeno")
    local cb=Instance.new("TextButton"); cb.Text="Copier lien GitHub"; cb.Size=UDim2.new(1,-6,0,34)
    cb.BackgroundColor3=Color3.fromRGB(30,55,110); cb.TextColor3=Color3.fromRGB(150,200,255); cb.TextSize=13; cb.Font=Enum.Font.GothamBold; cb.BorderSizePixel=0; cb.Parent=p
    do local c=Instance.new("UICorner",cb); c.CornerRadius=UDim.new(0,6) end
    do local s=Instance.new("UIStroke",cb); s.Color=Color3.fromRGB(60,100,200) end
    cb.MouseButton1Click:Connect(function()
        setclipboard(GITHUB_URL); cb.Text="Copie !"; task.delay(2,function() cb.Text="Copier lien GitHub" end)
    end)
end

local CATS = {
    {name="Update",     icon="[U]", color=Color3.fromRGB(80,200,120),  build=buildUpdate},
    {name="Mouvement",  icon="[M]", color=Color3.fromRGB(100,150,255), build=buildMouvement},
    {name="Silent Aim", icon="[S]", color=Color3.fromRGB(255,80,80),   build=buildSilentAim},
    {name="ESP",        icon="[E]", color=Color3.fromRGB(255,180,50),  build=buildESPPanel},
    {name="Budda",      icon="[B]", color=Color3.fromRGB(200,100,255), build=buildBudda},
    {name="Settings",   icon="[X]", color=Color3.fromRGB(160,160,160), build=buildSettings},
}

local function selectCat(cat, btn, acc)
    for _,c in ipairs(SB:GetChildren()) do
        if c:IsA("TextButton") then
            TweenService:Create(c,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(20,20,32),TextColor3=Color3.fromRGB(120,130,160)}):Play()
            local a=c:FindFirstChildOfClass("Frame"); if a then TweenService:Create(a,TweenInfo.new(0.15),{BackgroundTransparency=1}):Play() end
        end
    end
    TweenService:Create(btn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(18,28,55),TextColor3=cat.color}):Play()
    TweenService:Create(acc,TweenInfo.new(0.15),{BackgroundTransparency=0}):Play()
    openPanel(cat.build)
end

for i,cat in ipairs(CATS) do
    local btn=Instance.new("TextButton")
    btn.Text=cat.icon.."  "..cat.name
    btn.Size=UDim2.new(1,0,0,38)
    btn.BackgroundColor3=Color3.fromRGB(20,20,32)
    btn.TextColor3=Color3.fromRGB(120,130,160)
    btn.TextSize=13; btn.Font=Enum.Font.Gotham
    btn.TextXAlignment=Enum.TextXAlignment.Left
    btn.BorderSizePixel=0; btn.LayoutOrder=i
    btn.Parent=SB
    do local c=Instance.new("UICorner",btn); c.CornerRadius=UDim.new(0,6) end
    local acc=Instance.new("Frame")
    acc.Size=UDim2.new(0,3,0.55,0); acc.Position=UDim2.new(0,0,0.225,0)
    acc.BackgroundColor3=cat.color; acc.BackgroundTransparency=1; acc.BorderSizePixel=0; acc.Parent=btn
    do local c=Instance.new("UICorner",acc); c.CornerRadius=UDim.new(1,0) end
    do local lp=Instance.new("UIPadding",btn); lp.PaddingLeft=UDim.new(0,12) end
    local catRef,btnRef,accRef=cat,btn,acc
    btn.MouseButton1Click:Connect(function() selectCat(catRef,btnRef,accRef) end)
    if i==1 then task.defer(function() selectCat(catRef,btnRef,accRef) end) end
end

local drag,ds,sp=false,nil,nil
TB.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true;ds=i.Position;sp=Win.Position end end)
TB.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
UserInputService.InputChanged:Connect(function(i)
    if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
        local d=i.Position-ds; Win.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
    end
end)
UserInputService.InputBegan:Connect(function(i,gpe)
    if gpe then return end
    if i.KeyCode==Enum.KeyCode.RightControl then Win.Visible=not Win.Visible end
end)

local flyBV,flyConn
local function stopFly() if flyConn then flyConn:Disconnect();flyConn=nil end; if flyBV then flyBV:Destroy();flyBV=nil end end
local function startFly()
    if flyBV then return end; local root=getRoot(); if not root then return end
    flyBV=Instance.new("BodyVelocity"); flyBV.MaxForce=Vector3.new(1e5,1e5,1e5); flyBV.Velocity=Vector3.zero; flyBV.Parent=root
    flyConn=RunService.Heartbeat:Connect(function()
        if not F.fly or not MASTER then stopFly();return end
        local sp2=F.flySpeed; local cf=cam.CFrame; local dir=Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir+=cf.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir-=cf.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir-=cf.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir+=cf.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir+=Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir-=Vector3.new(0,1,0) end
        flyBV.Velocity=dir.Magnitude>0 and dir.Unit*sp2 or Vector3.zero
    end)
end

local ncConn
local function stopNC()
    if ncConn then ncConn:Disconnect();ncConn=nil end
    local c=getChar(); if c then for _,pt in ipairs(c:GetDescendants()) do if pt:IsA("BasePart") then pt.CanCollide=true end end end
end
local function startNC()
    if ncConn then return end
    ncConn=RunService.Stepped:Connect(function()
        if not F.noclip or not MASTER then stopNC();return end
        local c=getChar(); if not c then return end
        for _,pt in ipairs(c:GetDescendants()) do if pt:IsA("BasePart") then pt.CanCollide=false end end
    end)
end

local fovC=Drawing.new("Circle"); fovC.Visible=false; fovC.Thickness=1.5; fovC.Color=Color3.fromRGB(255,80,80); fovC.Filled=false; fovC.NumSides=64
local function getOrigin() if F.aimMode=="Souris" then local mp=UserInputService:GetMouseLocation(); return Vector2.new(mp.X,mp.Y) end; return cam.ViewportSize/2 end
local function getBest()
    local org=getOrigin(); local best,bd=nil,F.aimFov
    for _,p in ipairs(Players:GetPlayers()) do
        if p==plr then continue end; local c=p.Character; if not c then continue end
        local pt=F.headOnly and c:FindFirstChild("Head") or c:FindFirstChild("HumanoidRootPart"); if not pt then continue end
        local h=c:FindFirstChildOfClass("Humanoid"); if not h or h.Health<=0 then continue end
        local sv,os=cam:WorldToViewportPoint(pt.Position); if not os then continue end
        local d=(Vector2.new(sv.X,sv.Y)-org).Magnitude; if d<bd then bd=d;best=p end
    end; return best
end

local espO={}
local function clearESP()
    for _,v in pairs(espO) do
        if typeof(v)=="Instance" and v.Parent then v:Destroy()
        elseif typeof(v)=="RBXScriptConnection" then v:Disconnect()
        else pcall(function() v:Remove() end) end
    end; espO={}
end
local function buildESPPlayer(tgt)
    if tgt==plr then return end; local ch=tgt.Character; if not ch then return end
    local rt=ch:FindFirstChild("HumanoidRootPart"); if not rt then return end
    local hm=ch:FindFirstChildOfClass("Humanoid")
    local bb=Instance.new("BillboardGui"); bb.Name="NHUB_"..tgt.Name; bb.Size=UDim2.new(0,140,0,65); bb.StudsOffset=Vector3.new(0,3.5,0); bb.AlwaysOnTop=true; bb.Parent=rt
    local nl=Instance.new("TextLabel"); nl.Size=UDim2.new(1,0,0,17); nl.BackgroundTransparency=1; nl.TextColor3=Color3.fromRGB(255,255,255); nl.TextStrokeTransparency=0.3; nl.TextSize=13; nl.Font=Enum.Font.GothamBold; nl.Text=tgt.Name; nl.Parent=bb
    local bg2=Instance.new("Frame"); bg2.Size=UDim2.new(1,0,0,6); bg2.Position=UDim2.new(0,0,0,20); bg2.BackgroundColor3=Color3.fromRGB(40,10,10); bg2.BorderSizePixel=0; bg2.Parent=bb
    do local c=Instance.new("UICorner",bg2); c.CornerRadius=UDim.new(1,0) end
    local bf=Instance.new("Frame"); bf.Size=UDim2.new(1,0,1,0); bf.BackgroundColor3=Color3.fromRGB(50,220,80); bf.BorderSizePixel=0; bf.Parent=bg2
    do local c=Instance.new("UICorner",bf); c.CornerRadius=UDim.new(1,0) end
    local hl=Instance.new("TextLabel"); hl.Size=UDim2.new(1,0,0,14); hl.Position=UDim2.new(0,0,0,29); hl.BackgroundTransparency=1; hl.TextColor3=Color3.fromRGB(210,210,210); hl.TextStrokeTransparency=0.4; hl.TextSize=11; hl.Font=Enum.Font.Gotham; hl.Parent=bb
    local dl=Instance.new("TextLabel"); dl.Size=UDim2.new(1,0,0,14); dl.Position=UDim2.new(0,0,0,45); dl.BackgroundTransparency=1; dl.TextColor3=Color3.fromRGB(160,160,255); dl.TextStrokeTransparency=0.4; dl.TextSize=10; dl.Font=Enum.Font.Gotham; dl.Parent=bb
    local ln=Drawing.new("Line"); ln.Visible=false; ln.Color=Color3.fromRGB(255,180,50); ln.Thickness=1
    local cn=RunService.Heartbeat:Connect(function()
        local on=MASTER and F.espEnabled; bb.Enabled=on; ln.Visible=false
        if not on or not(hm and hm.Parent and rt and rt.Parent) then return end
        nl.Visible=F.espName; bg2.Visible=F.espHealth; hl.Visible=F.espHpNum; dl.Visible=F.espDist
        local pct=math.clamp(hm.Health/math.max(hm.MaxHealth,1),0,1)
        bf.Size=UDim2.new(pct,0,1,0)
        bf.BackgroundColor3=Color3.fromRGB(math.clamp(math.floor((1-pct)*220+30),0,255),math.clamp(math.floor(pct*200+20),0,255),30)
        hl.Text=math.floor(hm.Health).." / "..math.floor(hm.MaxHealth).." HP"
        local mr=getRoot(); if mr then dl.Text=math.floor((mr.Position-rt.Position).Magnitude).." studs" end
        if F.espTracer then
            local sv2,os=cam:WorldToViewportPoint(rt.Position)
            if os then ln.Visible=true; ln.From=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y); ln.To=Vector2.new(sv2.X,sv2.Y) end
        end
    end)
    table.insert(espO,bb); table.insert(espO,ln); table.insert(espO,cn)
end
local function refreshESP() clearESP(); for _,p in ipairs(Players:GetPlayers()) do buildESPPlayer(p) end end

local function resetAll()
    local h=getHum()
    if h then h.WalkSpeed=ORIG.ws; h.JumpPower=ORIG.jp; h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true); h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true) end
    workspace.Gravity=ORIG.grav; stopFly(); stopNC(); currentTarget=nil; fovC.Visible=false; clearESP()
end

table.insert(masterCBs,function(on) if not on then resetAll() end end)

RunService.Heartbeat:Connect(function()
    if not MASTER then return end
    local h=getHum()
    if h then
        h.WalkSpeed=F.speedHack and F.walkSpeed or ORIG.ws
        h.JumpPower=F.infJump and F.jumpPower or ORIG.jp
        if F.buddha and h.Health<1 then h.Health=1 end
        h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,not F.antiRagdoll)
        h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,not F.antiRagdoll)
    end
    workspace.Gravity=F.lowGravity and F.gravityVal or ORIG.grav
    if F.fly and not flyBV then startFly() elseif not F.fly and flyBV then stopFly() end
    if F.noclip and not ncConn then startNC() elseif not F.noclip and ncConn then stopNC() end
    fovC.Visible=F.silentAim and F.showFov
    if fovC.Visible then fovC.Position=getOrigin(); fovC.Radius=F.aimFov end
    if F.silentAim then currentTarget=getBest() else currentTarget=nil; fovC.Visible=false end
end)

UserInputService.JumpRequest:Connect(function()
    if not MASTER or not F.infJump then return end
    local h=getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
end)
RunService.Heartbeat:Connect(function()
    if not MASTER or not F.fastAttack then return end
    local c=getChar(); if not c then return end
    local h=c:FindFirstChildOfClass("Humanoid"); if not h then return end
    local a=h:FindFirstChildOfClass("Animator"); if not a then return end
    local spd=1000/math.max(F.attackDelay,1)
    for _,t in ipairs(a:GetPlayingAnimationTracks()) do if t.Speed<spd then t:AdjustSpeed(spd) end end
end)
RunService.Heartbeat:Connect(function()
    if not MASTER or not F.extendRange then return end
    local c=getChar(); if not c then return end
    for _,d in ipairs(c:GetDescendants()) do
        if d:IsA("BasePart") and d.Name:lower():find("hitbox") then d.Size=d.Size*F.rangeMulti end
    end
end)

task.spawn(function() while true do task.wait(4); if MASTER and F.espEnabled then refreshESP() end end end)
task.spawn(function()
    local T2=game:GetService("TeleportService")
    T2.LocalPlayerArrivedFromTeleport:Connect(function()
        if F.autoRejoin then task.wait(2); loadstring(game:HttpGet(GITHUB_URL))() end
    end)
end)

if plr.Character then captureOrig() end
plr.CharacterAdded:Connect(function(c)
    c:WaitForChild("Humanoid"); task.wait(0.5)
    flyBV=nil;flyConn=nil;ncConn=nil; captureOrig(); clearESP(); task.delay(2,refreshESP)
end)
task.delay(2,refreshESP)

print("[NexusHub] Charge ! CTRL DROIT = ouvrir/fermer | Toggle = ON/OFF")
