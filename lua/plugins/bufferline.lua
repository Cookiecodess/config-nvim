return {
  {
    'akinsho/bufferline.nvim',
    opts = {
      options = {
        numbers = function(opts)
          return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
        end,
      }
    }
  }
}
