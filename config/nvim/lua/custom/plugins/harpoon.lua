return {
  "ThePrimeagen/harpoon",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function ()
    require('telescope').load_extension "harpoon"
  end
}
