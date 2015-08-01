adanosGenerator.FILES['adanos.processAssetFile.coffee'] = '''
  copyFile = adanos.helpers.copyFile
  PATHS = adanos.PATHS

  ###*
   * @param {String} filepath
  ###
  adanos.processAssetFile = (filepath) ->
    copyFile(filepath, PATHS['_blocks-templates'])

  '''