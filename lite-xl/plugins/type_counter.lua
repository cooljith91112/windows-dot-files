-- mod-version:2 -- lite-xl 2.0
-- Name  		: Type Counter
-- AUTHOR		: Indrajith K L
-- DESCRIPTION	: A simple counter to track total character typed

local core = require("core")
local command = require("core.command")
local StatusView = require "core.statusview"
local style = require "core.style"
local RootView = require("core.rootview")
local DocView = require("core.docview")
local scanrate = 1
local counter = 0

local on_event = core.on_event

core.on_event = function(type, ...)
	local res = on_event(type, ...)
	if type == "textinput" then
		counter = counter + 1
	end
	return res
end

local get_items = StatusView.get_items

function StatusView:get_items()
  local left, right = get_items(self)
  local t = {
    style.dim,
    self.separator,
    style.dim and style.counter_color,
    "Type Counter : "..counter,
  }
  for _, item in ipairs(t) do
    table.insert(right, item)
  end

  return left, right
end

