local is_suggestion_dirty = false
local suggested_word = nil

function set_suggested_word(word)
    if word == suggested_word then
        return
    end

    suggested_word = word
    -- print("Suggested word: " .. (suggested_word or "<nil>"))
end

local function get_word_before_cursor()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    if col == 0 then 
        return nil
    end

    local line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    local char_before_cursor = line:sub(col, col)
    if char_before_cursor == "."  then
        return nil
    end

    return line:match("(%w+)$") -- Capture alphanumerics at the end of the string
end

function invalidate_suggested_word()
    if not is_suggestion_dirty then
        return
    end

    is_suggestion_dirty = false

    local suggestion = vim.call('copilot#GetDisplayedSuggestion')
    local suggested_text = suggestion.text
    if #suggested_text == 0 then
        set_suggested_word(nil)
        return
    end

    local word_part_after, _ = suggested_text:match("^(%w+)")  -- ignores leading non-alphanumerics (i.e. the period)
    if word_part_after == nil  then
        set_suggested_word(nil)
        return
    end

    local word_part_before = get_word_before_cursor()
    set_suggested_word(word_part_before and word_part_before .. word_part_after or word_part_after)
end

function compare_copilot_suggestion(entry1, entry2)
    invalidate_suggested_word()

    if not suggested_word then
        return nil
    end

    local label1 = entry1.completion_item.label
    local label2 = entry2.completion_item.label
    if label1 == label2 then
        return nil
    end

    if label1 == suggested_word then
        return true
    elseif label2 == suggested_word then
        return false
    end

    return nil
end

vim.api.nvim_create_autocmd("TextChangedI", {
    pattern = "*", 
    callback = function()
        is_suggestion_dirty = true
    end
})

return compare_copilot_suggestion
