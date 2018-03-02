local scroll = {}


local win = vim.api.nvim_get_current_win()
local buf = vim.api.nvim_get_current_buf()
local buf_line_count = vim.api.nvim_buf_line_count(buf)
local win_line_count = vim.api.nvim_win_get_height(win)
local half_win_line = math.ceil(win_line_count / 2) - 1
local buf_pos = vim.api.nvim_win_get_cursor(win)
local win_line = vim.api.nvim_call_function('winline', {})
local bottom_line = win_line_count - win_line + buf_pos[1]
local top_line = buf_pos[1] - win_line + 1

local function inti()
	win = vim.api.nvim_get_current_win()
	buf = vim.api.nvim_get_current_buf()
	buf_line_count = vim.api.nvim_buf_line_count(buf)
	win_line_count = vim.api.nvim_win_get_height(win)
	half_win_line = math.ceil(win_line_count / 2)
	buf_pos = vim.api.nvim_win_get_cursor(win)
	win_line = vim.api.nvim_call_function('winline', {})
	bottom_line = win_line_count - win_line + buf_pos[1]
	top_line = buf_pos[1] - win_line + 1
end

local function scroll_num_up()
	if top_line <= 1
	then
		return {0, buf_pos}
	end
	if top_line > half_win_line
	then 
		return {half_win_line, {top_line - 1, 1}}
	end
	return {top_line - 1, {top_line - 1, 1}}
end

local function scroll_num_down()

	if bottom_line >= buf_line_count 
	then
		return {0, buf_pos}
	end

	if bottom_line + half_win_line >= buf_line_count
	then
		return { buf_line_count - bottom_line, {bottom_line+1, 1} }
	end
	return { half_win_line, {bottom_line+1, 1} }
end

function scroll.scroll_up()
	inti()
	scroll_args = scroll_num_up()
	local opt = {}
	opt["repeat"] = scroll_args[1]
	vim.api.nvim_call_function("timer_start", {20,'Scroll_up', opt})
	vim.api.nvim_win_set_cursor(win, scroll_args[2])
end

function scroll.scroll_down()
	scroll_args = scroll_num_down()
	local opt = {}
	opt["repeat"] = scroll_args[1]
	vim.api.nvim_call_function("timer_start", {10,'Scroll_down', opt})
	vim.api.nvim_win_set_cursor(win, scroll_args[2])
end

return scroll
