return {
    "karb94/neoscroll.nvim",
    config = function()
        require('neoscroll').setup({
            hide_cursor = true,
            stop_eof = true,
            respect_scrolloff = false,
            cursor_scrolls_alone = true,
            duration_multiplier = 1.0,
            easing = 'linear',
            ignored_events = {
                'WinScrolled', 'CursorMoved'
            },
        })
    end,
}
