local is_ok, nvim_tree = pcall(require, "nvim-tree")
if not is_ok then
    return
end

nvim_tree.setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
