local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Settings = { 
    SpeedEnabled = false, 
    ESPEnabled = false, 
    WalkSpeedValue = 30,
    NoCollideEnabled = false
}

local function UpdateCollision()
    if Settings.NoCollideEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NZF_UI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local NotificationQueue = {}
local MAX_NOTIFICATIONS = 5
local NOTIF_HEIGHT = 65
local NOTIF_SPACING = 8
local NOTIF_DURATION = 4
local NOTIF_WIDTH = 320
local START_X = -340
local START_Y = 65

local function playSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9120381438"
    sound.Volume = 0.25
    sound.Parent = ScreenGui
    sound:Play()
    task.wait(0.3)
    sound:Destroy()
end

local function UpdateNotifications()
    for i, notifData in ipairs(NotificationQueue) do
        local notif = notifData.frame
        if notif and notif.Parent then
            local targetY = START_Y + (i - 1) * (NOTIF_HEIGHT + NOTIF_SPACING)
            TweenService:Create(notif, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.1), {
                Position = UDim2.new(1, START_X, 0, targetY)
            }):Play()
        end
    end
end

local function CreateNotification(text, color)
    playSound()
    
    while #NotificationQueue >= MAX_NOTIFICATIONS do
        local oldest = table.remove(NotificationQueue, #NotificationQueue)
        if oldest and oldest.frame then
            TweenService:Create(oldest.frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 1,
                Position = UDim2.new(1, 50, 0, oldest.frame.Position.Y.Offset)
            }):Play()
            task.wait(0.15)
            oldest.frame:Destroy()
        end
    end
    
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, NOTIF_WIDTH, 0, NOTIF_HEIGHT)
    notif.Position = UDim2.new(1, 30, 0, START_Y)
    notif.BackgroundColor3 = color or Color3.fromRGB(40, 40, 60)
    notif.BackgroundTransparency = 0.15
    notif.BorderSizePixel = 0
    notif.ZIndex = 200
    notif.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = notif
    
    local border = Instance.new("Frame")
    border.Size = UDim2.new(1, 0, 1, 0)
    border.BackgroundTransparency = 1
    border.ZIndex = -1
    border.Parent = notif
    
    local borderGrad = Instance.new("UIGradient")
    borderGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color or Color3.fromRGB(100, 200, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, color or Color3.fromRGB(100, 200, 255))
    })
    borderGrad.Rotation = 90
    border.BackgroundColor3 = color or Color3.fromRGB(100, 200, 255)
    border.BackgroundTransparency = 0.1
    
    local bgGrad = Instance.new("UIGradient")
    bgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 240, 250))
    })
    bgGrad.Rotation = 135
    notif.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notif.BackgroundTransparency = 0.08
    
    local iconFrame = Instance.new("Frame")
    iconFrame.Size = UDim2.new(0, 35, 0, 35)
    iconFrame.Position = UDim2.new(0, 12, 0.5, -17)
    iconFrame.BackgroundColor3 = color or Color3.fromRGB(100, 200, 255)
    iconFrame.BackgroundTransparency = 0.2
    iconFrame.BorderSizePixel = 0
    iconFrame.ZIndex = 201
    iconFrame.Parent = notif
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(1, 0)
    iconCorner.Parent = iconFrame
    
    local iconText = Instance.new("TextLabel")
    iconText.Size = UDim2.new(1, 0, 1, 0)
    iconText.BackgroundTransparency = 1
    iconText.Text = "Z"
    iconText.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconText.TextSize = 20
    iconText.Font = Enum.Font.GothamBold
    iconText.TextXAlignment = Enum.TextXAlignment.Center
    iconText.TextYAlignment = Enum.TextYAlignment.Center
    iconText.ZIndex = 202
    iconText.Parent = iconFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -65, 1, -5)
    label.Position = UDim2.new(0, 55, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(20, 20, 30)
    label.TextSize = 15
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.ZIndex = 201
    label.Parent = notif
    
    local barFrame = Instance.new("Frame")
    barFrame.Size = UDim2.new(1, -24, 0, 3)
    barFrame.Position = UDim2.new(0, 12, 1, -7)
    barFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 220)
    barFrame.BackgroundTransparency = 0.5
    barFrame.BorderSizePixel = 0
    barFrame.ZIndex = 201
    barFrame.Parent = notif
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = barFrame
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(1, 0, 1, 0)
    fill.BackgroundColor3 = color or Color3.fromRGB(100, 200, 255)
    fill.BackgroundTransparency = 0
    fill.BorderSizePixel = 0
    fill.ZIndex = 202
    fill.Parent = barFrame
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    local fillGrad = Instance.new("UIGradient")
    fillGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color or Color3.fromRGB(100, 200, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, color or Color3.fromRGB(100, 200, 255))
    })
    fillGrad.Rotation = 90
    fillGrad.Parent = fill
    
    local notifData = {
        frame = notif,
        fill = fill,
        label = label,
        color = color,
        text = text,
        created = tick(),
        alive = true,
        iconFrame = iconFrame
    }
    
    table.insert(NotificationQueue, 1, notifData)
    UpdateNotifications()
    
    notif.Position = UDim2.new(1, 30, 0, START_Y)
    notif.BackgroundTransparency = 0.3
    notif.Size = UDim2.new(0, 0, 0, NOTIF_HEIGHT)
    
    for i = 1, 20 do
        local progress = i / 20
        local ease = 1 - (1 - progress) * (1 - progress)
        local sizeX = NOTIF_WIDTH * ease
        notif.Size = UDim2.new(0, sizeX, 0, NOTIF_HEIGHT)
        notif.Position = UDim2.new(1, 30 - (370 * ease), 0, START_Y)
        notif.BackgroundTransparency = 0.3 - (0.22 * ease)
        task.wait(0.015)
    end
    
    notif.Size = UDim2.new(0, NOTIF_WIDTH, 0, NOTIF_HEIGHT)
    notif.Position = UDim2.new(1, START_X, 0, START_Y)
    notif.BackgroundTransparency = 0.08
    
    iconFrame.Size = UDim2.new(0, 0, 0, 0)
    iconFrame.BackgroundTransparency = 0.5
    for i = 1, 12 do
        local progress = i / 12
        local size = 35 * (1 + (1 - progress) * 0.3)
        iconFrame.Size = UDim2.new(0, size, 0, size)
        iconFrame.Position = UDim2.new(0, 12 - (size - 35)/2, 0.5, -size/2)
        iconFrame.BackgroundTransparency = 0.2 - (0.15 * progress)
        task.wait(0.02)
    end
    iconFrame.Size = UDim2.new(0, 35, 0, 35)
    iconFrame.Position = UDim2.new(0, 12, 0.5, -17)
    iconFrame.BackgroundTransparency = 0.2
    
    local startTime = tick()
    
    while tick() - startTime < NOTIF_DURATION do
        local elapsed = tick() - startTime
        local progress = 1 - (elapsed / NOTIF_DURATION)
        fill.Size = UDim2.new(progress, 0, 1, 0)
        task.wait(0.05)
    end
    
    fill.Size = UDim2.new(0, 0, 1, 0)
    wait(0.2)
    
    if notifData.alive and notif and notif.Parent then
        notifData.alive = false
        
        for i = 1, 18 do
            local progress = i / 18
            local ease = progress * progress
            notif.Position = UDim2.new(1, START_X + (390 * ease), 0, notif.Position.Y.Offset)
            notif.BackgroundTransparency = 0.08 + (0.22 * ease)
            notif.Size = UDim2.new(0, NOTIF_WIDTH * (1 - ease * 0.3), 0, NOTIF_HEIGHT)
            task.wait(0.015)
        end
        
        notif:Destroy()
        
        for i, data in ipairs(NotificationQueue) do
            if data == notifData then
                table.remove(NotificationQueue, i)
                break
            end
        end
        
        UpdateNotifications()
    end
    
    return notifData
end

local function showNotification(text, color)
    CreateNotification(text, color)
end

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0.04, 0, 0.5, -27)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = "F"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 38
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.ZIndex = 100
ToggleBtn.Parent = ScreenGui

local ring = Instance.new("ImageLabel")
ring.Name = "Ring"
ring.Size = UDim2.new(1.5, 0, 1.5, 0)
ring.Position = UDim2.new(-0.25, 0, -0.25, 0)
ring.BackgroundTransparency = 1
ring.Image = "rbxassetid://6031091150"
ring.ImageColor3 = Color3.fromRGB(200, 200, 220)
ring.ImageTransparency = 0.5
ring.ZIndex = 99
ring.Parent = ToggleBtn

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
MainFrame.BackgroundTransparency = 1
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.ZIndex = 50
MainFrame.Parent = ScreenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 18)
mainCorner.Parent = MainFrame

local border = Instance.new("Frame")
border.Name = "Border"
border.Size = UDim2.new(1, 0, 1, 0)
border.BackgroundTransparency = 1
border.ZIndex = 2
border.Parent = MainFrame

local borderGrad = Instance.new("UIGradient")
borderGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 150)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 200, 100)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(100, 255, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 255))
})
borderGrad.Rotation = 90
border.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
border.BackgroundTransparency = 0.15

local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, -80, 0, 45)
TitleFrame.Position = UDim2.new(0, 0, 0, 0)
TitleFrame.BackgroundTransparency = 1
TitleFrame.ZIndex = 3
TitleFrame.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = ""
Title.TextColor3 = Color3.fromRGB(20, 20, 30)
Title.TextSize = 35
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.TextYAlignment = Enum.TextYAlignment.Center
Title.ZIndex = 4
Title.Parent = TitleFrame

local divider = Instance.new("Frame")
divider.Size = UDim2.new(0.85, 0, 0, 2)
divider.Position = UDim2.new(0.075, 0, 1, -3)
divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
divider.BackgroundTransparency = 0.3
divider.ZIndex = 3
divider.Parent = TitleFrame

local divGrad = Instance.new("UIGradient")
divGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 150)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 200, 100)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(100, 255, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 255))
})
divGrad.Parent = divider

local function animateTitle()
    local text = "NZF"
    Title.Text = ""
    for i = 1, #text do
        Title.Text = text:sub(1, i)
        Title.TextTransparency = 1
        for t = 1, 8 do
            local progress = t / 8
            Title.TextTransparency = 1 - progress
            Title.Size = UDim2.new(1 - (0.08 * (1 - progress)), 0, 1, 0)
            task.wait(0.025)
        end
        Title.TextTransparency = 0
        Title.Size = UDim2.new(1, 0, 1, 0)
        task.wait(0.1)
    end
end

local categories = {
    {name = "หลัก", color = Color3.fromRGB(100, 200, 255)},
    {name = "ESP", color = Color3.fromRGB(255, 200, 100)},
    {name = "อื่นๆ", color = Color3.fromRGB(255, 100, 150)}
}
local currentCategory = 1
local categoryButtons = {}
local contentFrames = {}

local function createCategoryTabs()
    local tabX = 0.78
    local tabWidth = 0.18
    local tabHeight = 42
    local spacing = 6
    local startY = 52
    
    for i, cat in ipairs(categories) do
        local btn = Instance.new("ImageButton")
        btn.Size = UDim2.new(tabWidth, 0, 0, tabHeight)
        btn.Position = UDim2.new(tabX, 0, 0, startY + (i-1) * (tabHeight + spacing))
        btn.BackgroundColor3 = cat.color
        btn.BackgroundTransparency = 0.7
        btn.BorderSizePixel = 0
        btn.ZIndex = 3
        btn.Parent = MainFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = cat.name
        label.TextColor3 = Color3.fromRGB(20, 20, 30)
        label.TextSize = 13
        label.Font = Enum.Font.GothamBold
        label.TextXAlignment = Enum.TextXAlignment.Center
        label.TextYAlignment = Enum.TextYAlignment.Center
        label.ZIndex = 4
        label.Parent = btn
        
        categoryButtons[i] = btn
        
        btn.MouseButton1Click:Connect(function()
            switchCategory(i)
        end)
    end
end

local function createCategoryContent()
    local contentX = 0.04
    local contentWidth = 0.70
    local contentY = 48
    local contentHeight = 230
    
    for i = 1, 3 do
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(contentWidth, 0, 0, contentHeight)
        frame.Position = UDim2.new(contentX, 0, 0, contentY)
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 0
        frame.ZIndex = 3
        frame.Parent = MainFrame
        frame.Visible = (i == 1)
        contentFrames[i] = frame
    end
    
    local mainContent = contentFrames[1]
    
    local speedFrame = Instance.new("Frame")
    speedFrame.Size = UDim2.new(0.96, 0, 0, 40)
    speedFrame.Position = UDim2.new(0.02, 0, 0, 5)
    speedFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    speedFrame.BackgroundTransparency = 0.85
    speedFrame.BorderSizePixel = 0
    speedFrame.ZIndex = 3
    speedFrame.Parent = mainContent
    
    local sfCorner = Instance.new("UICorner")
    sfCorner.CornerRadius = UDim.new(0, 8)
    sfCorner.Parent = speedFrame
    
    local SpeedInput = Instance.new("TextBox")
    SpeedInput.Name = "SpeedInput"
    SpeedInput.Size = UDim2.new(1, -20, 1, 0)
    SpeedInput.Position = UDim2.new(0, 10, 0, 0)
    SpeedInput.BackgroundTransparency = 1
    SpeedInput.Text = "30"
    SpeedInput.TextColor3 = Color3.fromRGB(20, 20, 30)
    SpeedInput.TextSize = 16
    SpeedInput.Font = Enum.Font.GothamBold
    SpeedInput.TextXAlignment = Enum.TextXAlignment.Center
    SpeedInput.PlaceholderText = "ตั้งค่าความเร็ว"
    SpeedInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 180)
    SpeedInput.ClearTextOnFocus = false
    SpeedInput.ZIndex = 4
    SpeedInput.Parent = speedFrame
    
    SpeedInput.FocusLost:Connect(function()
        if tonumber(SpeedInput.Text) then 
            Settings.WalkSpeedValue = tonumber(SpeedInput.Text)
            showNotification("ตั้งค่าความเร็ว: " .. Settings.WalkSpeedValue, Color3.fromRGB(100, 200, 255))
        end
    end)
    
    local speedBtn = Instance.new("ImageButton")
    speedBtn.Size = UDim2.new(0.96, 0, 0, 45)
    speedBtn.Position = UDim2.new(0.02, 0, 0, 55)
    speedBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 150)
    speedBtn.BackgroundTransparency = 0.6
    speedBtn.BorderSizePixel = 0
    speedBtn.ZIndex = 3
    speedBtn.Parent = mainContent
    
    local sbCorner = Instance.new("UICorner")
    sbCorner.CornerRadius = UDim.new(0, 10)
    sbCorner.Parent = speedBtn
    
    local speedLabel = Instance.new("TextLabel")
    speedLabel.Size = UDim2.new(1, -30, 1, 0)
    speedLabel.Position = UDim2.new(0, 15, 0, 0)
    speedLabel.BackgroundTransparency = 1
    speedLabel.Text = "วิ่งเร็ว : ปิด"
    speedLabel.TextColor3 = Color3.fromRGB(20, 20, 30)
    speedLabel.TextSize = 16
    speedLabel.Font = Enum.Font.GothamBold
    speedLabel.TextXAlignment = Enum.TextXAlignment.Left
    speedLabel.TextYAlignment = Enum.TextYAlignment.Center
    speedLabel.ZIndex = 4
    speedLabel.Parent = speedBtn
    
    local speedState = false
    speedBtn.MouseButton1Click:Connect(function()
        speedState = not speedState
        Settings.SpeedEnabled = speedState
        if speedState then
            speedLabel.Text = "วิ่งเร็ว : กำลังใช้งาน"
            speedBtn.BackgroundTransparency = 0.1
            showNotification("เปิดวิ่งเร็ว", Color3.fromRGB(255, 100, 150))
        else
            speedLabel.Text = "วิ่งเร็ว : ปิด"
            speedBtn.BackgroundTransparency = 0.6
            showNotification("ปิดวิ่งเร็ว", Color3.fromRGB(200, 200, 200))
        end
    end)
    
    local separator = Instance.new("Frame")
    separator.Size = UDim2.new(0.9, 0, 0, 1)
    separator.Position = UDim2.new(0.05, 0, 0, 108)
    separator.BackgroundColor3 = Color3.fromRGB(200, 200, 220)
    separator.BackgroundTransparency = 0.5
    separator.BorderSizePixel = 0
    separator.ZIndex = 3
    separator.Parent = mainContent
    
    local statusInfo = Instance.new("TextLabel")
    statusInfo.Size = UDim2.new(0.96, 0, 0, 25)
    statusInfo.Position = UDim2.new(0.02, 0, 0, 120)
    statusInfo.BackgroundTransparency = 1
    statusInfo.Text = "ความเร็วปัจจุบัน: " .. Settings.WalkSpeedValue
    statusInfo.TextColor3 = Color3.fromRGB(100, 100, 120)
    statusInfo.TextSize = 13
    statusInfo.Font = Enum.Font.GothamMedium
    statusInfo.TextXAlignment = Enum.TextXAlignment.Center
    statusInfo.ZIndex = 4
    statusInfo.Parent = mainContent
    
    SpeedInput.FocusLost:Connect(function()
        if tonumber(SpeedInput.Text) then 
            statusInfo.Text = "ความเร็วปัจจุบัน: " .. SpeedInput.Text
        end
    end)
    
    local espContent = contentFrames[2]
    
    local espBtn = Instance.new("ImageButton")
    espBtn.Size = UDim2.new(0.96, 0, 0, 45)
    espBtn.Position = UDim2.new(0.02, 0, 0, 5)
    espBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
    espBtn.BackgroundTransparency = 0.6
    espBtn.BorderSizePixel = 0
    espBtn.ZIndex = 3
    espBtn.Parent = espContent
    
    local ebCorner = Instance.new("UICorner")
    ebCorner.CornerRadius = UDim.new(0, 10)
    ebCorner.Parent = espBtn
    
    local espLabel = Instance.new("TextLabel")
    espLabel.Size = UDim2.new(1, -30, 1, 0)
    espLabel.Position = UDim2.new(0, 15, 0, 0)
    espLabel.BackgroundTransparency = 1
    espLabel.Text = "ESP : ปิด"
    espLabel.TextColor3 = Color3.fromRGB(20, 20, 30)
    espLabel.TextSize = 16
    espLabel.Font = Enum.Font.GothamBold
    espLabel.TextXAlignment = Enum.TextXAlignment.Left
    espLabel.TextYAlignment = Enum.TextYAlignment.Center
    espLabel.ZIndex = 4
    espLabel.Parent = espBtn
    
    local espState = false
    espBtn.MouseButton1Click:Connect(function()
        espState = not espState
        Settings.ESPEnabled = espState
        if espState then
            espLabel.Text = "ESP : กำลังใช้งาน"
            espBtn.BackgroundTransparency = 0.1
            showNotification("เปิด ESP", Color3.fromRGB(255, 200, 100))
        else
            espLabel.Text = "ESP : ปิด"
            espBtn.BackgroundTransparency = 0.6
            showNotification("ปิด ESP", Color3.fromRGB(200, 200, 200))
        end
    end)
    
    local espInfo = Instance.new("TextLabel")
    espInfo.Size = UDim2.new(0.96, 0, 0, 25)
    espInfo.Position = UDim2.new(0.02, 0, 0, 60)
    espInfo.BackgroundTransparency = 1
    espInfo.Text = "ไฮไลท์ผู้เล่นทุกคน"
    espInfo.TextColor3 = Color3.fromRGB(100, 100, 120)
    espInfo.TextSize = 13
    espInfo.Font = Enum.Font.GothamMedium
    espInfo.TextXAlignment = Enum.TextXAlignment.Center
    espInfo.ZIndex = 4
    espInfo.Parent = espContent
    
    local otherContent = contentFrames[3]
    
    local ncBtn = Instance.new("ImageButton")
    ncBtn.Size = UDim2.new(0.96, 0, 0, 45)
    ncBtn.Position = UDim2.new(0.02, 0, 0, 5)
    ncBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 150)
    ncBtn.BackgroundTransparency = 0.6
    ncBtn.BorderSizePixel = 0
    ncBtn.ZIndex = 3
    ncBtn.Parent = otherContent
    
    local ncCorner = Instance.new("UICorner")
    ncCorner.CornerRadius = UDim.new(0, 10)
    ncCorner.Parent = ncBtn
    
    local ncLabel = Instance.new("TextLabel")
    ncLabel.Size = UDim2.new(1, -30, 1, 0)
    ncLabel.Position = UDim2.new(0, 15, 0, 0)
    ncLabel.BackgroundTransparency = 1
    ncLabel.Text = "กันปลิว : ปิด"
    ncLabel.TextColor3 = Color3.fromRGB(20, 20, 30)
    ncLabel.TextSize = 16
    ncLabel.Font = Enum.Font.GothamBold
    ncLabel.TextXAlignment = Enum.TextXAlignment.Left
    ncLabel.TextYAlignment = Enum.TextYAlignment.Center
    ncLabel.ZIndex = 4
    ncLabel.Parent = ncBtn
    
    local ncState = false
    ncBtn.MouseButton1Click:Connect(function()
        ncState = not ncState
        Settings.NoCollideEnabled = ncState
        
        ncLabel.Text = ncState and "กันปลิว : กำลังใช้งาน" or "กันปลิว : ปิด"
        ncBtn.BackgroundTransparency = ncState and 0.1 or 0.6
        
        if ncState then
            showNotification("เปิดกันปลิว", Color3.fromRGB(100, 255, 150))
        else
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    for _, part in pairs(player.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end
            end
            showNotification("ปิดกันปลิว", Color3.fromRGB(200, 200, 200))
        end
    end)
    
    local ncInfo = Instance.new("TextLabel")
    ncInfo.Size = UDim2.new(0.96, 0, 0, 25)
    ncInfo.Position = UDim2.new(0.02, 0, 0, 60)
    ncInfo.BackgroundTransparency = 1
    ncInfo.Text = "ปิดการชนเฉพาะผู้เล่นคนอื่น"
    ncInfo.TextColor3 = Color3.fromRGB(100, 100, 120)
    ncInfo.TextSize = 13
    ncInfo.Font = Enum.Font.GothamMedium
    ncInfo.TextXAlignment = Enum.TextXAlignment.Center
    ncInfo.ZIndex = 4
    ncInfo.Parent = otherContent
end

function switchCategory(index)
    currentCategory = index
    
    for i, btn in ipairs(categoryButtons) do
        if i == index then
            btn.BackgroundTransparency = 0.15
            btn.Size = UDim2.new(0.18, 0, 0, 44)
        else
            btn.BackgroundTransparency = 0.7
            btn.Size = UDim2.new(0.18, 0, 0, 42)
        end
    end
    
    for i, frame in ipairs(contentFrames) do
        frame.Visible = (i == index)
    end
end

createCategoryTabs()
createCategoryContent()

local StatusBar = Instance.new("Frame")
StatusBar.Size = UDim2.new(0.85, 0, 0, 28)
StatusBar.Position = UDim2.new(0.05, 0, 1, -32)
StatusBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
StatusBar.BackgroundTransparency = 0.88
StatusBar.BorderSizePixel = 0
StatusBar.ZIndex = 3
StatusBar.Parent = MainFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = StatusBar

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 1, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "● พร้อมใช้งาน"
StatusText.TextColor3 = Color3.fromRGB(20, 20, 30)
StatusText.TextSize = 12
StatusText.Font = Enum.Font.GothamMedium
StatusText.TextXAlignment = Enum.TextXAlignment.Center
StatusText.ZIndex = 4
StatusText.Parent = StatusBar

local versionFrame = Instance.new("Frame")
versionFrame.Name = "VersionFrame"
versionFrame.Size = UDim2.new(0, 110, 0, 28)
versionFrame.Position = UDim2.new(0.88, 0, 1, -32)
versionFrame.BackgroundTransparency = 1
versionFrame.ZIndex = 60
versionFrame.Parent = MainFrame

local dot = Instance.new("ImageLabel")
dot.Name = "Dot"
dot.Size = UDim2.new(0, 10, 0, 10)
dot.Position = UDim2.new(0, 0, 0.5, -5)
dot.BackgroundTransparency = 1
dot.Image = "rbxassetid://6031091150"
dot.ImageColor3 = Color3.fromRGB(0, 255, 80)
dot.ImageTransparency = 0.1
dot.ZIndex = 61
dot.Parent = versionFrame

local glow = Instance.new("ImageLabel")
glow.Name = "Glow"
glow.Size = UDim2.new(2.8, 0, 2.8, 0)
glow.Position = UDim2.new(-0.9, 0, -0.9, 0)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://6031091150"
glow.ImageColor3 = Color3.fromRGB(0, 255, 80)
glow.ImageTransparency = 0.5
glow.ZIndex = 60
glow.Parent = dot

local glow2 = Instance.new("ImageLabel")
glow2.Name = "Glow2"
glow2.Size = UDim2.new(4.5, 0, 4.5, 0)
glow2.Position = UDim2.new(-1.75, 0, -1.75, 0)
glow2.BackgroundTransparency = 1
glow2.Image = "rbxassetid://6031091150"
glow2.ImageColor3 = Color3.fromRGB(0, 200, 60)
glow2.ImageTransparency = 0.7
glow2.ZIndex = 59
glow2.Parent = dot

local versionLabel = Instance.new("TextLabel")
versionLabel.Name = "VersionLabel"
versionLabel.Size = UDim2.new(0, 85, 1, 0)
versionLabel.Position = UDim2.new(0, 16, 0, 0)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "v1.0"
versionLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
versionLabel.TextSize = 13
versionLabel.Font = Enum.Font.GothamBold
versionLabel.TextXAlignment = Enum.TextXAlignment.Left
versionLabel.TextYAlignment = Enum.TextYAlignment.Center
versionLabel.ZIndex = 61
versionLabel.Parent = versionFrame

RunService.RenderStepped:Connect(function()
    if Settings.SpeedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Settings.WalkSpeedValue
        StatusText.Text = "● กำลังวิ่ง : " .. Settings.WalkSpeedValue
        StatusText.TextColor3 = Color3.fromRGB(20, 20, 30)
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            if LocalPlayer.Character.Humanoid.WalkSpeed ~= 16 then
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end
        if not Settings.SpeedEnabled then
            StatusText.Text = "● พร้อมใช้งาน"
            StatusText.TextColor3 = Color3.fromRGB(20, 20, 30)
        end
    end
    
    if Settings.ESPEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("NZF_ESP") then
                local hl = Instance.new("Highlight", p.Character)
                hl.Name = "NZF_ESP"
                hl.FillColor = Color3.fromRGB(255, 200, 100)
                hl.FillTransparency = 0.3
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                hl.OutlineTransparency = 0
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hl.Adornee = p.Character
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("NZF_ESP") then
                p.Character.NZF_ESP:Destroy()
            end
        end
    end
    
    UpdateCollision()
end)

local isOpen = false

ToggleBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    
    if isOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        for i = 1, 18 do
            local progress = i / 18
            local ease = 1 - (1 - progress) * (1 - progress)
            local sizeX = 420 * ease
            local sizeY = 320 * ease
            MainFrame.Size = UDim2.new(0, sizeX, 0, sizeY)
            MainFrame.Position = UDim2.new(0.5, -(210 * ease), 0.5, -(160 * ease))
            task.wait(0.012)
        end
        
        MainFrame.Size = UDim2.new(0, 420, 0, 320)
        MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
        
        animateTitle()
        switchCategory(1)
        
        TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {Rotation = 180}):Play()
        TweenService:Create(ring, TweenInfo.new(0.3), {
            ImageColor3 = Color3.fromRGB(255, 200, 100)
        }):Play()
        
    else
        for i = 1, 12 do
            local progress = i / 12
            local sizeX = 420 - (420 * progress)
            local sizeY = 320 - (320 * progress)
            MainFrame.Size = UDim2.new(0, sizeX, 0, sizeY)
            MainFrame.Position = UDim2.new(0.5, -(210 * (1 - progress)), 0.5, -(160 * (1 - progress)))
            task.wait(0.012)
        end
        
        MainFrame.Visible = false
        
        TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {Rotation = 0}):Play()
        TweenService:Create(ring, TweenInfo.new(0.3), {
            ImageColor3 = Color3.fromRGB(200, 200, 220)
        }):Play()
    end
end)

RunService.Heartbeat:Connect(function(dt)
    ring.Rotation = (ring.Rotation or 0) + dt * 40
    
    local breathe = (math.sin(tick() * 2.5) + 1) / 2
    
    glow.ImageTransparency = 0.4 + (breathe * 0.3)
    glow.Size = UDim2.new(2.2 + (breathe * 0.8), 0, 2.2 + (breathe * 0.8), 0)
    glow.Position = UDim2.new(-0.6 - (breathe * 0.2), 0, -0.6 - (breathe * 0.2), 0)
    
    glow2.ImageTransparency = 0.6 + (breathe * 0.25)
    glow2.Size = UDim2.new(3.8 + (breathe * 1.2), 0, 3.8 + (breathe * 1.2), 0)
    glow2.Position = UDim2.new(-1.4 - (breathe * 0.3), 0, -1.4 - (breathe * 0.3), 0)
    
    dot.ImageTransparency = 0.05 + (breathe * 0.15)
    dot.Size = UDim2.new(8 + (breathe * 4), 0, 8 + (breathe * 4), 0)
    dot.Position = UDim2.new(0, -(breathe * 2), 0.5, -4 - (breathe * 2))
end)

print("NZF UI v1.0 พร้อมใช้งาน!")