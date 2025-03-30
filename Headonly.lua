local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

getgenv().HeadHitboxEnabled = false
getgenv().HitboxSize = Vector3.new(5, 5, 5) -- Размер хитбокса головы
getgenv().HitboxTransparency = 0.7 -- Прозрачность

-- Функция для изменения хитбокса
local function UpdateHitbox()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                if getgenv().HeadHitboxEnabled then
                    head.Size = getgenv().HitboxSize
                    head.Transparency = getgenv().HitboxTransparency
                    head.CanCollide = false
                    head.Material = Enum.Material.Neon
                else
                    head.Size = Vector3.new(1, 1, 1) -- Вернуть стандартный размер
                    head.Transparency = 0
                    head.Material = Enum.Material.SmoothPlastic
                end
            end
        end
    end
end

-- UI для управления
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Position = UDim2.new(0, 50, 0, 50)
ToggleButton.Size = UDim2.new(0, 100, 0, 50)
ToggleButton.Text = "Toggle Head Hitbox"
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ToggleButton.MouseButton1Click:Connect(function()
    getgenv().HeadHitboxEnabled = not getgenv().HeadHitboxEnabled
    UpdateHitbox()
    ToggleButton.Text = getgenv().HeadHitboxEnabled and "Hitbox: ON" or "Hitbox: OFF"
end)

-- Автообновление хитбоксов
while true do
    UpdateHitbox()
    wait(1)
end
