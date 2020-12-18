
--- Adds comma seperator to number and returns a string.
--- @param v number we're going to operate on.
--- @return string The number with seperators in the standard form.
function number_separator(v)
	local s = string.format("%d", math.floor(v))
	local pos = string.len(s) % 3
	if pos == 0 then pos = 3 end
	return string.sub(s, 1, pos) .. string.gsub(string.sub(s, pos+1), "(...)", ",%1")
end
function format_score()

end