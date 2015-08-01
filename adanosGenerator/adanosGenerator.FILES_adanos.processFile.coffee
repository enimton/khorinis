adanosGenerator.FILES['adanos.processFile.coffee'] = '''
  isImportFile = adanos.isImportFile
  isScriptFile = adanos.isScriptFile
  isStyleFile = adanos.isStyleFile
  isTemplateFile = adanos.isTemplateFile
  processImportFile = adanos.processImportFile
  processScriptFile = adanos.processScriptFile
  processStyleFile = adanos.processStyleFile
  processTemplateFile = adanos.processTemplateFile
  processAssetFile = adanos.processAssetFile

  ###*
   * @param {String} filepath
  ###
  adanos.processFile = (filepath) ->
    if isImportFile(filepath)
      return processImportFile(filepath)

    if isScriptFile(filepath)
      return processScriptFile(filepath)

    if isStyleFile(filepath)
      return processStyleFile(filepath)

    if isTemplateFile(filepath)
      return processTemplateFile(filepath)

    processAssetFile(filepath)

  '''
