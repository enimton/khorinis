adanosGenerator.FILES['adanos.processStyleFile.coffee'] = '''
  adanosHelpers = adanos.helpers

  copyFile = adanosHelpers.copyFile
  readFile = adanosHelpers.readFile
  PATHS = adanos.PATHS
  getFileName = Npm.require('path').basename
  delimiters = null

  ###*
   * @param {String} filepath
  ###
  adanos.processStyleFile = (filepath) ->
    if not delimiters?
      delimiters = JSON.parse(readFile(PATHS['khorinis-config'])).delimiters

    filename = getFileName(filepath)
    isElem = filename.indexOf(delimiters.elem) >= 0

    # When modifer
    if filename.indexOf(delimiters.mod) >= 0
      targetDir = if isElem \\
        then PATHS['_blocks-styles-elems-mods']
        else PATHS['_blocks-styles-blocks-mods']

    # When just an element or just a block
    else
      targetDir = if isElem \\
        then PATHS['_blocks-styles-elems']
        else PATHS['_blocks-styles-blocks']

    copyFile(filepath, targetDir)

  '''
