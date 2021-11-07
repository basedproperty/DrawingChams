local Lib3d = loadstring(game:HttpGet("https://raw.githubusercontent.com/Blissful4992/ESPs/main/3D%20Drawing%20Api.lua"))()
getgenv().DrawingDump = {}
NoTeamCheck = true
Filled = false
Transparency = 1
Color = Color3.fromRGB(255, 135, 135)
game:GetService("RunService").RenderStepped:connect(function()
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Character and (v.Team ~= game.Players.LocalPlayer.Team or NoTeamCheck) and v ~= game.Players.LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") then
            for i2,v2 in pairs(v.Character:GetChildren()) do
                if v2:IsA("BasePart")  then
                    if not DrawingDump[v.Name] then
                        DrawingDump[v.Name]  = {}
                    end
                    if DrawingDump[v.Name][v2.Name] then
                        Limb = DrawingDump[v.Name][v2.Name]
                        Limb.Position = v2.Position
                        Limb.Size = v2.Size - Vector3.new(0.5,0.5,0.5)
                        Limb.Rotation = v2.Rotation
                    else
                        NewLimb = Lib3d:New3DCube()
                        NewLimb.Visible = true
                        NewLimb.Transparency = Transparency
                        NewLimb.Color = Color
                        NewLimb.Filled = Filled
                        NewLimb.Position = v2.Position
                        NewLimb.Size = v2.Size - Vector3.new(0.5,0.5,0.5)
                        DrawingDump[v.Name][v2.Name] = NewLimb
                    end
                end
            end
        elseif DrawingDump[v.Name] then
            for i2,v2 in pairs(DrawingDump[v.Name]) do
                v2:Remove()
                v2 = nil
            end
            DrawingDump[v.Name] = nil
        end
    end
end)

game.Players.PlayerRemoving:connect(function(plr)
    if DrawingDump[plr.Name] then
        for i,v in pairs(DrawingDump[plr.Name]) do
            v:Remove()
            v = nil
        end
    end
    DrawingDump[plr.Name] = nil
end)