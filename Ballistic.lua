--[[
    ═══════════════════════════════════════════════════════════════
      BALLISTIC v1.3 — BedWars Hub (private server)
      Single-file script. Paste into Delta and execute.
      Toggle menu: Right Shift  (or F1 if blocked)
    ═══════════════════════════════════════════════════════════════
]]

--// Services
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Lighting         = game:GetService("Lighting")
local Workspace        = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera      = Workspace.CurrentCamera

--// Cleanup previous
pcall(function()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if pg then
        local old = pg:FindFirstChild("BallisticGui")
        if old then old:Destroy() end
    end
end)

--// State
local Config = {
    TurboBuild=false, TurboBuildSpeed=2.0,
    SpeedWalk=false, WalkSpeed=23,
    AutoPlay=false, NoFall=false, Velocity=false, Reach=3.0,
    CustomCape=true, CustomSword=false, CustomMapMesh=false,
    FPSBooster=false, ChestESP=false, BetterNametags=true,
    ESP=false, Tracers=false, HealthBars=false, BoxESP=false,
}

local Theme = {
    Bg1=Color3.fromRGB(8,4,18), Bg2=Color3.fromRGB(28,8,48),
    Border=Color3.fromRGB(138,43,226), BorderGlow=Color3.fromRGB(178,102,255),
    Accent=Color3.fromRGB(106,13,173), AccentLit=Color3.fromRGB(178,102,255),
    Text=Color3.fromRGB(238,221,255), TextDim=Color3.fromRGB(160,140,200),
    TabActive=Color3.fromRGB(106,13,173), TabIdle=Color3.fromRGB(26,10,42),
    TabHover=Color3.fromRGB(58,26,90),
}

local Font, FontBody, FontMono = Enum.Font.GothamBold, Enum.Font.Gotham, Enum.Font.Code

--// Helpers
local function new(class, props, children)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do obj[k] = v end
    for _, c in ipairs(children or {}) do c.Parent = obj end
    return obj
end
local function corner(r, p) return new("UICorner", {CornerRadius=UDim.new(0,r)}, {p}) end
local function stroke(c, t, p) return new("UIStroke", {Color=c, Thickness=t or 1, ApplyStrokeMode=Enum.ApplyStrokeMode.Border}, {p}) end
local function gradient(c1, c2, rot, p) return new("UIGradient", {Color=ColorSequence.new(c1, c2), Rotation=rot or 90}, {p}) end

--// GUI
local ScreenGui = new("ScreenGui", {
    Name="BallisticGui", ResetOnSpawn=false, IgnoreGuiInset=true, DisplayOrder=999,
}, {LocalPlayer:WaitForChild("PlayerGui")})

local WinW, WinH = 560, 380

local Main = new("Frame", {
    Size=UDim2.fromOffset(WinW, WinH),
    Position=UDim2.new(0.5, -WinW/2, 0.5, -WinH/2),
    BackgroundColor3=Theme.Bg1, BorderSizePixel=0, Active=true,
}, {ScreenGui})
corner(10, Main)

local BgGradient = gradient(Theme.Bg1, Theme.Bg2, 90, Main)

local GlowHolder = new("Frame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, ClipsDescendants=true}, {Main})
corner(10, GlowHolder)
local GlowBlobs = {}
for i = 1, 4 do
    local b = new("Frame", {
        Size=UDim2.fromOffset(220,220), BackgroundColor3=Theme.AccentLit,
        BackgroundTransparency=0.88, BorderSizePixel=0, Position=UDim2.fromScale(0.5,0.5),
    }, {GlowHolder})
    corner(999, b)
    GlowBlobs[i] = {frame=b, phase=i*(math.pi/2)}
end

local BorderFrame = new("Frame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, ZIndex=2}, {Main})
stroke(Theme.Border, 1.5, BorderFrame)
corner(10, BorderFrame)
local glowStroke = stroke(Theme.BorderGlow, 1, BorderFrame)
glowStroke.Transparency = 0.5

local TitleBar = new("Frame", {
    Size=UDim2.new(1,0,0,42), BackgroundColor3=Color3.fromRGB(14,6,26),
    BackgroundTransparency=0.15, BorderSizePixel=0, ZIndex=3,
}, {Main})
corner(10, TitleBar)

local TitleLabel = new("TextLabel", {
    Size=UDim2.new(0,200,1,0), Position=UDim2.new(0,16,0,0),
    BackgroundTransparency=1, Font=Font, Text="BALLISTIC",
    TextSize=22, TextColor3=Theme.BorderGlow,
    TextXAlignment=Enum.TextXAlignment.Left, ZIndex=4,
}, {TitleBar})
gradient(Theme.BorderGlow, Color3.fromRGB(220,180,255), 0, TitleLabel)

new("TextLabel", {
    Size=UDim2.new(0,60,1,0), Position=UDim2.new(1,-80,0,0),
    BackgroundTransparency=1, Font=FontMono, Text="v1.3",
    TextSize=12, TextColor3=Theme.TextDim,
    TextXAlignment=Enum.TextXAlignment.Right, ZIndex=4,
}, {TitleBar})

local CloseBtn = new("TextButton", {
    Size=UDim2.fromOffset(28,28), Position=UDim2.new(1,-36,0.5,-14),
    BackgroundColor3=Color3.fromRGB(60,20,40), BorderSizePixel=0,
    Font=Font, Text="X", TextSize=14, TextColor3=Color3.fromRGB(255,180,200),
    AutoButtonColor=false, ZIndex=5,
}, {TitleBar})
corner(6, CloseBtn)

local Reopen = new("TextButton", {
    Size=UDim2.fromOffset(50,50), Position=UDim2.new(0,16,0.5,-25),
    BackgroundColor3=Theme.Accent, BorderSizePixel=0,
    Font=Font, Text="B", TextSize=24, TextColor3=Theme.BorderGlow,
    Visible=false, AutoButtonColor=false,
}, {ScreenGui})
corner(10, Reopen)
stroke(Theme.BorderGlow, 1.5, Reopen)

CloseBtn.MouseButton1Click:Connect(function() Main.Visible=false; Reopen.Visible=true end)
Reopen.MouseButton1Click:Connect(function() Main.Visible=true; Reopen.Visible=false end)

--// Drag
do
    local dragging, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging=true; dragStart=input.Position; startPos=Main.Position
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then dragging=false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
end

--// Tabs
local Tabs = {"Main", "Misc", "Render"}
local TabButtons, Pages = {}, {}
local ActiveTab = "Main"

local TabBar = new("Frame", {
    Size=UDim2.new(1,-32,0,32), Position=UDim2.new(0,16,0,48),
    BackgroundTransparency=1, ZIndex=3,
}, {Main})
new("UIListLayout", {
    FillDirection=Enum.FillDirection.Horizontal,
    Padding=UDim.new(0,6), SortOrder=Enum.SortOrder.LayoutOrder,
}, {TabBar})

local Content = new("Frame", {
    Size=UDim2.new(1,-32,1,-96), Position=UDim2.new(0,16,0,88),
    BackgroundTransparency=1, ZIndex=3, ClipsDescendants=true,
}, {Main})

for _, name in ipairs(Tabs) do
    local page = new("ScrollingFrame", {
        Name=name.."Page", Size=UDim2.fromScale(1,1),
        BackgroundTransparency=1, BorderSizePixel=0,
        ScrollBarThickness=3, ScrollBarImageColor3=Theme.Accent,
        CanvasSize=UDim2.new(0,0,0,0), Visible=false, ZIndex=3,
        ScrollingDirection=Enum.ScrollingDirection.Y,
    }, {Content})
    new("UIListLayout", {Padding=UDim.new(0,8), SortOrder=Enum.SortOrder.LayoutOrder}, {page})
    new("UIPadding", {PaddingRight=UDim.new(0,8), PaddingBottom=UDim.new(0,12)}, {page})
    Pages[name] = page
end

local function switchTab(name)
    ActiveTab = name
    for n, p in pairs(Pages) do p.Visible = (n == name) end
    for n, btn in pairs(TabButtons) do
        local active = (n == name)
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = active and Theme.TabActive or Theme.TabIdle
        }):Play()
        btn.TextColor3 = active and Theme.BorderGlow or Theme.TextDim
    end
end

for _, name in ipairs(Tabs) do
    local btn = new("TextButton", {
        Size=UDim2.fromOffset(90,30), BackgroundColor3=Theme.TabIdle,
        BorderSizePixel=0, Font=Font, Text=name, TextSize=13,
        TextColor3=Theme.TextDim, AutoButtonColor=false, ZIndex=4,
    }, {TabBar})
    corner(6, btn)
    TabButtons[name] = btn
    btn.MouseEnter:Connect(function()
        if ActiveTab ~= name then
            TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3=Theme.TabHover}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if ActiveTab ~= name then
            TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3=Theme.TabIdle}):Play()
        end
    end)
    btn.MouseButton1Click:Connect(function() switchTab(name) end)
end

--// Components
local function Section(page, text)
    local f = new("Frame", {Size=UDim2.new(1,0,0,20), BackgroundTransparency=1}, {page})
    new("TextLabel", {
        Size=UDim2.fromScale(1,1), BackgroundTransparency=1,
        Font=Font, Text=text, TextSize=11, TextColor3=Theme.AccentLit,
        TextXAlignment=Enum.TextXAlignment.Left,
    }, {f})
    new("Frame", {
        Size=UDim2.new(1,-60,0,1), Position=UDim2.new(0,65,0.5,0),
        BackgroundColor3=Theme.Accent, BorderSizePixel=0,
    }, {f})
end

local function Toggle(page, text, key)
    local row = new("Frame", {
        Size=UDim2.new(1,0,0,28),
        BackgroundColor3=Color3.fromRGB(18,8,32),
        BackgroundTransparency=0.3, BorderSizePixel=0,
    }, {page})
    corner(6, row)
    new("TextLabel", {
        Size=UDim2.new(1,-60,1,0), Position=UDim2.fromOffset(10,0),
        BackgroundTransparency=1, Font=FontBody, Text=text, TextSize=13,
        TextColor3=Theme.Text, TextXAlignment=Enum.TextXAlignment.Left,
    }, {row})
    local track = new("Frame", {
        Size=UDim2.fromOffset(38,18), Position=UDim2.new(1,-48,0.5,-9),
        BackgroundColor3=Color3.fromRGB(42,42,58), BorderSizePixel=0,
    }, {row})
    corner(999, track)
    local knob = new("Frame", {
        Size=UDim2.fromOffset(14,14), Position=UDim2.fromOffset(2,2),
        BackgroundColor3=Color3.fromRGB(240,240,240), BorderSizePixel=0,
    }, {track})
    corner(999, knob)
    local function update(v)
        Config[key] = v
        TweenService:Create(track, TweenInfo.new(0.15), {
            BackgroundColor3 = v and Theme.Accent or Color3.fromRGB(42,42,58)
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.15), {
            Position = v and UDim2.new(1,-16,0,2) or UDim2.fromOffset(2,2)
        }):Play()
    end
    update(Config[key])
    local btn = new("TextButton", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, Text=""}, {row})
    btn.MouseButton1Click:Connect(function() update(not Config[key]) end)
end

local function Slider(page, text, key, min, max, step)
    step = step or 0.1
    local row = new("Frame", {
        Size=UDim2.new(1,0,0,42),
        BackgroundColor3=Color3.fromRGB(18,8,32),
        BackgroundTransparency=0.3, BorderSizePixel=0,
    }, {page})
    corner(6, row)
    new("TextLabel", {
        Size=UDim2.new(1,-80,0,20), Position=UDim2.fromOffset(10,3),
        BackgroundTransparency=1, Font=FontBody, Text=text, TextSize=12,
        TextColor3=Theme.Text, TextXAlignment=Enum.TextXAlignment.Left,
    }, {row})
    local valLabel = new("TextLabel", {
        Size=UDim2.fromOffset(70,20), Position=UDim2.new(1,-80,0,3),
        BackgroundTransparency=1, Font=FontMono,
        Text=string.format("%.2f", Config[key]), TextSize=12,
        TextColor3=Theme.BorderGlow, TextXAlignment=Enum.TextXAlignment.Right,
    }, {row})
    local bar = new("Frame", {
        Size=UDim2.new(1,-20,0,6), Position=UDim2.new(0,10,0,26),
        BackgroundColor3=Color3.fromRGB(30,14,48), BorderSizePixel=0,
    }, {row})
    corner(999, bar)
    local fill = new("Frame", {
        Size=UDim2.new((Config[key]-min)/(max-min),0,1,0),
        BackgroundColor3=Theme.Accent, BorderSizePixel=0,
    }, {bar})
    corner(999, fill)
    gradient(Theme.Accent, Theme.BorderGlow, 0, fill)
    local knob = new("Frame", {
        Size=UDim2.fromOffset(12,12),
        Position=UDim2.new((Config[key]-min)/(max-min),-6,0.5,-6),
        BackgroundColor3=Theme.BorderGlow, BorderSizePixel=0,
    }, {bar})
    corner(999, knob)
    local dragging = false
    local function setFromX(x)
        local rel = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local raw = min + rel * (max - min)
        local stepped = math.clamp(math.floor(raw/step + 0.5) * step, min, max)
        Config[key] = stepped
        valLabel.Text = string.format("%.2f", stepped)
        TweenService:Create(fill, TweenInfo.new(0.05), {Size=UDim2.new(rel,0,1,0)}):Play()
        TweenService:Create(knob, TweenInfo.new(0.05), {Position=UDim2.new(rel,-6,0.5,-6)}):Play()
    end
    local hit = new("TextButton", {
        Size=UDim2.new(1,0,0,14), Position=UDim2.new(0,0,0.5,-7),
        BackgroundTransparency=1, Text="",
    }, {bar})
    hit.MouseButton1Down:Connect(function()
        dragging = true
        setFromX(UserInputService:GetMouseLocation().X)
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            setFromX(UserInputService:GetMouseLocation().X)
        end
    end)
end

local function Button(page, text, callback)
    local btn = new("TextButton", {
        Size=UDim2.new(1,0,0,30), BackgroundColor3=Theme.Accent,
        BorderSizePixel=0, Font=Font, Text=text, TextSize=13,
        TextColor3=Theme.BorderGlow, AutoButtonColor=false,
    }, {page})
    corner(6, btn)
    btn.MouseButton1Click:Connect(callback)
end

--// Main tab
local MainPage = Pages["Main"]
Section(MainPage, "MOVEMENT")
Toggle(MainPage, "Turbo Build", "TurboBuild")
Slider(MainPage, "Turbo Build Speed", "TurboBuildSpeed", 0.5, 5.0, 0.1)
Toggle(MainPage, "Speed Walk (23)", "SpeedWalk")
Slider(MainPage, "Walk Speed", "WalkSpeed", 8, 60, 1)
Toggle(MainPage, "NoFall", "NoFall")
Toggle(MainPage, "Velocity (Anti-KB)", "Velocity")

Section(MainPage, "COMBAT")
Slider(MainPage, "Reach", "Reach", 3.0, 15.0, 0.5)
Toggle(MainPage, "AutoPlay", "AutoPlay")

Section(MainPage, "ACTIONS")
Button(MainPage, "Respawn", function()
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = 0 end
    end
end)

--// Misc tab
local MiscPage = Pages["Misc"]
Section(MiscPage, "COSMETICS")
Toggle(MiscPage, "Custom Cape (Ballistic)", "CustomCape")
Toggle(MiscPage, "Custom Sword Meshes", "CustomSword")
Toggle(MiscPage, "Custom Map Meshes", "CustomMapMesh")

Section(MiscPage, "PERFORMANCE")
Toggle(MiscPage, "FPS Booster Mode", "FPSBooster")
Toggle(MiscPage, "Better Nametags", "BetterNametags")

Section(MiscPage, "WORLD")
Toggle(MiscPage, "Chest ESP", "ChestESP")

--// Render tab
local RenderPage = Pages["Render"]
Section(RenderPage, "VISUALS")
Toggle(RenderPage, "Player ESP", "ESP")
Toggle(RenderPage, "Box ESP", "BoxESP")
Toggle(RenderPage, "Tracers", "Tracers")
Toggle(RenderPage, "Health Bars", "HealthBars")

--// Feature logic
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if Config.SpeedWalk and hum.WalkSpeed ~= Config.WalkSpeed then
        hum.WalkSpeed = Config.WalkSpeed
    elseif not Config.SpeedWalk and hum.WalkSpeed > 20 then
        hum.WalkSpeed = 16
    end
end)

RunService.Stepped:Connect(function()
    if not Config.NoFall then return end
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp and hrp.AssemblyLinearVelocity.Y < -50 then
            hrp.AssemblyLinearVelocity = Vector3.new(
                hrp.AssemblyLinearVelocity.X, 0, hrp.AssemblyLinearVelocity.Z)
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not Config.AutoPlay then return end
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return end
    local best, bestDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local d = (hrp.Position - myHrp.Position).Magnitude
                if d < bestDist and d < 20 then best, bestDist = hrp, d end
            end
        end
    end
    if best then
        myHrp.CFrame = CFrame.lookAt(myHrp.Position, best.Position)
        local tool = myChar:FindFirstChildOfClass("Tool")
        if tool then pcall(function() tool:Activate() end) end
    end
end)

local fpsApplied, savedQuality, savedShadows, savedBrightness = false
RunService.Heartbeat:Connect(function()
    if Config.FPSBooster and not fpsApplied then
        fpsApplied = true
        pcall(function()
            savedQuality = settings().Rendering.QualityLevel
            savedShadows = Lighting.GlobalShadows
            savedBrightness = Lighting.Brightness
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            Lighting.GlobalShadows = false
            Lighting.Brightness = 0.5
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end)
    elseif not Config.FPSBooster and fpsApplied then
        fpsApplied = false
        pcall(function()
            settings().Rendering.QualityLevel = savedQuality or Enum.QualityLevel.Automatic
            Lighting.GlobalShadows = savedShadows ~= false
            Lighting.Brightness = savedBrightness or 2
        end)
    end
end)

local espHighlights = {}
RunService.Heartbeat:Connect(function()
    if not Config.ESP then
        for _, h in pairs(espHighlights) do if h and h.Parent then h:Destroy() end end
        espHighlights = {}
        return
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if not espHighlights[p] or not espHighlights[p].Parent then
                espHighlights[p] = new("Highlight", {
                    Adornee=p.Character,
                    FillColor=Theme.Accent, OutlineColor=Theme.BorderGlow,
                    FillTransparency=0.5,
                }, {p.Character})
            end
        end
    end
end)

local healthBars = {}
RunService.Heartbeat:Connect(function()
    if not Config.HealthBars then
        for _, bb in pairs(healthBars) do if bb and bb.Parent then bb:Destroy() end end
        healthBars = {}
        return
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            local head = char and char:FindFirstChild("Head")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if head and hum then
                if not healthBars[p] or not healthBars[p].Parent then
                    local bb = new("BillboardGui", {
                        Size=UDim2.fromOffset(70,8),
                        StudsOffset=Vector3.new(0,1.2,0), AlwaysOnTop=true,
                    }, {head})
                    local bg = new("Frame", {
                        Size=UDim2.fromScale(1,1),
                        BackgroundColor3=Color3.fromRGB(30,0,0), BorderSizePixel=0,
                    }, {bb})
                    new("Frame", {
                        Name="Fill", Size=UDim2.fromScale(1,1),
                        BackgroundColor3=Color3.fromRGB(0,255,100), BorderSizePixel=0,
                    }, {bg})
                    healthBars[p] = bb
                end
                local bb = healthBars[p]
                local bg = bb:FindFirstChildWhichIsA("Frame")
                local fill = bg and bg:FindFirstChild("Fill")
                if fill then
                    local pct = math.clamp(hum.Health/hum.MaxHealth, 0, 1)
                    fill.Size = UDim2.new(pct,0,1,0)
                    fill.BackgroundColor3 = Color3.fromRGB(255*(1-pct), 255*pct, 50)
                end
            end
        end
    end
end)

local tracerHolder = new("Frame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, ZIndex=1}, {ScreenGui})
local tracerLines = {}
RunService.RenderStepped:Connect(function()
    if not Config.Tracers then
        for _, l in pairs(tracerLines) do if l.Parent then l:Destroy() end end
        tracerLines = {}
        return
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    if not tracerLines[p] or not tracerLines[p].Parent then
                        tracerLines[p] = new("Frame", {
                            BackgroundColor3=Theme.BorderGlow,
                            BorderSizePixel=0, AnchorPoint=Vector2.new(0,0.5),
                        }, {tracerHolder})
                    end
                    local line = tracerLines[p]
                    local sx, sy = Camera.ViewportSize.X/2, Camera.ViewportSize.Y
                    local dx, dy = pos.X - sx, pos.Y - sy
                    line.Position = UDim2.fromOffset(sx, sy)
                    line.Size = UDim2.fromOffset(math.sqrt(dx*dx+dy*dy), 1)
                    line.Rotation = math.deg(math.atan2(dy, dx))
                elseif tracerLines[p] and tracerLines[p].Parent then
                    tracerLines[p]:Destroy()
                    tracerLines[p] = nil
                end
            end
        end
    end
end)

local boxHolder = new("Frame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, ZIndex=1}, {ScreenGui})
local boxes = {}
RunService.RenderStepped:Connect(function()
    if not Config.BoxESP then
        for _, b in pairs(boxes) do if b.Parent then b:Destroy() end end
        boxes = {}
        return
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
                    local h = math.clamp(800/math.max(dist,1), 30, 250)
                    local w = h / 2.5
                    if not boxes[p] or not boxes[p].Parent then
                        local box = new("Frame", {BackgroundTransparency=1, BorderSizePixel=0}, {boxHolder})
                        stroke(Theme.BorderGlow, 1.5, box)
                        boxes[p] = box
                    end
                    boxes[p].Size = UDim2.fromOffset(w, h)
                    boxes[p].Position = UDim2.fromOffset(pos.X-w/2, pos.Y-h/2)
                elseif boxes[p] and boxes[p].Parent then
                    boxes[p]:Destroy()
                    boxes[p] = nil
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not Config.ChestESP then return end
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("chest") or obj.Name:lower():find("crate")) then
            if not obj:FindFirstChild("BallisticChestHL") then
                new("Highlight", {
                    Name="BallisticChestHL", Adornee=obj,
                    FillColor=Color3.fromRGB(255,215,0),
                    OutlineColor=Theme.BorderGlow, FillTransparency=0.6,
                }, {obj})
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not Config.BetterNametags then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local head = p.Character:FindFirstChild("Head")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if head and hum then
                if not head:FindFirstChild("BallisticTag") then
                    local bb = new("BillboardGui", {
                        Name="BallisticTag", Size=UDim2.fromOffset(160,40),
                        StudsOffset=Vector3.new(0,2.5,0), AlwaysOnTop=true,
                    }, {head})
                    new("TextLabel", {
                        Size=UDim2.new(1,0,0.5,0), BackgroundTransparency=1,
                        Font=Font, Text=p.Name, TextSize=14, TextColor3=Theme.BorderGlow,
                        TextStrokeTransparency=0, TextStrokeColor3=Color3.fromRGB(0,0,0),
                    }, {bb})
                    new("TextLabel", {
                        Name="HP", Size=UDim2.new(1,0,0.5,0),
                        Position=UDim2.new(0,0,0.5,0), BackgroundTransparency=1,
                        Font=FontMono, Text="", TextSize=12,
                        TextColor3=Color3.fromRGB(255,100,100),
                    }, {bb})
                end
                local bb = head:FindFirstChild("BallisticTag")
                if bb then
                    local hp = bb:FindFirstChild("HP")
                    if hp then
                        hp.Text = math.floor(hum.Health).." / "..math.floor(hum.MaxHealth)
                    end
                end
            end
        end
    end
end)

local capeObj = nil
local function applyCape()
    if capeObj and capeObj.Parent then capeObj:Destroy() end
    capeObj = nil
    local char = LocalPlayer.Character
    if not char then return end
    local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    if not torso then return end
    local cape = new("Part", {
        Name="BallisticCape", Size=Vector3.new(2.1,2.4,0.08),
        Color=Color3.fromRGB(20,8,34), Material=Enum.Material.SmoothPlastic,
        CanCollide=false, CanTouch=false, Massless=true,
    }, {char})
    local gui = new("SurfaceGui", {Face=Enum.NormalId.Back, AlwaysOnTop=false, LightInfluence=0}, {cape})
    new("Frame", {
        Size=UDim2.fromScale(1,1),
        BackgroundColor3=Color3.fromRGB(12,4,26), BorderSizePixel=0,
    }, {gui})
    new("TextLabel", {
        Size=UDim2.fromScale(1,1), BackgroundTransparency=1,
        Font=Font, Text="B", TextScaled=true,
        TextColor3=Color3.fromRGB(255,255,255),
        TextStrokeTransparency=0, TextStrokeColor3=Theme.BorderGlow,
    }, {gui})
    new("WeldConstraint", {Part0=torso, Part1=cape}, {cape})
    cape.CFrame = torso.CFrame * CFrame.new(0,-0.4,0.75) * CFrame.Angles(math.rad(-8),0,0)
    capeObj = cape
end

local lastCape = Config.CustomCape
RunService.Heartbeat:Connect(function()
    if Config.CustomCape ~= lastCape then
        lastCape = Config.CustomCape
        if Config.CustomCape then applyCape()
        elseif capeObj and capeObj.Parent then
            capeObj:Destroy(); capeObj = nil
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.8)
    if Config.CustomCape then applyCape() end
end)

RunService.Heartbeat:Connect(function()
    if not Config.CustomSword then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") then
            local h = t:FindFirstChild("Handle")
            if h then h.Color = Theme.AccentLit; h.Material = Enum.Material.Neon end
        end
    end
end)

local mapApplied = false
RunService.Heartbeat:Connect(function()
    if Config.CustomMapMesh and not mapApplied then
        mapApplied = true
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("bed") or obj.Name:lower():find("generator")) then
                pcall(function()
                    obj.Material = Enum.Material.Neon
                    obj.Color = Theme.Accent
                end)
            end
        end
    elseif not
