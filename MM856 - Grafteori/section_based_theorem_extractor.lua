-- section_based_theorem_extractor.lua
-- Pandoc Lua filter to reset theorem counters based on section headers

local theorem_counter = 0
local theorem_envs = { "theorem", "lemma", "proposition", "corollary" }

-- Function to check if a value is in a table
local function is_in_table(tbl, val)
	for _, v in ipairs(tbl) do
		if v == val then
			return true
		end
	end
	return false
end

-- Function to process Headers
function Header(el)
	if el.level == 1 then
		theorem_counter = 0
	end
end

-- Function to process RawBlock elements
function RawBlock(el)
	if el.format == "latex" then
		local text = el.text

		for _, env in ipairs(theorem_envs) do
			local with_title_pattern =
				string.format("\\\\begin{%s}%%s*%%[([^%%]]+)%%]%%s*\n([%%s%%S]-)\\\\end{%s}", env, env)
			local no_title_pattern = string.format("\\\\begin{%s}%%s*\n([%%s%%S]-)\\\\end{%s}", env, env)

			local title, content = text:match(with_title_pattern)
			if title and content then
				theorem_counter = theorem_counter + 1
				content = content:gsub("^%s+", ""):gsub("%s+$", "")
				local env_name = env:gsub("^%l", string.upper)
				local markdown = string.format("**%s %d** (*%s*):\n\n%s", env_name, theorem_counter, title, content)
				return pandoc.RawBlock("markdown", markdown)
			else
				local content_only = text:match(no_title_pattern)
				if content_only then
					theorem_counter = theorem_counter + 1
					content_only = content_only:gsub("^%s+", ""):gsub("%s+$", "")
					local env_name = env:gsub("^%l", string.upper)
					local markdown = string.format("**%s %d**:\n\n%s", env_name, theorem_counter, content_only)
					return pandoc.RawBlock("markdown", markdown)
				end
			end
		end
	end
end
