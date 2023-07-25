--[[
    AUTHOR: Joordih - joordih.me 2023 © All rights reserved
    GITHUB: https://github.com/HarpyLMAO
    CREATED AT: 24/07/2023
    PROJECT: koid-core | KoidCore.lua
--]]

ESX = exports['es_extended']:getSharedObject()

KoidCore = {}

function KoidCore:getSharedObject()
  return KoidCore
end

function KoidCore:switch(value, cases)
  for _, c in pairs(cases) do
    if c[1] == value then
      return c[2]()
    end
  end
end

setmetatable(KoidCore, { __index = KoidCore })
exports('getSharedObject', KoidCore.getSharedObject)