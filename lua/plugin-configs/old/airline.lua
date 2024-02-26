local g = vim.g
-- g.airline_theme = 'gruvbox'

-- Show only file names in tabs along with the tab number
g['airline#extensions#tabline#enabled'] = 1
g['airline#extensions#tabline#fnamemod'] = ':t'
g['airline#extensions#tabline#tab_nr_type'] = 1 -- tab number (0 = total splits)
