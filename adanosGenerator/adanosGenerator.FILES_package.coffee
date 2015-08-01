ADANOS_PACKAGE_NAME = adanosGenerator.ADANOS_PACKAGE_NAME
ADANOS_VERSION = adanosGenerator.ADANOS_VERSION

adanosGenerator.FILES['package.js'] = """
  Package.describe({
    name    : '#{ADANOS_PACKAGE_NAME}',
    version : '#{ADANOS_VERSION}',
    summary : 'Ships with Khorinis package',
  });

  Package.registerBuildPlugin({
    name: 'adanos',
    npmDependencies: {
      'glob'   : '5.0.5',
      'mkdirp' : '0.5.0',
      'rimraf' : '2.3.2'
    },
    use: [ 'coffeescript' ],
    sources: [
      'adanos/adanos.coffee',
      'adanos/adanos.BOILERPLATE.coffee',
      'adanos/adanos.PATHS.coffee',
      'adanos/adanos.helpers.coffee',
      'adanos/adanos.isStyleFile.coffee',
      'adanos/adanos.isScriptFile.coffee',
      'adanos/adanos.isImportFile.coffee',
      'adanos/adanos.isTemplateFile.coffee',
      'adanos/adanos.processTemplateFile.coffee',
      'adanos/adanos.processStyleFile.coffee',
      'adanos/adanos.processScriptFile.coffee',
      'adanos/adanos.processImportFile.coffee',
      'adanos/adanos.processAssetFile.coffee',
      'adanos/adanos.processFile.coffee',
      'adanos/adanos.--Create-khorinis-config-file.coffee',
      'adanos/adanos.--Generate-boilerplate-blocks.coffee',
      'adanos/adanos.--Compile-on-blocks-edit.coffee'
    ]
  });

  """
