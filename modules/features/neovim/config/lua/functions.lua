local M = {}

---Validates if value is in table.
---@generic T : any # Type of the elements in the iterable.
---@param tbl T[] # Input iterable.
---@param value T # Value to validate.
---@return boolean
function M.in_table(tbl, value)
	local condition = false
	for _, elem in ipairs(tbl) do
		if (value == elem) then
			condition = true
		end
	end
	return condition
end

---Computes the minimum between two numbers.
---@param a number # First number.
---@param b number # Second number.
---@return number # Minimum number.
function M.min(a, b)
	if (a <= b) then
		return a
	else
		return b
	end
end

---Zips two iterables.
---@generic T1 : any # Generic type 1.
---@generic T2 : any # Generic type 2.
---@param a T1[] # First iterable.
---@param b T2[] # Second iterable.
---@param key1? string # Key for first field.
---@param key2? string # Key for second field.
---@return table<string, T1 | T2>[]
function M.zip(a, b, key1, key2)
	local result = {}
	local len = M.min(#a, #b)
	local valid_key1
	local valid_key2

	if (key1 == nil) then
		valid_key1 = 1
	else
		valid_key1 = key1
	end

	if (key2 == nil) then
		valid_key2 = 2
	else
		valid_key2 = key2
	end

	for i=1,len do
		table.insert(result, {[valid_key1] = a[i], [valid_key2] = b[i]})
	end
	return result
end

---Maps a function over an array.
---@generic T : any # Generic input type.
---@generic V : any # Generic output type.
---@param fn fun(elem: T) : V # Mapping function.
---@param iterable T[] # Array to map.
---@return V[] # Mapped result.
function M.map(fn, iterable)
	local result = {}
	for _, value in ipairs(iterable) do
		table.insert(result, fn(value))
	end
	return result
end

---Filters an array using a function.
---@generic T : any # Generic input type.
---@param fn fun(elem: T) : boolean # Filter function.
---@param iterable T[] # Array to filter.
---@return T[] # Filtered result.
function M.filter(fn, iterable)
	local result = {}
	for _, value in ipairs(iterable) do
		if fn(value) then
			table.insert(result, value)
		end
	end
	return result
end

---Validates if all values in array are true.
---@param iterable boolean[] # Array to validate.
---@return boolean # Validation
function M.all(iterable)
	local result = true
	for _, value in ipairs(iterable) do
		result = result and value
	end
	return result
end

---Maps a function over an index and the value.
---@generic T : any # Generic input type.
---@generic V : any # Generic output type.
---@param fn fun(index: int, elem: T):V # Mapping function.
---@param iterable T[] # Array to map.
---@return V[] # Mapped result.
function M.icollect(fn, iterable)
	local result = {}
	for index, value in ipairs(iterable) do
		table.insert(result, fn(index, value))
	end
	return result
end

---Joins multiple strings using a separator. defaults to space.
---@param strings string[] # Strings to join.
---@param sep? string # Separator
---@return string # Joined strings
function M.strjoin(strings, sep)
	local result = {}
	local valid_sep
	local len = #strings

	if sep == nil then
		valid_sep = " "
	else
		valid_sep = sep
	end

	for i=1,(len - 1) do
		table.insert(result, strings[i])
		table.insert(result, valid_sep)
	end
	table.insert(result, strings[len])

	local join = ""
	for _, value in ipairs(result) do
		join = join .. value
	end
	return join
end

return M
