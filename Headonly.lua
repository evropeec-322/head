-- // Настройки
getgenv().HitboxSize = Vector3.new(15, 15, 15) -- Размер хитбокса головы
getgenv().HitboxTransparency = 0.5 -- Прозрачность (0 = видно, 1 = невидимо)
getgenv().HitboxEnabled = false -- Включено/выключено (по умолчанию выключено)
getgenv().Keybind = Enum.KeyCode.K -- Кнопка включения/выключения

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- // Функция изменения хитбокса
function ModifyHitbox(state)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                if state then
                    -- Увеличиваем сам хитбокс головы
                    head.Size = getgenv().HitboxSize
                    head.Transparency = getgenv().HitboxTransparency
                    head.Material = Enum.Material.Neon
                    head.Color = Color3.fromRGB(255, 0, 0)
                    head.CanCollide = false -- Отключаем столкновения
                    head.Massless = true -- Делаем его невесомым
                else
                    -- Возвращаем стандартные параметры
                    head.Size = Vector3.new(2, 1, 1) -- Стандартный размер головы
                    head.Transparency = 0
                    head.Material = Enum.Material.SmoothPlastic
                    head.Color = Color3.fromRGB(255, 255, 255)
                end
            end
        end
    end
end

-- // Автообновление при появлении новых игроков
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if getgenv().HitboxEnabled then
            ModifyHitbox(true)
        end
    end)
end)

-- // Обработчик клавиш (переключение хитбокса)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == getgenv().Keybind then
        getgenv().HitboxEnabled = not getgenv().HitboxEnabled
        ModifyHitbox(getgenv().HitboxEnabled)
        print("Хитбокс головы: " .. (getgenv().HitboxEnabled and "ВКЛ" or "ВЫКЛ"))
    end
end)

-- // Применяем хитбокс при запуске
ModifyHitbox(getgenv().HitboxEnabled)
