adanosGenerator.FILES['adanos.isScriptFile.coffee'] = '''
  getExtension = Npm.require('path').extname

  SCRIPT_EXTS = [ '.js', '.coffee' ]

  ###*
   * @param {String} filepath
   * @returns {Boolean}
  ###
  adanos.isScriptFile = (filepath) ->
    return getExtension(filepath) in SCRIPT_EXTS

  '''