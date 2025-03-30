-- // Настройки
getgenv().HitboxSize = Vector3.new(15, 15, 15) -- Размер хитбокса головы
getgenv().HitboxTransparency = 0.7 -- Прозрачность (0 = видно, 1 = невидимо)
getgenv().HitboxEnabled = false -- Включено/выключено (по умолчанию выключено)
getgenv().Keybind = Enum.KeyCode.K -- Кнопка включения/выключения

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- // Функция изменения хитбокса (добавление невидимого Part)
function ModifyHitbox(state)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local fakeHitbox = head:FindFirstChild("HitboxPart")

                if state then
                    -- Если хитбокс уже есть, обновляем
                    if not fakeHitbox then
                        fakeHitbox = Instance.new("Part")
                        fakeHitbox.Name = "HitboxPart"
                        fakeHitbox.Parent = head
                        fakeHitbox.CanCollide = false
                        fakeHitbox.Anchored = false
                        fakeHitbox.Transparency = getgenv().HitboxTransparency
                        fakeHitbox.Material = Enum.Material.Neon
                        fakeHitbox.Color = Color3.fromRGB(255, 0, 0)
                        fakeHitbox.Massless = true

                        -- Привязываем к голове
                        local weld = Instance.new("Weld")
                        weld.Part0 = head
                        weld.Part1 = fakeHitbox
                        weld.Parent = fakeHitbox
                    end

                    fakeHitbox.Size = getgenv().HitboxSize
                else
                    -- Удаляем хитбокс
                    if fakeHitbox then
                        fakeHitbox:Destroy()
                    end
                end
            end
        end
    end
end

-- // Автообновление при входе новых игроков
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if getgenv().HitboxEnabled then
            ModifyHitbox(true)
        end
    end)
end)

-- // Обработчик клавиш
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == getgenv().Keybind then
        getgenv().HitboxEnabled = not getgenv().HitboxEnabled
        ModifyHitbox(getgenv().HitboxEnabled)
        print("Хитбокс головы: " .. (getgenv().HitboxEnabled and "ВКЛ" or "ВЫКЛ"))
    end
end)

-- // Начальное применение хитбокса
ModifyHitbox(getgenv().HitboxEnabled)
