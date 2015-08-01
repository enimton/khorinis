pathResolve = Npm.require('path').resolve

@adanosGenerator =
  FILES: {}

  ADANOS_PACKAGE_NAME: 'imkost:khorinis-adanos'
  ADANOS_VERSION: '0.9.0'
  ADANOS_DIRPATH: pathResolve('packages/khorinis-adanos')
