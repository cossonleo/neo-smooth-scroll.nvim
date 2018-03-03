--------------------------------------------------
--    LICENSE: MIT
--     Author: Cosson2017
--    Version: 0.2
-- CreateTime: 2018-03-02 17:30:32
-- LastUpdate: 2018-03-02 18:21:57
--       Desc: smooth scroll core
--------------------------------------------------

local scroll = {}


-- current win handler
local win = vim.api.nvim_get_current_win()

-- current buf handler
local buf = vim.api.nvim_get_current_buf()

-- buf total line count
local buf_line_count = vim.api.nvim_buf_line_count(buf)

-- win display line count
local win_line_count = vim.api.nvim_win_get_height(win)

-- win disply half line count
local half_win_line = math.ceil(win_line_count / 2) - 1

-- cur pos relative to buf
local buf_pos = vim.api.nvim_win_get_cursor(win)

-- cur line relative to win
local win_line = vim.api.nvim_call_function('winline', {})

-- bottom line of buf displayed
local bottom_line = win_line_count - win_line + buf_pos[1]

-- top line of buf displayed
local top_line = buf_pos[1] - win_line + 1

local function init()
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

-- scroll up line num
local function scroll_up_num()
	if top_line <= 1 then
		return {0, buf_pos}
	end
	if top_line > half_win_line then 
		return {half_win_line, {top_line - 1, 1}}
	end
	return {top_line - 1, {top_line - 1, 1}}
end

-- scroll down line num
local function scroll_down_num()

	if bottom_line >= buf_line_count then
		return {0, buf_pos}
	end

	if bottom_line + half_win_line >= buf_line_count then
		return { buf_line_count - bottom_line, {bottom_line+1, 1} }
	end
	return { half_win_line, {bottom_line+1, 1} }
end

-- scroll up
function scroll.scroll_up()
	init()
	local scroll_args = scroll_up_num()
	if scroll_args[1] == 0 then
		return
	end

	local opt = {}
	opt["repeat"] = scroll_args[1]
	vim.api.nvim_call_function("timer_start", {15,'Scroll_up', opt})
	vim.api.nvim_win_set_cursor(win, scroll_args[2])
end

-- scroll down
function scroll.scroll_down()
	init()
	local scroll_args = scroll_down_num()
	if scroll_args[1] == 0 then
		return
	end

	local opt = {}
	opt["repeat"] = scroll_args[1]
	--local log = {}
	--local inlog = {}
	--inlog["text"] = scroll_args[1]
	--log = {inlog}
	--vim.api.nvim_call_function("setqflist", {log})
	vim.api.nvim_call_function("timer_start", {15,'Scroll_down', opt})
	vim.api.nvim_win_set_cursor(win, scroll_args[2])
end

return scroll
