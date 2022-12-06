local bling_ok, bling = pcall(require, "bling")

if not bling_ok then
  return nil
end

Term_scratch = bling.module.scratchpad {
    command = "alacritty --class termscratch -e tmux",           -- How to spawn the scratchpad
    rule = { instance = "termscratch" },                     -- The rule that the scratchpad will be searched by
    sticky = true,                                    -- Whether the scratchpad should be sticky
    autoclose = true,                                 -- Whether it should hide itself when losing focus
    floating = true,                                  -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
    geometry = {x=360, y=90, height=900, width=1200}, -- The geometry in a floating state
    dont_focus_before_close  = false                 -- When set to true, the scratchpad will be closed by the toggle function regardless of whether its focused or not. When set to false, the toggle function will first bring the scratchpad into focus and only close it on a second call
}
