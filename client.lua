local camHandle
local selectedEntity
function createCam() 
    local pedId = PlayerPedId()
    local coords = GetEntityCoords(pedId)
    camHandle = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
   
    SetCamRot(camHandle, vector3(-90, 0, 0.0), 2)
    SetCamFov(camHandle, 50.0)
    SetCamNearClip(camHandle, GetFinalRenderedCamNearClip())
    SetCamFarClip(camHandle, GetFinalRenderedCamFarClip())
    RenderScriptCams(true, false, 0, 0, 0)
    exports['screen-to-world']:setCamHandle(camHandle)
    AttachCamToEntity(camHandle, pedId, 0.0, 0.0, 30.0, false)
end
function doStuff()
    Citizen.CreateThread(function()
        while true do
            if (IsControlJustPressed(0, 29)) then
                if (selectedEntity == 0) then
                    selectedEntity = exports['screen-to-world']:getEntityAtCursor(-1)
                else
                    selectedEntity = 0
                end
               
            elseif (selectedEntity ~= 0) then
                local endCoords = exports['screen-to-world']:getPointAtCursor(selectedEntity)
                SetEntityCoords(selectedEntity, endCoords.x, endCoords.y, endCoords.z)
            end
            Wait(0)
        end
    end)
end

RegisterCommand("createCam", createCam, false)
RegisterCommand("doStuff", doStuff, false)