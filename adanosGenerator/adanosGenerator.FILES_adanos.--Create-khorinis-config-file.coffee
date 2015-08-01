adanosGenerator.FILES['adanos.--Create-khorinis-config-file.coffee'] = '''
  exists = Npm.require('fs').existsSync
  createFile = adanos.helpers.createFile
  ADANOS_CONFIG_BOILERPLATE = adanos.BOILERPLATE.ADANOS_CONFIG
  ADANOS_CONFIG_FILEPATH = adanos.PATHS['khorinis-config']

  if not exists(ADANOS_CONFIG_FILEPATH)
    createFile(ADANOS_CONFIG_FILEPATH, ADANOS_CONFIG_BOILERPLATE)

  '''
