getgenv().HitboxSize = Vector3.new(15, 15, 15) -- Размер хитбокса
getgenv().HitboxTransparency = 0.9 -- Прозрачность хитбокса
getgenv().HitboxStatus = false -- Включение/выключение хитбокса
getgenv().TeamCheck = false -- Проверка команды

game:GetService('RunService').RenderStepped:Connect(function()
    if getgenv().HitboxStatus then
        for _, player in pairs(game:GetService('Players'):GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if not getgenv().TeamCheck or player.Team ~= game.Players.LocalPlayer.Team then
                    pcall(function()
                        local head = player.Character and player.Character:FindFirstChild("Head")
                        if head then
                            head.Size = getgenv().HitboxSize
                            head.Transparency = getgenv().HitboxTransparency
                            head.BrickColor = BrickColor.new("Really black")
                            head.Material = "Neon"
                            head.CanCollide = false
                        end
                    end)
                end
            end
        end
    else
        for _, player in pairs(game:GetService('Players'):GetPlayers()) do
            pcall(function()
                local head = player.Character and player.Character:FindFirstChild("Head")
                if head then
                    head.Size = Vector3.new(2, 1, 1) -- Обычный размер головы
                    head.Transparency = 0
                    head.BrickColor = BrickColor.new("Medium stone grey")
                    head.Material = "Plastic"
                    head.CanCollide = true
                end
            end)
        end
    end
end)
