-- Vimspector
vim.cmd([[
nmap <F5> <cmd>call vimspector#Launch()<cr>
nmap <F10> <cmd>call vimspector#StepOver()<cr>
nmap <F11> <cmd>call vimspector#StepInto()<cr>
nmap <F12> <cmd>call vimspector#StepOut()<cr>
]])
vim.keymap.set('n', 'Db', ':call vimspector#ToggleBreakpoint()<cr>')
vim.keymap.set('n', 'Dw', ':call vimspector#AddWatch()<cr>')
vim.keymap.set('n', 'De', ':call vimspector#Evaluate()<cr>')

