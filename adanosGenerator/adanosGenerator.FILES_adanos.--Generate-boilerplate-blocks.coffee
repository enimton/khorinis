adanosGenerator.FILES['adanos.--Generate-boilerplate-blocks.coffee'] = '''
  fs = Npm.require('fs')

  exists = fs.existsSync
  createFile = adanos.helpers.createFile
  PATHS = adanos.PATHS
  BOILERPLATE = adanos.BOILERPLATE

  if not exists(PATHS['blocks'])
    createFile(PATHS['blocks-page.html'], BOILERPLATE.PAGE_HTML)
    createFile(PATHS['blocks-page.css'], BOILERPLATE.PAGE_CSS)
    createFile(PATHS['blocks-debugger.js'] , BOILERPLATE.DEBUGGER_JS)

  '''
