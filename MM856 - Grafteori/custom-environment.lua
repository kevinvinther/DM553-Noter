-- Initialize shared environment counter for all environments except proof
env_count = 0
chapter = 1 -- Manually set or dynamically update based on your document structure

function Div(el)
	-- List of environments to share a unified counter
	local numbered_envs = { "theorem", "lemma", "proposition", "corollary" }

	if contains(el.classes, numbered_envs) then
		-- Increment the unified counter for numbered environments
		env_count = env_count + 1

		-- Extract the title if it exists
		local title = ""
		if el.attributes.label then
			title = el.attributes.label
		elseif el.attributes.title then
			title = el.attributes.title
		end

		-- Format the environment number as "1.13" (using chapter number)
		local env_number = chapter .. "." .. env_count

		-- Construct the formatted header with environment number and optional title
		local header_text = "**" .. el.classes[1]:gsub("^%l", string.upper) .. " " .. env_number .. "**"
		if title ~= "" then
			header_text = header_text .. " *(" .. title .. ")*"
		end
		header_text = header_text .. ": "

		-- Create a new header paragraph
		local header = pandoc.Para({ pandoc.RawInline("markdown", header_text) })

		-- Return the header and content as separate blocks, removing the <div> wrapper
		return { header, table.unpack(el.content) }
	elseif el.classes:includes("proof") then
		-- Handle proofs separately without numbering
		local header = pandoc.Para({ pandoc.Strong(pandoc.Str("Proof: ")) })
		return { header, table.unpack(el.content) }
	end
end

-- Helper function to check if a class is in the list of numbered environments
function contains(class_list, items)
	for _, item in ipairs(items) do
		if class_list:includes(item) then
			return true
		end
	end
	return false
end
