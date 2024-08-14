local M = {}

M.map = function(t, func)
	local result = {}
	for k, v in pairs(t) do
		table.insert(result, func(k, v))
	end
	return result
end

M.format_keys = function(keys)
	-- Determine the maximum width for the keys
	local max_key_length = 0
	for key in pairs(keys) do
		local key_length = #key
		if key_length > max_key_length then
			max_key_length = key_length
		end
	end

	-- Map function to format each key-value pair
	return M.map(keys, function(key, value)
		return string.format("%s:%s %s", key, string.rep(" ", max_key_length - #key + 2), value)
	end)
end

return M
