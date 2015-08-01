adanosGenerator.FILES['adanos.processImportFile.coffee'] = '''
  copyFile = adanos.helpers.copyFile
  PATHS = adanos.PATHS

  ###*
   * @param {String} filepath
  ###
  adanos.processImportFile = (filepath) ->
    copyFile(filepath, PATHS['_blocks-lib'])

  '''