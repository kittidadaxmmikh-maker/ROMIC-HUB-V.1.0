-- ============================================
-- NZF LOADER ENHANCED - MOBILE
-- ============================================

local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player       = Players.LocalPlayer

-- ============================================
-- Helper: สร้าง Tween
-- ============================================
local function tween(obj, props, duration, style, direction)
    local info = TweenInfo.new(
        duration   or 0.4,
        style      or Enum.EasingStyle.Quad,
        direction  or Enum.EasingDirection.Out
    )
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

-- ============================================
-- Helper: UICorner
-- ============================================
local function addCorner(parent, scale)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(scale or 0, 0)
    c.Parent = parent
    return c
end

-- ============================================
-- สร้าง ScreenGui
-- ============================================
local gui = Instance.new("ScreenGui")
gui.Name           = "NZF_Loader_Enhanced"
gui.ResetOnSpawn   = false
gui.IgnoreGuiInset = true
gui.Parent         = player.PlayerGui

-- ============================================
-- พื้นหลังดำ Gradient
-- ============================================
local loader = Instance.new("Frame")
loader.Name                  = "Loader"
loader.Size                  = UDim2.new(1, 0, 1, 0)
loader.BackgroundColor3      = Color3.fromRGB(4, 4, 14)
loader.BackgroundTransparency = 0
loader.BorderSizePixel       = 0
loader.ZIndex                = 100
loader.ClipsDescendants      = true
loader.Parent                = gui

local bgGrad = Instance.new("UIGradient")
bgGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(4,  4,  18)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(8,  4,  24)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(4,  4,  18)),
})
bgGrad.Rotation = 120
bgGrad.Parent = loader

-- ============================================
-- Grid lines พื้นหลัง
-- ============================================
local gridLayer = Instance.new("Frame")
gridLayer.Size                  = UDim2.new(1, 0, 1, 0)
gridLayer.BackgroundTransparency = 1
gridLayer.ZIndex                = 100
gridLayer.Parent                = loader

for i = 1, 16 do
    local h = Instance.new("Frame")
    h.Size             = UDim2.new(1, 0, 0, 1)
    h.Position         = UDim2.new(0, 0, i / 16, 0)
    h.BackgroundColor3 = Color3.fromRGB(40, 40, 90)
    h.BackgroundTransparency = 0.82
    h.BorderSizePixel  = 0
    h.ZIndex           = 100
    h.Parent           = gridLayer

    local v = Instance.new("Frame")
    v.Size             = UDim2.new(0, 1, 1, 0)
    v.Position         = UDim2.new(i / 16, 0, 0, 0)
    v.BackgroundColor3 = Color3.fromRGB(40, 40, 90)
    v.BackgroundTransparency = 0.82
    v.BorderSizePixel  = 0
    v.ZIndex           = 100
    v.Parent           = gridLayer
end

-- ============================================
-- Particles (ดาวลอย)
-- ============================================
local PARTICLE_COUNT = 50
local particles      = {}

for i = 1, PARTICLE_COUNT do
    local sz = math.random(2, 6)
    local p  = Instance.new("Frame")
    p.Size                  = UDim2.new(0, sz, 0, sz)
    p.Position              = UDim2.new(math.random() * 0.98, 0, math.random() * 0.98, 0)
    p.BackgroundColor3      = Color3.fromRGB(
        math.random(80, 200),
        math.random(100, 220),
        255
    )
    p.BackgroundTransparency = math.random(30, 70) / 100
    p.BorderSizePixel       = 0
    p.ZIndex                = 101
    p.Parent                = loader
    addCorner(p, 1)
    particles[i] = { frame = p, speed = math.random(8, 22) / 1000 }
end

-- ============================================
-- Decorative rings รอบหัวเรื่อง
-- ============================================
local ringsGroup = {}
local ringConfigs = {
    { sz = 190, col = Color3.fromRGB(80, 140, 255),  tr = 0.55, spd =  0.6 },
    { sz = 240, col = Color3.fromRGB(140, 80, 255),  tr = 0.65, spd = -0.4 },
    { sz = 290, col = Color3.fromRGB(80, 200, 255),  tr = 0.75, spd =  0.25 },
}
for _, cfg in ipairs(ringConfigs) do
    local rf = Instance.new("Frame")
    rf.Size                  = UDim2.new(0, cfg.sz, 0, cfg.sz)
    rf.Position              = UDim2.new(0.5, -cfg.sz / 2, 0.23, -cfg.sz / 2)
    rf.BackgroundTransparency = 1
    rf.BorderSizePixel       = 0
    rf.ZIndex                = 101
    rf.Parent                = loader
    addCorner(rf, 1)
    local stroke = Instance.new("UIStroke")
    stroke.Color       = cfg.col
    stroke.Thickness   = 1.5
    stroke.Transparency = cfg.tr
    stroke.Parent      = rf
    table.insert(ringsGroup, { frame = rf, speed = cfg.spd, rot = 0 })
end

-- ============================================
-- Glow blob กลาง
-- ============================================
local glowBlob = Instance.new("Frame")
glowBlob.Size                  = UDim2.new(0, 260, 0, 260)
glowBlob.Position              = UDim2.new(0.5, -130, 0.23, -130)
glowBlob.BackgroundColor3      = Color3.fromRGB(60, 90, 255)
glowBlob.BackgroundTransparency = 0.94
glowBlob.BorderSizePixel       = 0
glowBlob.ZIndex                = 100
glowBlob.Parent                = loader
addCorner(glowBlob, 1)

-- ============================================
-- Title Frame "NZF"
-- ============================================
local titleFrame = Instance.new("Frame")
titleFrame.Size                  = UDim2.new(0, 300, 0, 110)
titleFrame.Position              = UDim2.new(0.5, -150, 0.17, -55)
titleFrame.BackgroundTransparency = 1
titleFrame.ZIndex                = 103
titleFrame.Parent                = loader

local letters      = { "N", "Z", "F" }
local letterLabels = {}
local letterGlows  = {}

local LETTER_COLORS = {
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(140, 200, 255),
    Color3.fromRGB(200, 140, 255),
    Color3.fromRGB(140, 255, 210),
}

for i, letter in ipairs(letters) do
    -- Glow shadow
    local glow = Instance.new("TextLabel")
    glow.Size                  = UDim2.new(0, 82, 1, 0)
    glow.Position              = UDim2.new(0, (i - 1) * 100 + 2, 0, 4)
    glow.BackgroundTransparency = 1
    glow.Text                  = letter
    glow.TextColor3            = Color3.fromRGB(60, 120, 255)
    glow.TextSize              = 80
    glow.Font                  = Enum.Font.GothamBold
    glow.TextScaled            = true
    glow.ZIndex                = 102
    glow.Visible               = false
    glow.Parent                = titleFrame
    letterGlows[i] = glow

    -- Main letter
    local lbl = Instance.new("TextLabel")
    lbl.Size                  = UDim2.new(0, 80, 1, 0)
    lbl.Position              = UDim2.new(0, (i - 1) * 100, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text                  = letter
    lbl.TextColor3            = Color3.fromRGB(255, 255, 255)
    lbl.TextSize              = 80
    lbl.Font                  = Enum.Font.GothamBold
    lbl.TextScaled            = true
    lbl.ZIndex                = 103
    lbl.Visible               = false
    lbl.Parent                = titleFrame
    letterLabels[i] = lbl

    local stroke = Instance.new("UIStroke")
    stroke.Color       = Color3.fromRGB(100, 160, 255)
    stroke.Thickness   = 2
    stroke.Transparency = 0.2
    stroke.Parent      = lbl
end

-- ============================================
-- Subtitle & Separator
-- ============================================
local versionLabel = Instance.new("TextLabel")
versionLabel.Size                  = UDim2.new(0, 320, 0, 24)
versionLabel.Position              = UDim2.new(0.5, -160, 0.38, 0)
versionLabel.BackgroundTransparency = 1
versionLabel.Text                  = "◤  SYSTEM LOADER  v2.0  ◥"
versionLabel.TextColor3            = Color3.fromRGB(100, 170, 255)
versionLabel.TextSize              = 13
versionLabel.Font                  = Enum.Font.GothamBold
versionLabel.TextTransparency      = 1
versionLabel.ZIndex                = 103
versionLabel.Parent                = loader

local sep = Instance.new("Frame")
sep.Size             = UDim2.new(0, 0, 0, 1)
sep.Position         = UDim2.new(0.5, 0, 0.44, 0)
sep.BackgroundColor3 = Color3.fromRGB(80, 130, 255)
sep.BackgroundTransparency = 0.4
sep.BorderSizePixel  = 0
sep.ZIndex           = 103
sep.Parent           = loader

-- ============================================
-- Loading Bar
-- ============================================
local barBg = Instance.new("Frame")
barBg.Size                 = UDim2.new(0, 340, 0, 14)
barBg.Position             = UDim2.new(0.5, -170, 0.52, 0)
barBg.BackgroundColor3     = Color3.fromRGB(16, 16, 40)
barBg.BorderSizePixel      = 0
barBg.ZIndex               = 103
barBg.ClipsDescendants     = true   -- ← clip shimmer ไม่ให้วิ่งเกินหลอด
barBg.Parent               = loader
addCorner(barBg, 1)

local barStroke = Instance.new("UIStroke")
barStroke.Color       = Color3.fromRGB(60, 100, 200)
barStroke.Thickness   = 1
barStroke.Transparency = 0.3
barStroke.Parent      = barBg

local fill = Instance.new("Frame")
fill.Size             = UDim2.new(0, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(100, 190, 255)
fill.BorderSizePixel  = 0
fill.ZIndex           = 104
fill.Parent           = barBg
addCorner(fill, 1)

local fillGrad = Instance.new("UIGradient")
fillGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,    Color3.fromRGB(50,  120, 255)),
    ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(140, 80,  255)),
    ColorSequenceKeypoint.new(1,    Color3.fromRGB(200, 60,  255)),
})
fillGrad.Parent = fill

-- Shimmer บนหลอด (parent = barBg, ใช้ pixel offset → clip พอดีหลอด)
local shimmer = Instance.new("Frame")
shimmer.Size                  = UDim2.new(0, 50, 1, 0)
shimmer.Position              = UDim2.new(0, -55, 0, 0)
shimmer.BackgroundColor3      = Color3.fromRGB(255, 255, 255)
shimmer.BackgroundTransparency = 0.65
shimmer.BorderSizePixel       = 0
shimmer.ZIndex                = 105
shimmer.Parent                = barBg   -- ← เปลี่ยนจาก fill → barBg
addCorner(shimmer, 1)

-- ============================================
-- เปอร์เซ็นต์
-- ============================================
local percentLabel = Instance.new("TextLabel")
percentLabel.Size                  = UDim2.new(0, 120, 0, 44)
percentLabel.Position              = UDim2.new(0.5, -60, 0.572, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.Text                  = "0%"
percentLabel.TextColor3            = Color3.fromRGB(255, 255, 255)
percentLabel.TextSize              = 28
percentLabel.Font                  = Enum.Font.GothamBold
percentLabel.ZIndex                = 103
percentLabel.Parent                = loader

-- ============================================
-- 3-Dot bouncing indicator
-- ============================================
local dotsFrame = Instance.new("Frame")
dotsFrame.Size                  = UDim2.new(0, 56, 0, 18)
dotsFrame.Position              = UDim2.new(0.5, -28, 0.665, 0)
dotsFrame.BackgroundTransparency = 1
dotsFrame.ZIndex                = 103
dotsFrame.Parent                = loader

local dots = {}
for i = 1, 3 do
    local d = Instance.new("Frame")
    d.Size             = UDim2.new(0, 8, 0, 8)
    d.Position         = UDim2.new(0, (i - 1) * 24, 0, 5)
    d.BackgroundColor3 = Color3.fromRGB(100, 190, 255)
    d.BackgroundTransparency = 0.5
    d.BorderSizePixel  = 0
    d.ZIndex           = 103
    d.Parent           = dotsFrame
    addCorner(d, 1)
    dots[i] = d
end

-- ============================================
-- Sub-text สถานะ
-- ============================================
local subText = Instance.new("TextLabel")
subText.Size                  = UDim2.new(0, 300, 0, 28)
subText.Position              = UDim2.new(0.5, -150, 0.705, 0)
subText.BackgroundTransparency = 1
subText.Text                  = "กำลังโหลดระบบ..."
subText.TextColor3            = Color3.fromRGB(140, 160, 210)
subText.TextSize              = 14
subText.Font                  = Enum.Font.Gotham
subText.ZIndex                = 103
subText.Parent                = loader

-- ============================================
-- Corner brackets ประดับมุม
-- ============================================
local function cornerBracket(ax, ay, rot)
    local f = Instance.new("Frame")
    f.Size                  = UDim2.new(0, 28, 0, 28)
    f.Position              = UDim2.new(ax, 0, ay, 0)
    f.BackgroundTransparency = 1
    f.Rotation              = rot
    f.ZIndex                = 102
    f.Parent                = loader

    for _, d in ipairs({
        { UDim2.new(1, 0, 0, 2), UDim2.new(0, 0, 0, 0) },   -- horizontal
        { UDim2.new(0, 2, 1, 0), UDim2.new(0, 0, 0, 0) },   -- vertical
    }) do
        local line = Instance.new("Frame")
        line.Size             = d[1]
        line.Position         = d[2]
        line.BackgroundColor3 = Color3.fromRGB(80, 160, 255)
        line.BackgroundTransparency = 0.25
        line.BorderSizePixel  = 0
        line.ZIndex           = 102
        line.Parent           = f
    end
    return f
end

cornerBracket(0.04, 0.06,   0)
cornerBracket(0.90, 0.06,  90)
cornerBracket(0.04, 0.88, -90)
cornerBracket(0.90, 0.88, 180)

-- ============================================
-- Animation Loop Flags
-- ============================================
local running = true

-- Loop: particles ลอยขึ้น
task.spawn(function()
    while running do
        for _, info in ipairs(particles) do
            local p   = info.frame
            local ny  = p.Position.Y.Scale - info.speed
            local nx  = p.Position.X.Scale
            if ny < -0.02 then
                ny = 1.02
                nx = math.random() * 0.98
            end
            p.Position = UDim2.new(nx, 0, ny, 0)
        end
        task.wait(0.05)
    end
end)

-- Loop: หมุน rings
task.spawn(function()
    while running do
        for _, r in ipairs(ringsGroup) do
            r.rot = r.rot + r.speed
            r.frame.Rotation = r.rot
        end
        task.wait(0.03)
    end
end)

-- Loop: pulse glow
task.spawn(function()
    while running do
        tween(glowBlob, { BackgroundTransparency = 0.91 }, 1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        task.wait(1.2)
        tween(glowBlob, { BackgroundTransparency = 0.96 }, 1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        task.wait(1.2)
    end
end)

-- Loop: dot bounce
task.spawn(function()
    local di = 1
    while running do
        for i, d in ipairs(dots) do
            if i == di then
                tween(d, {
                    BackgroundTransparency = 0,
                    Size                  = UDim2.new(0, 11, 0, 11),
                    Position              = UDim2.new(0, (i - 1) * 24, 0, 1)
                }, 0.18)
            else
                tween(d, {
                    BackgroundTransparency = 0.6,
                    Size                  = UDim2.new(0, 7, 0, 7),
                    Position              = UDim2.new(0, (i - 1) * 24, 0, 5)
                }, 0.18)
            end
        end
        di = di % 3 + 1
        task.wait(0.32)
    end
end)

-- Loop: shimmer วิ่งอยู่ในหลอด (pixel offset → barBg กว้าง 340)
task.spawn(function()
    while running do
        shimmer.Position = UDim2.new(0, -55, 0, 0)
        tween(shimmer, { Position = UDim2.new(0, 345, 0, 0) }, 1.4, Enum.EasingStyle.Linear)
        task.wait(2.0)
    end
end)

-- Loop: gradient หลังหมุน
task.spawn(function()
    local angle = 120
    while running do
        angle = (angle + 0.4) % 360
        bgGrad.Rotation = angle
        task.wait(0.04)
    end
end)

-- ============================================
-- Main Loader Function
-- ============================================
local function startLoader()

    -- ➊ แอนิเมชั่นตัวอักษร NZF ทีละตัว
    for i, lbl in ipairs(letterLabels) do
        local gl = letterGlows[i]
        lbl.Visible  = true
        gl.Visible   = true
        lbl.TextTransparency = 1
        gl.TextTransparency  = 1
        local baseX = (i - 1) * 100
        lbl.Position = UDim2.new(0, baseX, 0, -55)
        gl.Position  = UDim2.new(0, baseX + 2, 0, -51)

        -- เด้งลงมา
        tween(lbl, {
            TextTransparency = 0,
            Position         = UDim2.new(0, baseX, 0, 8),
        }, 0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        tween(gl, {
            TextTransparency = 0.55,
            Position         = UDim2.new(0, baseX + 2, 0, 12),
        }, 0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

        task.wait(0.28)

        -- ตั้งตำแหน่งสุดท้าย
        tween(lbl, { Position = UDim2.new(0, baseX, 0, 0) }, 0.14, Enum.EasingStyle.Quad)
        tween(gl,  { Position = UDim2.new(0, baseX + 2, 0, 4) }, 0.14, Enum.EasingStyle.Quad)
        task.wait(0.18)
    end

    task.wait(0.2)

    -- ➋ แสดง subtitle + separator
    tween(versionLabel, { TextTransparency = 0 }, 0.45)
    sep.Position = UDim2.new(0.5, 0, 0.44, 0)
    tween(sep, {
        Size     = UDim2.new(0, 240, 0, 1),
        Position = UDim2.new(0.5, -120, 0.44, 0),
    }, 0.5, Enum.EasingStyle.Quad)

    task.wait(0.6)

    -- ➌ Color cycle ตัวอักษร
    task.spawn(function()
        local ci = 1
        while running do
            for j, lbl in ipairs(letterLabels) do
                tween(lbl, { TextColor3 = LETTER_COLORS[((ci + j - 2) % #LETTER_COLORS) + 1] }, 0.9, Enum.EasingStyle.Sine)
            end
            ci = ci % #LETTER_COLORS + 1
            task.wait(1.6)
        end
    end)

    -- ➍ หลอดโหลด
    local STATUS_PHASES = {
        { limit = 25,  text = "กำลังเริ่มต้นระบบ...",   c1 = Color3.fromRGB(40,  100, 255), c2 = Color3.fromRGB(100, 190, 255) },
        { limit = 50,  text = "กำลังโหลดไฟล์...",      c1 = Color3.fromRGB(100, 40,  255), c2 = Color3.fromRGB(200, 100, 255) },
        { limit = 75,  text = "กำลังเตรียม UI...",      c1 = Color3.fromRGB(200, 40,  190), c2 = Color3.fromRGB(255, 100, 150) },
        { limit = 92,  text = "กำลังตรวจสอบระบบ...",   c1 = Color3.fromRGB(40,  180, 140), c2 = Color3.fromRGB(100, 255, 190) },
        { limit = 100, text = "เกือบเสร็จแล้ว! ✦",     c1 = Color3.fromRGB(100, 240, 100), c2 = Color3.fromRGB(200, 255, 140) },
    }

    local duration  = 4
    local startTime = tick()

    while tick() - startTime < duration do
        local elapsed  = tick() - startTime
        local progress = elapsed / duration
        local pct      = math.floor(progress * 100)

        fill.Size = UDim2.new(progress, 0, 1, 0)
        percentLabel.Text = pct .. "%"

        -- หา phase ปัจจุบัน
        for _, phase in ipairs(STATUS_PHASES) do
            if pct <= phase.limit then
                subText.Text = phase.text
                fillGrad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0,   phase.c1),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(
                        (phase.c1.R + phase.c2.R) * 127,
                        (phase.c1.G + phase.c2.G) * 127,
                        (phase.c1.B + phase.c2.B) * 127
                    )),
                    ColorSequenceKeypoint.new(1,   phase.c2),
                })
                break
            end
        end

        task.wait(0.03)
    end

    -- ➎ เสร็จ 100%
    fill.Size = UDim2.new(1, 0, 1, 0)
    percentLabel.Text    = "100%"
    subText.Text         = "โหลดสำเร็จ! ✓"
    subText.TextColor3   = Color3.fromRGB(100, 255, 180)

    -- ➏ Flash สีขาว
    local flash = Instance.new("Frame")
    flash.Size                  = UDim2.new(1, 0, 1, 0)
    flash.BackgroundColor3      = Color3.fromRGB(120, 190, 255)
    flash.BackgroundTransparency = 0.5
    flash.BorderSizePixel       = 0
    flash.ZIndex                = 300
    flash.Parent                = gui
    task.wait(0.08)
    tween(flash, { BackgroundTransparency = 1 }, 0.45)

    -- ➐ ตัวอักษร celebrate bounce
    for i, lbl in ipairs(letterLabels) do
        task.spawn(function()
            local baseX = (i - 1) * 100
            for _ = 1, 3 do
                tween(lbl, { Position = UDim2.new(0, baseX, 0, -14) }, 0.1)
                task.wait(0.1)
                tween(lbl, { Position = UDim2.new(0, baseX, 0, 0) }, 0.18, Enum.EasingStyle.Bounce)
                task.wait(0.22)
            end
        end)
        task.wait(0.07)
    end

    task.wait(0.9)
    running = false

    -- ➑ Wind-up: พื้นหลังอนิเมชั่นก่อนดูด

    -- Particles พุ่งเข้าศูนย์กลาง
    for _, info in ipairs(particles) do
        tween(info.frame, {
            Position              = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
        }, 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    end

    -- Background เปลี่ยนเป็นม่วงดำ (กาแลคซีถูกดูด)
    tween(loader, { BackgroundColor3 = Color3.fromRGB(12, 0, 30) }, 0.4)

    -- Gradient เร่งหมุน
    task.spawn(function()
        for _ = 1, 30 do
            bgGrad.Rotation = (bgGrad.Rotation + 7) % 360
            task.wait(0.016)
        end
    end)

    -- Rings เร่งหมุน x5
    task.spawn(function()
        for _ = 1, 30 do
            for _, r in ipairs(ringsGroup) do
                r.rot = r.rot + math.abs(r.speed) * 5
                r.frame.Rotation = r.rot
            end
            task.wait(0.016)
        end
    end)

    -- Glow blob บวมสว่างมาก (event horizon)
    tween(glowBlob, {
        Size                  = UDim2.new(0, 440, 0, 440),
        Position              = UDim2.new(0.5, -220, 0.5, -220),
        BackgroundColor3      = Color3.fromRGB(130, 0, 255),
        BackgroundTransparency = 0.68,
    }, 0.4, Enum.EasingStyle.Quad)

    -- Dark overlay คืบจากขอบเข้าหา
    local bhOverlay = Instance.new("Frame")
    bhOverlay.Size                  = UDim2.new(1, 0, 1, 0)
    bhOverlay.BackgroundColor3      = Color3.fromRGB(0, 0, 0)
    bhOverlay.BackgroundTransparency = 1
    bhOverlay.BorderSizePixel       = 0
    bhOverlay.ZIndex                = 150
    bhOverlay.Parent                = loader
    tween(bhOverlay, { BackgroundTransparency = 0.38 }, 0.45, Enum.EasingStyle.Quad)

    task.wait(0.5)

    -- ➒ Black hole suck-in: เซ็ต pivot กลางจอ แล้วหมุน+หดเข้าศูนย์กลาง
    loader.AnchorPoint = Vector2.new(0.5, 0.5)
    loader.Position    = UDim2.new(0.5, 0, 0.5, 0)

    -- ดูดวนเข้าหลุมดำ (Exponential In = เริ่มช้า → เร่งแรงช่วงท้ายเหมือนแรงโน้มถ่วง)
    tween(loader, {
        Size     = UDim2.new(0, 0, 0, 0),
        Rotation = -720,
    }, 0.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)
    task.wait(0.8)

    loader.Visible = false
    bhOverlay:Destroy()
    flash:Destroy()

    -- ============================================
    -- loadstring อัตโนมัติ 1 ครั้ง
    -- ============================================
     local ok, err = pcall(function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/kittidadaxmmikh-maker/ROMIC-HUB-V.1.0/refs/heads/main/NZF%20Ui.txt"))()
     end)
     if not ok then warn("[NZF] loadstring error:", err) end

    print("[NZF] ระบบพร้อมใช้งาน")
end

-- ============================================
-- เริ่มทำงาน
-- ============================================
task.wait(0.5)
startLoader()

print("==========================================")
print("    NZF LOADER UI  |  v2.0")
print("==========================================")
