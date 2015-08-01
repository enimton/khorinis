adanosGenerator.FILES['adanos.isTemplateFile.coffee'] = '''
  getExtension = Npm.require('path').extname

  TEMPLATE_EXTS = [ '.html', '.jade' ]

  ###*
   * @param {String} filepath
   * @returns {Boolean}
  ###
  adanos.isTemplateFile = (filepath) ->
    return getExtension(filepath) in TEMPLATE_EXTS

  '''