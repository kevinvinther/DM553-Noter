-- callout_filter.lua

function Div(el)
	if el.classes:includes("theorem") then
		local content = el.content
		local title = ""

		-- Check if the first element is a Para containing the title
		if #content > 0 and content[1].t == "Para" then
			local first_para = content[1]
			local inlines = first_para.content
			if #inlines > 0 and inlines[1].t == "Strong" then
				-- Extract the title from the Strong element
				title = pandoc.utils.stringify(inlines[1].content)
				-- Remove the title paragraph from content
				table.remove(content, 1)
			end
		end

		-- Convert the rest of the content to markdown
		local contentMarkdown = pandoc.write(pandoc.Pandoc(content), "markdown")
		-- Add '> ' at the beginning of each line for callout formatting
		contentMarkdown = contentMarkdown:gsub("([^\n]+)", "> %1")

		-- Construct the callout header
		local calloutHeader = string.format("> [!theorem] **%s**", title)

		-- Combine the callout header and content
		local calloutMarkdown = calloutHeader .. "\n" .. contentMarkdown

		-- Return the new content as a RawBlock
		return pandoc.RawBlock("markdown", calloutMarkdown)
	end
end
