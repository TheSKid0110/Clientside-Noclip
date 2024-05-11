local view = {} 
local isPressed = nil
local counter = 0
local FirstTime = true


hook.Add("Think","Counter",function()
    if isPressed then
        counter = counter + 0.1
    else
        counter = 0
    end
end)

hook.Add("PlayerButtonDown","CheckZ",function(ply, key)
    if key == KEY_Z then
        if isPressed then
            isPressed = false
        else
            isPressed = true
            FirstTime = true

        end
    end
end)

hook.Add("CalcView", "freelook", function(ply, pos, angles, fov)
    if isPressed then
        if FirstTime then
            view.origin = pos
            FirstTime = false
        end
        if input.IsKeyDown(KEY_W) then
            view.origin = view.origin + angles:Forward() * counter
            
        end
        view.angles = angles
        view.fov = fov
        view.drawviewer = true
        return view
    end
end)

hook.Add("CreateMove", "freelook", function(ucmd)
    if isPressed then
        ucmd:SetForwardMove(0)
        ucmd:SetSideMove(0)
        ucmd:SetUpMove(0)
    end
end)
print("cl_noclip.lua loaded!")

