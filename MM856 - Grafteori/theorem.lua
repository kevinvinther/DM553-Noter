-- theorem.lua
-- Pandoc Lua filter to convert LaTeX theorem and proof environments to formatted Markdown sections with horizontal rules

-- List of LaTeX commands to exclude from Markdown output
local excluded_commands = {
	"\\usepackage",
	"\\newtheorem",
}

-- List of theorem-like classes to process
local theorem_classes = { "theorem", "lemma", "proposition", "conjecture", "proof" }

-- Function to check if a string starts with a given substring
local function starts_with(str, start)
	return str:sub(1, #start) == start
end

-- Helper function to check if a class exists in the classes table
local function has_class(classes, cls_list)
	for _, c in ipairs(classes) do
		for _, cls in ipairs(cls_list) do
			if c == cls then
				return cls -- Return the matched class
			end
		end
	end
	return nil
end

-- Function to process RawBlock elements and exclude unwanted LaTeX commands
function RawBlock(el)
	if el.format == "latex" then
		local text = el.text
		for _, cmd in ipairs(excluded_commands) do
			if starts_with(text, cmd) then
				print("Excluding LaTeX command:", text)
				return {} -- Remove this block from the output
			end
		end
	end
end

-- Function to process Div elements with classes in theorem_classes
function Div(el)
	local matched_class = has_class(el.classes, theorem_classes)

	if matched_class then
		if #el.content > 0 then
			local first_block = el.content[1]

			if first_block.t == "Para" then
				local para = first_block
				local para_text = pandoc.utils.stringify(para)
				print(string.format("Div content Para text (%s):", matched_class), para_text)

				-- Initialize variables for header and content
				local header_para = {}
				local content_para = {}

				if matched_class == "proof" then
					-- Handle Proof environment

					-- Attempt to match "Proof X. Remaining text" or "Proof. Remaining text"
					-- Adjust based on how proofs are numbered in your LaTeX document
					local proof_num, remaining_text = para_text:match("^Proof%s+([^%.]*)%.%s*(.*)")

					if proof_num then
						print(string.format("Matched with number: Proof %s", proof_num))
						-- Create the formatted header with proof number
						header_para = pandoc.Para({
							pandoc.Strong({ pandoc.Str("Proof " .. proof_num) }),
							pandoc.Str(":"),
						})
					else
						-- Attempt to match "Proof. Remaining text" without number
						local remaining_text_no_num = para_text:match("^Proof%.%s*(.*)")

						if remaining_text_no_num then
							print("Matched without number: Proof")
							-- Create the formatted header without proof number
							header_para = pandoc.Para({
								pandoc.Strong({ pandoc.Str("Proof") }),
								pandoc.Str(":"),
							})
							remaining_text = remaining_text_no_num
						else
							-- Could not match the proof header pattern
							print("No matching pattern found in proof Div.")
							return el
						end
					end

					-- Create the content paragraph
					content_para = pandoc.Para({ pandoc.Str(remaining_text) })
				else
					-- Handle Theorem-like environments (theorem, lemma, proposition, conjecture)

					-- Attempt to match "Theorem X (Title). Remaining text"
					local theorem_num, theorem_title, remaining_text = para_text:match(
						"^" .. matched_class:gsub("^%l", string.upper) .. "%s+([^%s%(]+)%s*%(([^)]+)%)%.%s*(.*)"
					)

					if theorem_num then
						print(
							string.format(
								"Matched with title: %s %s (%s)",
								matched_class:gsub("^%l", string.upper),
								theorem_num,
								theorem_title
							)
						)

						-- Create the formatted header with title
						header_para = pandoc.Para({
							pandoc.Strong({ pandoc.Str(matched_class:gsub("^%l", string.upper) .. " " .. theorem_num) }),
							pandoc.Space(),
							pandoc.Emph({ pandoc.Str("(" .. theorem_title .. ")") }),
							pandoc.Str(":"),
						})

						-- Create the content paragraph
						content_para = pandoc.Para({ pandoc.Str(remaining_text) })
					else
						-- Attempt to match "Theorem X. Remaining text" without title
						local theorem_num_no_title, remaining_text_no_title =
							para_text:match("^" .. matched_class:gsub("^%l", string.upper) .. "%s+([^%s%(]+)%.%s*(.*)")

						if theorem_num_no_title then
							print(
								string.format(
									"Matched without title: %s %s",
									matched_class:gsub("^%l", string.upper),
									theorem_num_no_title
								)
							)

							-- Create the formatted header without title
							header_para = pandoc.Para({
								pandoc.Strong({
									pandoc.Str(matched_class:gsub("^%l", string.upper) .. " " .. theorem_num_no_title),
								}),
								pandoc.Str(":"),
							})

							-- Create the content paragraph
							content_para = pandoc.Para({ pandoc.Str(remaining_text_no_title) })
						else
							-- Could not match the theorem header pattern
							print(string.format("No matching pattern found in %s Div.", matched_class))
							return el
						end
					end
				end

				-- Create HorizontalRule blocks
				local hr_before = pandoc.HorizontalRule()
				local hr_after = pandoc.HorizontalRule()

				-- Return a list of blocks: HorizontalRule, Header, Content, HorizontalRule
				return { hr_before, header_para, content_para, hr_after }
			else
				-- If the Div does not contain a Para, return it as is
				print(string.format("%s Div does not contain a Para.", matched_class))
				return el
			end
		else
			-- If the Div is empty, return it as is
			print(string.format("Empty %s Div.", matched_class))
			return el
		end
	end
end
