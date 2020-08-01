function init(args)
  entity.setInteractive(true)
end

function onInteraction(args)
  if storage.state == nil then
    storage.state = false
  end
  storage.state = not storage.state
  local sourceId = args["sourceId"]
  local queryOptions = { ["callScript"]="setInteractId", ["callScriptArgs"]=vlist({sourceId}) }
  local storageUnits = world.objectQuery(entity.position(), 80, queryOptions)
  for k,v in pairs(storageUnits) do
    world.callScriptedEntity(v, "setInteractId", sourceId)
    world.callScriptedEntity(v, "tryToggleProtection", storage.state)
  end
  entity.setAnimationState("switchState", tostring(storage.state))
end
