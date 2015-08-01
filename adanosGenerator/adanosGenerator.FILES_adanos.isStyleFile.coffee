adanosGenerator.FILES['adanos.isStyleFile.coffee'] = '''
  getExtension = Npm.require('path').extname

  STYLE_EXTS = [ '.css', '.less', '.styl', 'scss', 'sass' ]

  ###*
   * @param {String} filepath
   * @returns {Boolean}
  ###
  adanos.isStyleFile = (filepath) ->
    return getExtension(filepath) in STYLE_EXTS

  '''