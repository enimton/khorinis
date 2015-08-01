if process.argv[2] is 'publish'
  return

fs = Npm.require('fs')
path = Npm.require('path')

exists = fs.existsSync
writeFile = fs.writeFileSync
dirname = path.dirname
pathJoin = path.join
createFolder = Npm.require('mkdirp').sync
FILES = adanosGenerator.FILES
ADANOS_DIRPATH = adanosGenerator.ADANOS_DIRPATH
SUCCESS_MESSAGE = '''
  \n
  => Khorinis was successfully initialized
  => Please start your app again

  '''

createFile = (filepath, content) ->
  createFolder(dirname(filepath))
  writeFile(filepath, content)

if not exists(ADANOS_DIRPATH)
  for filename, filecontent of FILES
    if filename is 'package.js'
      createFile(pathJoin(ADANOS_DIRPATH, filename), filecontent)
    else
      createFile(pathJoin(ADANOS_DIRPATH, 'adanos', filename), filecontent)

  console.log(SUCCESS_MESSAGE)

  process.exit(0)
