return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = { -- extend the plugin options
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false
        },
        follow_current_file = {
          enabled = true
        }
      }
    }
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts) -- override the options using lazy.nvim
      opts.section.header.val = { -- change the header section value
        " ▄▄▄· .▄▄ · ▄▄▄▄▄▄▄▄        ",
        "▐█ ▀█ ▐█ ▀. •██  ▀▄ █·▪     ",
        "▄█▀▀█ ▄▀▀▀█▄ ▐█.▪▐▀▀▄  ▄█▀▄ ",
        "▐█ ▪▐▌▐█▄▪▐█ ▐█▌·▐█•█▌▐█▌.▐▌",
        " ▀  ▀  ▀▀▀▀  ▀▀▀ .▀  ▀ ▀█▄▀▪",
        " ▐ ▄  ▌ ▐·▪  • ▌ ▄ ·.       ",
        "•█▌▐█▪█·█▌██ ·██ ▐███▪      ",
        "▐█▐▐▌▐█▐█•▐█·▐█ ▌▐▌▐█·      ",
        "██▐█▌ ███ ▐█▌██ ██▌▐█▌      ",
        "▀▀ █▪. ▀  ▀▀▀▀▀  █▪▀▀▀      ",
      }
    end,
  }
}
