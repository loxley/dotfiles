if not vim.g.neovide then
  return {} -- do nothing if not in a Neovide session
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = { -- configure vim.opt options
        -- configure font
        -- guifont = "SauceCodePro Nerd Font Mono:h10",
        guifont = "JetBrainsMono Nerd Font Mono:h10",
        -- line spacing
        linespace = 0,
        guicursor = 'n-v-c-sm:block,ci-ve:block,r-cr-o:hor20,i:block-blinkwait700-blinkoff700-blinkon250-Cursor/lCursor',
      },
      g = { -- configure vim.g variables
        -- configure scaling
        neovide_scale_factor = 1.0,
        -- configure padding
        neovide_padding_top = 2,
        neovide_padding_bottom = 2,
        neovide_padding_right = 2,
        neovide_padding_left = 2,
        -- cursor vfx mode
        neovide_cursor_vfx_mode = "railgun",
        -- hide cursor when typing
        neovide_hide_mouse_when_typing = true,
        -- smooth cursor blink
        neovide_cursor_smooth_blink = true,
      },
    },
  },
}
