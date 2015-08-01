adanosGenerator.FILES['adanos.PATHS.coffee'] = '''
  pathResolve = Npm.require('path').resolve

  adanos.PATHS =
    '_blocks'                    : pathResolve('_blocks')
    '_blocks-lib'                : pathResolve('_blocks/lib')
    '_blocks-scripts-client'     : pathResolve('_blocks/scripts/client')
    '_blocks-scripts-server'     : pathResolve('_blocks/scripts/server')
    '_blocks-templates'          : pathResolve('_blocks/templates')
    '_blocks-styles-blocks'      : pathResolve('_blocks/styles/0-blocks')
    '_blocks-styles-elems'       : pathResolve('_blocks/styles/1-elems')
    '_blocks-styles-elems-mods'  : pathResolve('_blocks/styles/2-elems-mods')
    '_blocks-styles-blocks-mods' : pathResolve('_blocks/styles/3-blocks-mods')
    'blocks'                     : pathResolve('private/blocks')
    'blocks-page.html'           : pathResolve('private/blocks/page/page.html')
    'blocks-page.css'            : pathResolve('private/blocks/page/page.css')
    'blocks-debugger.js'         : pathResolve('private/blocks/debugger/debugger.js')
    'khorinis-config'            : pathResolve('private/khorinis-config.json')

  '''
