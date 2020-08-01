
function init(args)
  entity.setInteractive(true)
end

function main()
  if storage.protectionEnabled then
    if not storage.hiding then
	  storage.items = world.containerTakeAll(entity.id())
	  storage.hiding = true
	end
	local toDrop = world.containerTakeAll(entity.id())
	for k,v in pairs(toDrop) do
	  world.spawnItem(v["name"], entity.position(), v["count"], v["data"])
	end
  end

  if not storage.protectionEnabled  then
    if storage.hiding then
	  addItems()
	storage.hiding = false
	end

	local containerItems = world.containerItems(entity.id())
	for k,v in pairs(containerItems) do
	  if v["name"] == "containerbreaker" then
	    world.breakObject(entity.id(), false)
	  end
	end
  end
end

function setInteractId(id)
  if id ~= nil then
    storage.interactId = world.entityUuid(id)
  end
  return true
end

function tryToggleProtection(flag)
  if storage.ownerId == nil then
    storage.ownerId = storage.interactId
  end

  if storage.ownerId == storage.interactId and storage.ownerId ~= nil then
    storage.protectionEnabled = flag
  end
end

function getItems()
  local containerSize = world.containerSize(entity.id())
  storage.items = { }
  for position = 0, containerSize do
    local currentItem = world.containerItemAt(entity.id(), position)
    if currentItem ~= nil then
	  table.insert(storage.items, currentItem)
	else
	  return
	end
  end
end

function addItems()
  for k,v in pairs(storage.items) do
    world.containerAddItems(entity.id(), v)
  end
end
