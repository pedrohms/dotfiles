local local_ts = os.getenv('HOME') .. '/.npm/lib/node_modules/typescript/lib'

return {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  init_options = {
    typescript = {
      tsdk = local_ts
    }
  }
}
