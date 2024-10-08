-- theorem_extractor.lua
-- Pandoc Lua filter to convert LaTeX theorem environments to formatted Markdown

-- Initialize a counter for theorems
local theorem_counter = 0

-- Function to process RawBlock elements
function RawBlock(el)
	if el.format == "latex" then
		local text = el.text

		-- Pattern to match \begin{theorem}[Title] ... \end{theorem}
		local theorem_with_title_pattern = "\\\\begin{theorem}%s*%[([^%]]+)%]%s*\n([%s%S]-)\\\\end{theorem}"
		-- Pattern to match \begin{theorem} ... \end{theorem} without a title
		local theorem_no_title_pattern = "\\\\begin{theorem}%s*\n([%s%S]-)\\\\end{theorem}"

		-- Attempt to match theorem with title
		local title, content = text:match(theorem_with_title_pattern)
		if title and content then
			theorem_counter = theorem_counter + 1
			-- Trim leading and trailing whitespace from content
			content = content:gsub("^%s+", ""):gsub("%s+$", "")
			-- Format the theorem in Markdown
			local markdown = string.format("**Theorem %d** (*%s*):\n\n%s", theorem_counter, title, content)
			return pandoc.RawBlock("markdown", markdown)
		else
			-- Attempt to match theorem without title
			local content_only = text:match(theorem_no_title_pattern)
			if content_only then
				theorem_counter = theorem_counter + 1
				-- Trim leading and trailing whitespace from content
				content_only = content_only:gsub("^%s+", ""):gsub("%s+$", "")
				-- Format the theorem in Markdown without a title
				local markdown = string.format("**Theorem %d**:\n\n%s", theorem_counter, content_only)
				return pandoc.RawBlock("markdown", markdown)
			end
		end
	end
end
