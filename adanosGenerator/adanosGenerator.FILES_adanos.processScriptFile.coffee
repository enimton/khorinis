adanosGenerator.FILES['adanos.processScriptFile.coffee'] = '''
  path = Npm.require('path')
  adanosHelpers = adanos.helpers

  pathJoin = path.join
  getFileName = path.basename
  readFile = adanosHelpers.readFile
  copyFile = adanosHelpers.copyFile
  createFile = adanosHelpers.createFile
  PATHS = adanos.PATHS

  ALLOWED_INSTRUCTIONS = [ 'client', 'server', 'client-server' ]
  INSTRUCTION_REGEXP = ///
    ^
    (?:(?:\\#)|(?:\\/\\/)){1}           # comment start: `#` or `//`
    \\ *                              # optional spaces
    (?:\\:\\:){1}                      # ::
    \\ *                              # optional spaces
    (client|server|client-server){1} # instruction
    \\ *                              # optional spaces
    $
    ///m

  ###*
   * @param {String} text
   * @returns {Boolean}
  ###
  hasInstructions = (text) ->
    return INSTRUCTION_REGEXP.test(text)

  ###*
   * @param {String} textLine
   * @returns {String|null}
  ###
  getInstruction = (textLine) ->
    instruction = textLine.replace(INSTRUCTION_REGEXP, '$1')

    if instruction in ALLOWED_INSTRUCTIONS
      return instruction

    return null

  ###*
   * @param {String} filepath
  ###
  adanos.processScriptFile = (filepath) ->
    content = readFile(filepath)

    if not hasInstructions(content)
      copyFile(filepath, PATHS['_blocks-scripts-client'])
    else
      locus = 'client'
      contentFor = { client: [], server: [] }

      for line in content.split('\\n')
        instruction = getInstruction(line)

        if instruction
          locus = instruction
        else
          if locus is 'client-server'
            contentFor.client.push(line)
            contentFor.server.push(line)
          else
            contentFor[locus].push(line)

      filename = getFileName(filepath)
      if contentFor.client.length
        createFile(pathJoin(PATHS['_blocks-scripts-client'], filename), contentFor.client.join('\\n'))
      if contentFor.server.length
        createFile(pathJoin(PATHS['_blocks-scripts-server'], filename), contentFor.server.join('\\n'))

  '''
