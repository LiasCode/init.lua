return {
  {
    "gelguy/wilder.nvim",

    config = function()
      local wilder = require('wilder')
      wilder.setup({ modes = { ':', '/', '?' } })

      wilder.set_option('pipeline', {
        wilder.debounce(10),
        wilder.branch(
          wilder.cmdline_pipeline(),
          wilder.search_pipeline()
        ),
      });

      wilder.set_option('renderer', wilder.popupmenu_renderer({
        highlighter = {
          wilder.basic_highlighter()
        },
        highlights = {
          accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
        },
      }));
    end
  }
}
