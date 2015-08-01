adanosGenerator.FILES['adanos.processTemplateFile.coffee'] = '''
  copyFile = adanos.helpers.copyFile
  PATHS = adanos.PATHS

  ###*
   * @param {String} filepath
  ###
  adanos.processTemplateFile = (filepath) ->
    copyFile(filepath, PATHS['_blocks-templates'])

  '''