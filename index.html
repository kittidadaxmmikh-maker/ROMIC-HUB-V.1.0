-- [[ SETTINGS ]] --
local Settings = {
    Key = "xyz",
    isVerified = false, -- สถานะเริ่มต้นคือยังไม่ได้ใส่รหัส
    Aimbot = false,
    WallCheck = true,
    FOV = 150,
    ShowFOV = true,
    ESP_Box = false,
    ESP_Line = false,
    SpeedHack = false,
    Accent = Color3.fromRGB(255, 35, 35)
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")

-- [[ 1. UI CORE ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Delta_Ultra_Locked"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false

-- [[ 2. PERFECT CENTERED FOV (ซ่อนไว้ก่อน) ]] --
local FOVCircle = Instance.new("Frame")
FOVCircle.Size = UDim2.new(0, 300, 0, 300)
FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.BackgroundColor3 = Settings.Accent
FOVCircle.BackgroundTransparency = 0.95
FOVCircle.Visible = false -- ปิดไว้ก่อน
FOVCircle.Parent = ScreenGui
Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)
local FOVStroke = Instance.new("UIStroke", FOVCircle)
FOVStroke.Color = Settings.Accent
FOVStroke.Thickness = 1.5

-- [[ 3. MAIN UI FRAME (ซ่อนไว้ก่อน) ]] --
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 280)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false -- ปิดไว้ก่อน
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 100, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar)

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -115, 1, -15)
TabContainer.Position = UDim2.new(0, 110, 0, 10)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

-- [[ 4. FLOATING BUTTON (ซ่อนไว้ก่อน) ]] --
local Float = Instance.new("TextButton")
Float.Size = UDim2.new(0, 50, 0, 50)
Float.Position = UDim2.new(0.05, 0, 0.2, 0)
Float.BackgroundColor3 = Settings.Accent
Float.Text = "Δ"
Float.TextColor3 = Color3.new(1, 1, 1)
Float.Visible = false -- ปิดไว้ก่อน
Float.Parent = ScreenGui
Instance.new("UICorner", Float).CornerRadius = UDim.new(1, 0)

Float.MouseButton1Click:Connect(function()
    if Settings.isVerified then -- ต้องใส่รหัสแล้วเท่านั้นถึงกดได้
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- [[ 5. KEY SYSTEM UI (สวยๆ ลื่นๆ) ]] --
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 320, 0, 220)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
KeyFrame.Parent = ScreenGui
Instance.new("UICorner", KeyFrame)
local KeyStroke = Instance.new("UIStroke", KeyFrame)
KeyStroke.Color = Settings.Accent
KeyStroke.Thickness = 2

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 60)
KeyTitle.Text = "DELTA PREMIUM KEY"
KeyTitle.TextColor3 = Settings.Accent
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.BackgroundTransparency = 1
KeyTitle.TextSize = 18
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.8, 0, 0, 45)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyInput.Text = ""
KeyInput.PlaceholderText = "ใส่รหัสที่นี่..."
KeyInput.TextColor3 = Color3.new(1, 1, 1)
KeyInput.Parent = KeyFrame
Instance.new("UICorner", KeyInput)

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0.8, 0, 0, 45)
VerifyBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
VerifyBtn.BackgroundColor3 = Settings.Accent
VerifyBtn.Text = "VERIFY"
VerifyBtn.TextColor3 = Color3.new(1, 1, 1)
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Parent = KeyFrame
Instance.new("UICorner", VerifyBtn)

-- [[ 6. LOADING SCREEN (3 Bars) ]] --
local LoadFrame = Instance.new("Frame")
LoadFrame.Size = UDim2.new(0, 350, 0, 250)
LoadFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
LoadFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
LoadFrame.Visible = false
LoadFrame.Parent = ScreenGui
Instance.new("UICorner", LoadFrame)

local function CreateLoadBar(yPos, labelText)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Position = UDim2.new(0, 0, 0, yPos - 25)
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.BackgroundTransparency = 1
    Label.Parent = LoadFrame

    local Bg = Instance.new("Frame")
    Bg.Size = UDim2.new(0.8, 0, 0, 10)
    Bg.Position = UDim2.new(0.1, 0, 0, yPos)
    Bg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Bg.Parent = LoadFrame
    Instance.new("UICorner", Bg)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(0, 0, 1, 0)
    Fill.BackgroundColor3 = Settings.Accent
    Fill.Parent = Bg
    Instance.new("UICorner", Fill)
    return Fill
end

-- [[ LOGIC: การใส่รหัสและโหลด ]] --
VerifyBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == Settings.Key then
        -- รหัสถูก: เริ่มขั้นตอนโหลด
        KeyFrame:Destroy()
        LoadFrame.Visible = true
        
        local Bar1 = CreateLoadBar(70, "Verifying Status...")
        local Bar2 = CreateLoadBar(140, "Loading UI Components...")
        local Bar3 = CreateLoadBar(210, "Setting Up ESP/Aimbot...")

        local t = TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        TS:Create(Bar1, t, {Size = UDim2.new(1, 0, 1, 0)}):Play()
        task.wait(1.3)
        TS:Create(Bar2, t, {Size = UDim2.new(1, 0, 1, 0)}):Play()
        task.wait(1.3)
        TS:Create(Bar3, t, {Size = UDim2.new(1, 0, 1, 0)}):Play()
        task.wait(1.3)

        -- โหลดเสร็จแล้ว: ปลดล็อกทุกอย่าง
        LoadFrame:Destroy()
        Settings.isVerified = true
        Float.Visible = true -- แสดงปุ่มลูกลอย
        MainFrame.Visible = true -- แสดงเมนูหลัก
    else
        -- รหัสผิด
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "รหัสไม่ถูกต้อง!"
        TS:Create(KeyStroke, TweenInfo.new(0.2), {Color = Color3.new(1, 0, 0)}):Play()
        task.wait(1)
        KeyInput.PlaceholderText = "ใส่รหัสที่นี่..."
        TS:Create(KeyStroke, TweenInfo.new(0.2), {Color = Settings.Accent}):Play()
    end
end)

-- [[ TAB SYSTEM ]] --
local Pages = {}
local TabButtons = {}
local function CreateTab(name, isDefault)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 35)
    Btn.Position = UDim2.new(0.05, 0, 0, 10 + (#TabButtons * 40))
    Btn.BackgroundColor3 = isDefault and Settings.Accent or Color3.fromRGB(30, 30, 30)
    Btn.Text = name
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.GothamBold
    Btn.Parent = Sidebar
    Instance.new("UICorner", Btn)

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = isDefault
    Page.ScrollBarThickness = 0
    Page.Parent = TabContainer
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8)

    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(TabButtons) do b.BackgroundColor3 = Color3.fromRGB(30, 30, 30) end
        Page.Visible = true
        Btn.BackgroundColor3 = Settings.Accent
    end)
    table.insert(Pages, Page)
    table.insert(TabButtons, Btn)
    return Page
end

-- [[ UI ELEMENTS ]] --
local function AddToggle(text, parent, default, callback)
    local Tgl = Instance.new("TextButton")
    Tgl.Size = UDim2.new(1, -5, 0, 40)
    Tgl.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Tgl.Text = "  " .. text
    Tgl.TextColor3 = Color3.fromRGB(200, 200, 200)
    Tgl.TextXAlignment = Enum.TextXAlignment.Left
    Tgl.Parent = parent
    Instance.new("UICorner", Tgl)
    local Ind = Instance.new("Frame")
    Ind.Size = UDim2.new(0, 18, 0, 18)
    Ind.Position = UDim2.new(1, -28, 0.28, 0)
    Ind.BackgroundColor3 = default and Settings.Accent or Color3.fromRGB(60, 60, 60)
    Ind.Parent = Tgl
    Instance.new("UICorner", Ind).CornerRadius = UDim.new(1, 0)
    Tgl.MouseButton1Click:Connect(function()
        default = not default
        TS:Create(Ind, TweenInfo.new(0.2), {BackgroundColor3 = default and Settings.Accent or Color3.fromRGB(60, 60, 60)}):Play()
        callback(default)
    end)
end

local function AddSlider(text, parent, min, max, default, callback)
    local SFrame = Instance.new("Frame")
    SFrame.Size = UDim2.new(1, -5, 0, 50)
    SFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SFrame.Parent = parent
    Instance.new("UICorner", SFrame)
    local Lab = Instance.new("TextLabel")
    Lab.Size = UDim2.new(1, 0, 0, 25)
    Lab.Text = "  " .. text .. ": " .. default
    Lab.TextColor3 = Color3.new(1, 1, 1)
    Lab.BackgroundTransparency = 1
    Lab.TextXAlignment = Enum.TextXAlignment.Left
    Lab.Parent = SFrame
    local Bar = Instance.new("TextButton")
    Bar.Size = UDim2.new(0.9, 0, 0, 4)
    Bar.Position = UDim2.new(0.05, 0, 0.75, 0)
    Bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Bar.Text = ""
    Bar.Parent = SFrame
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(default/max, 0, 1, 0)
    Fill.BackgroundColor3 = Settings.Accent
    Fill.Parent = Bar
    local dragging = false
    local function Update(input)
        local x = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        Fill.Size = UDim2.new(x, 0, 1, 0)
        local val = math.floor(min + (max - min) * x)
        Lab.Text = "  " .. text .. ": " .. val
        callback(val)
    end
    Bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true end end)
    UIS.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then Update(i) end end)
    UIS.InputEnded:Connect(function() dragging = false end)
end

-- TABS
local AimP = CreateTab("Aimbot", true)
local VisP = CreateTab("Visuals", false)
local MisP = CreateTab("อื่น ๆ", false)

AddToggle("Enable Aimbot", AimP, Settings.Aimbot, function(v) Settings.Aimbot = v end)
AddToggle("Wall Check", AimP, Settings.WallCheck, function(v) Settings.WallCheck = v end)
AddToggle("Show FOV Circle", AimP, Settings.ShowFOV, function(v) Settings.ShowFOV = v end)
AddSlider("FOV Size", AimP, 0, 500, Settings.FOV, function(v) Settings.FOV = v end)

AddToggle("ESP Box (Red)", VisP, Settings.ESP_Box, function(v) Settings.ESP_Box = v end)
AddToggle("ESP Line (White)", VisP, Settings.ESP_Line, function(v) Settings.ESP_Line = v end)

AddToggle("Speed x50", MisP, Settings.SpeedHack, function(v) 
    Settings.SpeedHack = v 
    if not v and LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
end)

-- [[ CORE LOOP (ทำงานเมื่อใส่รหัสผ่านแล้วเท่านั้น) ]] --
local ESP_Objects = {}
RS.RenderStepped:Connect(function()
    if not Settings.isVerified then return end -- หยุดทำงานถ้ายังไม่ใส่รหัส

    -- Speed
    if Settings.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end
    
    -- FOV Update
    FOVCircle.Visible = Settings.ShowFOV
    FOVCircle.Size = UDim2.new(0, Settings.FOV * 2, 0, Settings.FOV * 2)

    local Center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local Target = nil
    local MinDist = Settings.FOV

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
            local Root = p.Character.HumanoidRootPart
            local Pos, OnScreen = Camera:WorldToViewportPoint(Root.Position)
            
            if not ESP_Objects[p.Name] then
                local b = Drawing.new("Square")
                b.Thickness = 1.5
                b.Color = Color3.fromRGB(255, 0, 0)
                b.Filled = false
                local l = Drawing.new("Line")
                l.Thickness = 1
                l.Color = Color3.fromRGB(255, 255, 255)
                ESP_Objects[p.Name] = {Box = b, Line = l}
            end
            
            local esp = ESP_Objects[p.Name]
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

            if Settings.Aimbot and OnScreen then
                local d = (Vector2.new(Pos.X, Pos.Y) - Center).Magnitude
                if d < MinDist then
                    if Settings.WallCheck then
                        local ray = RaycastParams.new()
                        ray.FilterDescendantsInstances = {LocalPlayer.Character, p.Character}
                        local res = workspace:Raycast(Camera.CFrame.Position, Root.Position - Camera.CFrame.Position, ray)
                        if not res then Target = Root MinDist = d end
                    else Target = Root MinDist = d end
                end
            end
        elseif ESP_Objects[p.Name] then
            ESP_Objects[p.Name].Box.Visible = false
            ESP_Objects[p.Name].Line.Visible = false
        end
    end
    if Target and Settings.Aimbot then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Position)
    end
end)
