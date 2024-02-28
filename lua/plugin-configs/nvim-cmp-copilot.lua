local function get_word_before_cursor()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    if col == 0 then 
        return nil
    end

    local line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    local char_before_cursor = line:sub(col, col)
    if(char_before_cursor == ".") then
        return nil
    end

    return line:match("(%w+)$") -- Capture alphanumerics at the end of the string
end

function compare_copilot_suggestion(entry1, entry2)
    -- TODO: Cache the word before & after the cursor as well as the copilot suggestion
    print("lelele")

    local suggestion = vim.call('copilot#GetDisplayedSuggestion')
    local suggested_text = suggestion.text
    if #suggested_text == 0 then
        return nil
    end

    local word_part_after, _ = suggested_text:match("^(%w+)")  -- ignores leading non-alphanumerics (i.e. any period)
    if(word_part_after == nil) then
      return nil
    end

    local word_part_before = get_word_before_cursor() or ""
    local suggested_word = word_part_before .. word_part_after
    if entry1.completion_item.label == suggested_word then
        return true
    elseif entry2.completion_item.label == suggested_word then
        return false
    end

    return nil
end

return compare_copilot_suggestion
