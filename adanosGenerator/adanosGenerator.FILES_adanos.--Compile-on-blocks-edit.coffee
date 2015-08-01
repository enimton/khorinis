adanosGenerator.FILES['adanos.--Compile-on-blocks-edit.coffee'] = '''
  adanosHelpers = adanos.helpers

  getAllFiles = Npm.require('glob').sync
  pathJoin = Npm.require('path').join
  deleteFolder = adanosHelpers.deleteFolder
  createFile = adanosHelpers.createFile
  processFile = adanos.processFile
  PATHS = adanos.PATHS
  INIT_FILENAME = 'init.js'
  INIT_CONTENT = """
    k('__khorinis__');

    """

  deleteFolder(PATHS['_blocks'])
  getAllFiles("#{PATHS['blocks']}/**/*.*").forEach(processFile)
  createFile(pathJoin(PATHS['_blocks'], INIT_FILENAME), INIT_CONTENT) 

  '''
