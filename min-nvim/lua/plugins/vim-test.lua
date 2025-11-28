return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux"
  },
  cmd = {
    "TestNearest",
  },
  config = function()
    vim.cmd("let test#strategy = 'vimux'")
  end
}
