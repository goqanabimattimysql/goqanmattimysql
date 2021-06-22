local isNuiActive = false

function setNuiActive(booleanOrNil)
  local boolean = true
  if booleanOrNil ~= nil then boolean = booleanOrNil end
  if boolean ~= isNuiActive then
    if boolean then TriggerServerEvent('goqanabimattim:request-data') end
    isNuiActive = boolean
    SendNUIMessage({ type = 'onToggleShow' })
    SetNuiFocus(boolean, boolean)
  end
end

RegisterCommand('mysql', function()
  setNuiActive()
end, true)

RegisterNUICallback('close-explorer', function()
  setNuiActive(false)
end)

CreateThread(function()
  if isNuiActive then TriggerServerEvent('goqanabimattim:request-data') end
  Wait(300000)
end)

function isArray(t)
  local i = 0
  for _ in pairs(t) do
      i = i + 1
      if t[i] == nil then return false end
  end
  return true
end

function map(t, callback)
  local newTable = {}
  for i = 1, #t do
    newTable[i] = callback(t[i], i)
  end
  return newTable
end

function filter(t, callback)
  local newTable = {}
  for i = 1, #t do
    if callback(t[i], i) then
      table.insert(newTable, t[i])
    end
  end
  return newTable
end

RegisterNetEvent('goqanabimattim:update-resource-data')
AddEventHandler('goqanabimattim:update-resource-data', function (resourceData)
  local arrayToSortAndMap = {}
  for resource, data in pairs(resourceData) do
    table.insert(arrayToSortAndMap, {
      resource = resource,
      queryTime = data.totalExecutionTime,
      count = data.queryCount,
    })
  end
  if #arrayToSortAndMap > 0 then
    table.sort(arrayToSortAndMap, function(a, b) return a.queryTime > b.queryTime end)
    local len = #arrayToSortAndMap
    arrayToSortAndMap = filter(arrayToSortAndMap, function(_, index) return index > len - 30 end)
    table.sort(arrayToSortAndMap, function(a, b) return a.resource:upper() > b.resource:upper() end)
    SendNUIMessage({
      type = 'onResourceLabels',
      resourceLabels = map(arrayToSortAndMap, function(el) return el.resource end),
    })
    SendNUIMessage({
      type = 'onResourceData',
      resourceData = {
        { data = map(arrayToSortAndMap, function(el) return el.queryTime end) },
        { data = map(arrayToSortAndMap, function(el) if el.count > 0 then return el.queryTime / el.count end return 0 end) },
        { data = map(arrayToSortAndMap, function(el) return el.count end) },
      },
    })
  end
end)

RegisterNetEvent('goqanabimattim:update-time-data')
AddEventHandler('goqanabimattim:update-time-data', function (timeData)
  local timeArray = {}
  if isArray(timeData) then
    local len = #timeData
    timeArray = filter(timeData, function(_, index) return index > len - 30 end)
  end
  if #timeArray > 0 then
    SendNUIMessage({
      type = 'onTimeData',
      timeData = {
        { data = map(timeArray, function(el) return el.totalExecutionTime end) },
        { data = map(timeArray, function(el) if el.queryCount > 0 then return el.totalExecutionTime / el.queryCount end return 0 end) },
        { data = map(timeArray, function(el) return el.queryCount end) },
      }
    })
  end
end)

RegisterNetEvent('goqanabimattim:update-slow-queries')
AddEventHandler('goqanabimattim:update-slow-queries', function(slowQueryData)
  local slowQueries = slowQueryData
  for i = 1, #slowQueries do
    slowQueries[i].queryTime = math.floor(slowQueries[i].queryTime * 100 + 0.5) / 100
  end
  SendNUIMessage({
    type = 'onSlowQueryData',
    slowQueries = slowQueries,
  });
end)

RegisterNetEvent('goqanabimattim:update-status')
AddEventHandler('goqanabimattim:update-status', function(statusData)
  SendNUIMessage({
    type = 'onStatusData',
    status = statusData,
  });
end)

RegisterNetEvent('goqanabimattim:update-variables')
AddEventHandler('goqanabimattim:update-variables', function(variableData)
  SendNUIMessage({
    type = 'onVariableData',
    variables = variableData,
  });
end)

RegisterNUICallback('request-server-status', function()
  TriggerServerEvent('goqanabimattim:request-server-status')
end)

RegisterNetEvent('goqanabimattim:get-table-schema')
AddEventHandler('goqanabimattim:get-table-schema', function(tableName, schema)
  SendNUIMessage({
    type = 'onTableSchema',
    tableName = tableName,
    schema = schema,
  });
end)

RegisterNUICallback('request-table-schema', function(tableName)
  TriggerServerEvent('goqanabimattim:request-table-schema', tableName)
end)
