math.randomseed(tick())

script.Parent.Touched:Connect(function(hit)
    if hit.Parent:FindFirstChild("Humanoid") then
        script.Disabled = true
        local player = hit.Parent.Name
        local num = math.random(0,100)
        if num < 5 then
            local item = game.ServerStorage.XM1404:Clone()
            item.Parent = game.Players[player].Backpack
        elseif num < 10 then
            local item = game.ServerStorage.MP5:Clone()
            item.Parent = game.Players[player].Backpack
        end
        -- Add more reward logic here
        script.Parent:Destroy()
    end
end)
