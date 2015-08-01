adanosGenerator.FILES['adanos.isImportFile.coffee'] = '''
  getFileName = Npm.require('path').basename

  IMPORT_MARK = '.import.'

  ###*
   * @param {String} filepath
   * @returns {Boolean}
  ###
  adanos.isImportFile = (filepath) ->
    return getFileName(filepath).indexOf(IMPORT_MARK) > 0

  '''