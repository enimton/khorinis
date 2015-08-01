adanosGenerator.FILES['adanos.helpers.coffee'] = '''
  fs = Npm.require('fs')
  path = Npm.require('path')

  pathJoin = path.join
  getFileName = path.basename
  writeFile = fs.writeFileSync
  readFile = fs.readFileSync
  createReadStream = fs.createReadStream
  createWriteStream = fs.createWriteStream
  createFolder = Npm.require('mkdirp').sync
  deleteFolder = Npm.require('rimraf').sync

  adanos.helpers =
    ###*
     * Deletes folder by given path.
     * @param {String} dirpath
    ###
    deleteFolder: deleteFolder

    ###*
     * @param {String} filepath
     * @returns {String} file's content
    ###
    readFile: (filepath) ->
      return readFile(filepath, { encoding: 'utf8' })

    ###*
     * Creates file with given content.
     * @param {String} filepath
     * @param {String} content
    ###
    createFile: (filepath, content) ->
      createFolder(path.dirname(filepath))
      writeFile(filepath, content)

    ###*
     * Copies file to directory.
     * @param {String} filepathFrom
     * @param {String} directoryTo
    ###
    copyFile: (filepathFrom, directoryTo) ->
      createFolder(directoryTo)
      createReadStream(filepathFrom)
        .pipe(createWriteStream(pathJoin(directoryTo, getFileName(filepathFrom))))

  '''