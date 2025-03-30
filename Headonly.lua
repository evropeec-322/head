local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Enabled = false  -- Переключатель включения/выключения
local HitboxSize = Vector3.new(5, 5, 5)  -- Размер хитбокса головы

-- Функция для изменения хитбоксов
local function SetHitbox(state)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            if state then
                head.Size = HitboxSize
                head.Transparency = 0.5
                head.Material = Enum.Material.Neon
                head.CanCollide = false
            else
                head.Size = Vector3.new(2, 1, 1)  -- Обычный размер головы
                head.Transparency = 0
                head.Material = Enum.Material.SmoothPlastic
                head.CanCollide = false
            end
        end
    end
end

-- UI для включения/выключения хитбоксов
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 100, 0, 50)
ToggleButton.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleButton.Text = "Hitbox: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 20
ToggleButton.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    if Enabled then
        ToggleButton.Text = "Hitbox: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    else
        ToggleButton.Text = "Hitbox: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
    SetHitbox(Enabled)
end)

-- Обновление хитбоксов при появлении новых игроков
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1) -- Даем время загрузиться персонажу
        if Enabled then
            SetHitbox(true)
        end
    end)
end)

