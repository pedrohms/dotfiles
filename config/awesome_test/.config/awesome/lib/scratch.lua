local client = client
local awful = require("awful")
local ruled = require("ruled")
local util = require("awful.util")

local scratch = {}
local defaultRule = {
  rule = { class = "scratch" },
  properties = { floating = true, placement = awful.placement.centered }
}

-- Turn on this scratch window client (add current tag to window's tags,
-- then set focus to the window)
local function turn_on(c)
  local current_tag = awful.tag.selected(c.screen)
  local ctags = { current_tag }
  for _, tag in pairs(c:tags()) do
    if tag ~= current_tag then
      table.insert(ctags, tag)
    end
  end
  c:tags(ctags)
  c:raise()
  client.focus = c
end

-- Turn off this scratch window client (remove current tag from window's tags)
local function turn_off(c)
  local current_tag = awful.tag.selected(c.screen)
  local ctags = {}
  for _, tag in pairs(c:tags()) do
    if tag ~= current_tag then
      table.insert(ctags, tag)
    end
  end
  c:tags(ctags)
end

function scratch.raise(cmd, rule)
  local current_rule = rule or defaultRule
  -- local function matcher(c) return ruled.client.match(c, current_rule) end
  local function matcher(c) return c.instance == current_rule.rule.class end

  -- logic mostly copied form awful.client.run_or_raise, except we don't want
  -- to change to or merge with scratchpad tag, just show the window
  local clients = client.get()
  local findex  = util.table.hasitem(clients, client.focus) or 1
  local start   = util.cycle(#clients, findex + 1)

  for c in awful.client.iterate(matcher, start) do
    turn_on(c)
    return
  end

  -- client not found, spawn it
  util.spawn(cmd)
end

function scratch.toggle(cmd, rule)
  local current_rule = rule or defaultRule
  -- if client.focus and ruled.client.match(client.focus, current_rule) then
  if client.focus and client.focus.instance == current_rule.rule.class then
    turn_off(client.focus)
  else
    scratch.raise(cmd, current_rule)
  end
end

return scratch
