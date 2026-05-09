return {
  -- discord presence
  -- for the RPC client to be connected from a snap discord, run this command
  -- on Ubuntu :
  -- $ ln -s /run/user/1000/snap.discord/discord-ipc-0 $XDG_RUNTIME_DIR/discord-ipc-0
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence").setup({
        -- log_level = "debug",

        -- mention all the repositories you don't want to expose the work on
        blacklist = {},

        -- customisation
        neovim_image_text = "L'Éditeur Unique pour les gouverner tous", -- Text displayed when hovered over the Neovim image
        main_image = "file", -- Main image display (either "neovim" or "file")

        -- Rich Presence text options
        editing_text = "Modifie %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
        file_explorer_text = "Se balade dans le %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
        git_commit_text = "En train de commit", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
        plugin_manager_text = "Gère ses plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
        reading_text = "Lis %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
        workspace_text = "Travaille sur %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
        line_number_text = "Ligne %s sur %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
      })
    end,
  },

  -- lorem ipsum snippet
  {
    "derektata/lorem.nvim",
    config = function()
      require("lorem").opts({
        sentenceLength = "medium",
        comma_chance = 0.2,
        max_commas_per_sentence = 2,
      })
    end,
  },

  -- git diff view
  {
    "sindrets/diffview.nvim",
  },
}
