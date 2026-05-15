-- [[ SETTINGS ]] --
local Settings = {
    Key = "xyz",
    isVerified = false,
    Aimbot = false,
    WallCheck = true,
    FOV = 150,
    ShowFOV = true,
    ESP_Box = false,
    ESP_Line = false,
    SpeedHack = false,
    EnemyPull = false,
    PullDistance = 5,
    Accent = Color3.fromRGB(255, 35, 35),
    DarkBG = Color3.fromRGB(15, 15, 15),
    SecondaryBG = Color3.fromRGB(25, 25, 25)
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local SG = game:GetService("StarterGui")

-- [[ ฟังก์ชันเสียงและการแจ้งเตือน ]] --
local function NotifySuccess()
    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://452267918" 
    Sound.Parent = game:GetService("SoundService")
    Sound:Play()
    game:GetService("Debris"):AddItem(Sound, 2)

    SG:SetCore("SendNotification", {
        Title = "Exs1.0",
        Text = "โหลดเสร็จแล้ว 💩💩",
        Duration = 5
    })
end

-- [[ 1. SCREEN GUI & CENTER FOV ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Exs1.0_Delta"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.IgnoreGuiInset = true 
ScreenGui.ResetOnSpawn = false

local FOVCircle = Instance.new("Frame")
FOVCircle.Size = UDim2.new(0, 300, 0, 300)
FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.BackgroundColor3 = Settings.Accent
FOVCircle.BackgroundTransparency = 0.95
FOVCircle.Visible = false
FOVCircle.Parent = ScreenGui
Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)
local FOVStroke = Instance.new("UIStroke", FOVCircle)
FOVStroke.Color = Settings.Accent
FOVStroke.Thickness = 2

-- [[ 2. ESP SYSTEM (STABLE CLEANUP) ]] --
local ESP_Objects = {}
local function RemoveESP(player)
    if ESP_Objects[player] then
        if ESP_Objects[player].Box then ESP_Objects[player].Box:Remove() end
        if ESP_Objects[player].Line then ESP_Objects[player].Line:Remove() end
        ESP_Objects[player] = nil
    end
end
Players.PlayerRemoving:Connect(RemoveESP)

-- [[ 3. UI BUILDER FUNCTIONS ]] --
local function SmoothTween(obj, info, goal)
    return TS:Create(obj, TweenInfo.new(info, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), goal):Play()
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 330)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -165)
MainFrame.BackgroundColor3 = Settings.DarkBG
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 15)

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -140, 1, -20)
TabContainer.Position = UDim2.new(0, 130, 0, 10)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local Pages = {}
local TabBtns = {}
local function CreateTab(name, isDefault)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 45)
    Btn.Position = UDim2.new(0.05, 0, 0, 15 + (#TabBtns * 52))
    Btn.BackgroundColor3 = isDefault and Settings.Accent or Color3.fromRGB(35, 35, 35)
    Btn.Text = name
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 18 -- ใหญ่ขึ้น
    Btn.Parent = Sidebar
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = isDefault
    Page.ScrollBarThickness = 0
    Page.Parent = TabContainer
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 12)

    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(TabBtns) do SmoothTween(b, 0.3, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}) end
        Page.Visible = true
        SmoothTween(Btn, 0.3, {BackgroundColor3 = Settings.Accent})
    end)
    table.insert(Pages, Page)
    table.insert(TabBtns, Btn)
    return Page
end

local function AddToggle(text, parent, default, callback)
    local Tgl = Instance.new("TextButton")
    Tgl.Size = UDim2.new(1, -5, 0, 50)
    Tgl.BackgroundColor3 = Settings.SecondaryBG
    Tgl.Text = "    " .. text
    Tgl.TextColor3 = Color3.fromRGB(220, 220, 220)
    Tgl.TextXAlignment = Enum.TextXAlignment.Left
    Tgl.Font = Enum.Font.GothamBold
    Tgl.TextSize = 17 -- ใหญ่ขึ้น
    Tgl.Parent = parent
    Instance.new("UICorner", Tgl).CornerRadius = UDim.new(0, 12)

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 26, 0, 26)
    Indicator.Position = UDim2.new(1, -40, 0.24, 0)
    Indicator.BackgroundColor3 = default and Settings.Accent or Color3.fromRGB(65, 65, 65)
    Indicator.Parent = Tgl
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(0, 8)

    Tgl.MouseButton1Click:Connect(function()
        default = not default
        SmoothTween(Indicator, 0.2, {BackgroundColor3 = default and Settings.Accent or Color3.fromRGB(65, 65, 65)})
        callback(default)
    end)
end

local function AddSlider(text, parent, min, max, default, callback)
    local SFrame = Instance.new("Frame")
    SFrame.Size = UDim2.new(1, -5, 0, 75)
    SFrame.BackgroundColor3 = Settings.SecondaryBG
    SFrame.Parent = parent
    Instance.new("UICorner", SFrame).CornerRadius = UDim.new(0, 12)

    local Lab = Instance.new("TextLabel")
    Lab.Size = UDim2.new(1, 0, 0, 35)
    Lab.Text = "    " .. text .. ": " .. default
    Lab.TextColor3 = Color3.new(1, 1, 1)
    Lab.BackgroundTransparency = 1
    Lab.TextXAlignment = Enum.TextXAlignment.Left
    Lab.Font = Enum.Font.GothamBold
    Lab.TextSize = 17 -- ใหญ่ขึ้น
    Lab.Parent = SFrame

    local Bar = Instance.new("TextButton")
    Bar.Size = UDim2.new(0.9, 0, 0, 14)
    Bar.Position = UDim2.new(0.05, 0, 0.65, 0)
    Bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Bar.Text = ""
    Bar.Parent = SFrame
    Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(default/max, 0, 1, 0)
    Fill.BackgroundColor3 = Settings.Accent
    Fill.Parent = Bar
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function Update(input)
        local x = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        Fill.Size = UDim2.new(x, 0, 1, 0)
        local val = math.floor(min + (max - min) * x)
        Lab.Text = "    " .. text .. ": " .. val
        callback(val)
    end
    Bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true end end)
    UIS.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then Update(i) end end)
    UIS.InputEnded:Connect(function() dragging = false end)
end

-- [[ 4. KEY SYSTEM UI (Exs1.0) ]] --
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 340, 0, 240)
KeyFrame.Position = UDim2.new(0.5, -170, 0.5, -120)
KeyFrame.BackgroundColor3 = Settings.DarkBG
KeyFrame.Parent = ScreenGui
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 15)
Instance.new("UIStroke", KeyFrame).Color = Settings.Accent

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 60)
KeyTitle.Text = "Exs1.0"
KeyTitle.TextColor3 = Settings.Accent
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 25
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.8, 0, 0, 50)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.BackgroundColor3 = Settings.SecondaryBG
KeyInput.PlaceholderText = "xyz"
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.new(1, 1, 1)
KeyInput.TextSize = 18
KeyInput.Parent = KeyFrame
Instance.new("UICorner", KeyInput)

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0.8, 0, 0, 50)
VerifyBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
VerifyBtn.BackgroundColor3 = Settings.Accent
VerifyBtn.Text = "เข้าสู่ระบบ"
VerifyBtn.TextColor3 = Color3.new(1, 1, 1)
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.TextSize = 18
VerifyBtn.Parent = KeyFrame
Instance.new("UICorner", VerifyBtn)

local Float = Instance.new("TextButton")
Float.Size = UDim2.new(0, 60, 0, 60)
Float.Position = UDim2.new(0.05, 0, 0.15, 0)
Float.BackgroundColor3 = Settings.Accent
Float.Text = "Δ"
Float.TextColor3 = Color3.new(1, 1, 1)
Float.TextSize = 30
Float.Visible = false
Float.Parent = ScreenGui
Instance.new("UICorner", Float).CornerRadius = UDim.new(1, 0)

-- [[ 5. TABS SETUP ]] --
local AimP = CreateTab("Aimbot", true)
local VisP = CreateTab("Visuals", false)
local MisP = CreateTab("อื่น ๆ", false)

AddToggle("เปิดระบบล็อกเป้า", AimP, Settings.Aimbot, function(v) Settings.Aimbot = v end)
AddToggle("กันล็อกหลังกำแพง", AimP, Settings.WallCheck, function(v) Settings.WallCheck = v end)
AddToggle("แสดงวง FOV", AimP, Settings.ShowFOV, function(v) Settings.ShowFOV = v end)
AddSlider("รัศมีวงล็อกเป้า", AimP, 0, 500, Settings.FOV, function(v) Settings.FOV = v end)

AddToggle("ESP กล่อง (แดง)", VisP, Settings.ESP_Box, function(v) Settings.ESP_Box = v end)
AddToggle("ESP เส้น (ขาว)", VisP, Settings.ESP_Line, function(v) Settings.ESP_Line = v end)

AddToggle("Speed Hack x50", MisP, Settings.SpeedHack, function(v) 
    Settings.SpeedHack = v 
    if not v and LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
end)
AddToggle("ดึงศัตรู (Visual Pull)", MisP, Settings.EnemyPull, function(v) Settings.EnemyPull = v end)
AddSlider("ระยะดึง (0-50 Studs)", MisP, 0, 50, Settings.PullDistance, function(v) Settings.PullDistance = v end)

-- [ Verify & Loading Logic ] --
VerifyBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == Settings.Key then
        KeyFrame:Destroy()
        local LoadFrame = Instance.new("Frame")
        LoadFrame.Size = UDim2.new(0, 350, 0, 260)
        LoadFrame.Position = UDim2.new(0.5, -175, 0.5, -130)
        LoadFrame.BackgroundColor3 = Settings.DarkBG
        LoadFrame.Parent = ScreenGui
        Instance.new("UICorner", LoadFrame).CornerRadius = UDim.new(0, 15)

        local function Bar(y, txt)
            local l = Instance.new("TextLabel")
            l.Size = UDim2.new(1,0,0,25) l.Position = UDim2.new(0,0,0,y-30) l.Text = txt l.TextColor3 = Color3.new(1,1,1) l.Font = Enum.Font.GothamBold l.TextSize = 16 l.BackgroundTransparency = 1 l.Parent = LoadFrame
            local bg = Instance.new("Frame") bg.Size = UDim2.new(0.8,0,0,14) bg.Position = UDim2.new(0.1,0,0,y) bg.BackgroundColor3 = Color3.fromRGB(30,30,30) bg.Parent = LoadFrame Instance.new("UICorner", bg).CornerRadius = UDim.new(1,0)
            local f = Instance.new("Frame") f.Size = UDim2.new(0,0,1,0) f.BackgroundColor3 = Settings.Accent f.Parent = bg Instance.new("UICorner", f).CornerRadius = UDim.new(1,0)
            return f
        end

        local b1 = Bar(80, "Verifying Script...")
        local b2 = Bar(150, "Checking Assets...")
        local b3 = Bar(220, "Finalizing UI...")

        TS:Create(b1, TweenInfo.new(1.2), {Size = UDim2.new(1,0,1,0)}):Play() task.wait(1.3)
        TS:Create(b2, TweenInfo.new(1.2), {Size = UDim2.new(1,0,1,0)}):Play() task.wait(1.3)
        TS:Create(b3, TweenInfo.new(1.2), {Size = UDim2.new(1,0,1,0)}):Play() task.wait(1.3)

        LoadFrame:Destroy()
        NotifySuccess()
        Settings.isVerified = true
        Float.Visible = true
        MainFrame.Visible = true
    end
end)

Float.MouseButton1Click:Connect(function() if Settings.isVerified then MainFrame.Visible = not MainFrame.Visible end end)

-- [[ 6. MAIN LOGIC SYSTEM ]] --
RS.RenderStepped:Connect(function()
    if not Settings.isVerified then return end
    
    if Settings.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end

    FOVCircle.Visible = Settings.ShowFOV
    FOVCircle.Size = UDim2.new(0, Settings.FOV * 2, 0, Settings.FOV * 2)

    local Center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local Target = nil
    local MinDist = Settings.FOV

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
            local Root = p.Character.HumanoidRootPart
            local Pos, OnScreen = Camera:WorldToViewportPoint(Root.Position)
            
            if not ESP_Objects[p] then 
                local b = Drawing.new("Square") b.Thickness = 1.8 b.Color = Color3.fromRGB(255, 0, 0) b.Filled = false
                local l = Drawing.new("Line") l.Thickness = 1.2 l.Color = Color3.fromRGB(255, 255, 255)
                ESP_Objects[p] = {Box = b, Line = l}
            end
            local esp = ESP_Objects[p]

            if Settings.ESP_Box and OnScreen then
                local head = Camera:WorldToViewportPoint(p.Character.Head.Position + Vector3.new(0, 0.5, 0))
                local leg = Camera:WorldToViewportPoint(Root.Position - Vector3.new(0, 3, 0))
                esp.Box.Visible = true
                esp.Box.Size = Vector2.new(math.abs(head.Y - leg.Y) / 1.5, math.abs(head.Y - leg.Y))
                esp.Box.Position = Vector2.new(Pos.X - esp.Box.Size.X/2, Pos.Y - esp.Box.Size.Y/2)
            else esp.Box.Visible = false end

            if Settings.ESP_Line and OnScreen then
                esp.Line.Visible = true
                esp.Line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                esp.Line.To = Vector2.new(Pos.X, Pos.Y)
            else esp.Line.Visible = false end

            if OnScreen then
                local d = (Vector2.new(Pos.X, Pos.Y) - Center).Magnitude
                if d < MinDist then
                    if Settings.WallCheck then
                        local RayP = RaycastParams.new()
                        RayP.FilterDescendantsInstances = {LocalPlayer.Character, p.Character}
                        RayP.FilterType = Enum.RaycastFilterType.Exclude
                        local res = workspace:Raycast(Camera.CFrame.Position, (p.Character.Head.Position - Camera.CFrame.Position), RayP)
                        if res == nil then Target = p.Character.Head MinDist = d end
                    else Target = p.Character.Head MinDist = d end
                end
            end
        elseif ESP_Objects[p] then
            ESP_Objects[p].Box.Visible = false
            ESP_Objects[p].Line.Visible = false
        end
    end
    
    if Target and Settings.isVerified then
        if Settings.Aimbot then Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Position) end
        if Settings.EnemyPull then
            local PullPos = Camera.CFrame.Position + (Camera.CFrame.LookVector * Settings.PullDistance)
            Target.Parent.HumanoidRootPart.CFrame = CFrame.new(PullPos)
        end
    end
end)
