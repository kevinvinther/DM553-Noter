-- callout_filter.lua

function Div(el)
	if el.classes:includes("thm") then
		-- Initialize variables
		local theoremNumber = ""
		local theoremName = ""
		local content = el.content

		-- Extract the first paragraph, which contains the theorem heading
		local firstPara = content[1]
		if firstPara and firstPara.t == "Para" then
			local inlines = firstPara.content
			-- Convert inlines to plain text
			local headingText = pandoc.utils.stringify(inlines)
			-- Extract theorem number and name using pattern matching
			theoremNumber, theoremName = headingText:match("%*%*(.-)%*%* %((.-)%)%.?")
			-- Remove the first paragraph from content
			table.remove(content, 1)
		end

		-- Convert the rest of the content to markdown
		local contentMarkdown = pandoc.write(pandoc.Pandoc(content), "markdown")
		-- Add '> ' at the beginning of each line for callout formatting
		contentMarkdown = contentMarkdown:gsub("([^\n]+)", "> %1")

		-- Construct the callout header
		local calloutHeader = string.format("> [!thm] **%s** %s", theoremNumber or "", theoremName or "")

		-- Combine the callout header and content
		local calloutMarkdown = calloutHeader .. "\n" .. contentMarkdown

		-- Return the new content as a RawBlock
		return pandoc.RawBlock("markdown", calloutMarkdown)
	end
end
