return {
    git_diff = function(_)
        local diff = vim.system(
            { "git", "diff", "--no-ext-diff", "--staged", "--unified=1" },
            { text = true }
        )
            :wait().stdout or ""

        if diff == "" then
            return "No staged changes."
        end

        -- Limit the number of lines in the diff to prevent overwhelming the model.
        local max_lines = 350

        local lines = vim.split(diff, "\n")

        if #lines <= max_lines then
            return diff
        end

        local result = {}
        local count = 0
        local skipped = 0
        local truncating = false

        for _, line in ipairs(lines) do
            if line:match("^diff %-%-git ") and truncating then
                skipped = skipped + 1
            elseif not truncating then
                table.insert(result, line)
                count = count + 1
                if count >= max_lines then
                    truncating = true
                end
            end
        end

        if skipped > 0 then
            table.insert(
                result,
                string.format(
                    "\n-- [%d file(s) omitted. Run `git diff --staged --stat` for full picture]",
                    skipped
                )
            )
        end

        return table.concat(result, "\n")
    end,
}
