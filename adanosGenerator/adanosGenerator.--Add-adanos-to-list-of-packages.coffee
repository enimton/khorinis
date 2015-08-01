if process.argv[2] is 'publish'
  return

fs = Npm.require('fs')

writeFile = fs.writeFileSync
readFile = fs.readFileSync
ADANOS_PACKAGE_NAME = adanosGenerator.ADANOS_PACKAGE_NAME
PACKAGES_FILEPATH = Npm.require('path').resolve('.meteor/packages')

content = readFile(PACKAGES_FILEPATH, { encoding: 'utf8' })

if content[content.length - 1] isnt '\n'
  content = content + '\n'

if ADANOS_PACKAGE_NAME not in content.split('\n')
  writeFile(PACKAGES_FILEPATH, content + ADANOS_PACKAGE_NAME + '\n')
