Package.describe({
  name          : 'imkost:khorinis',
  version       : '0.9.2',
  summary       : 'Solid way to write Meteor applications',
  git           : 'https://github.com/imkost/khorinis',
  documentation : 'README.md'
});

Package.registerBuildPlugin({
  name: 'adanos',
  use: [ 'coffeescript' ],
  npmDependencies: { mkdirp : '0.5.0' },
  sources: [
    'adanosGenerator/adanosGenerator.coffee',
    'adanosGenerator/adanosGenerator.FILES_package.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.BOILERPLATE.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.PATHS.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.helpers.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.isStyleFile.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.isScriptFile.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.isImportFile.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.isTemplateFile.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.processTemplateFile.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.processStyleFile.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.processScriptFile.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.processImportFile.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.processAssetFile.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.processFile.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.--Create-khorinis-config-file.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.--Generate-boilerplate-blocks.coffee',
    'adanosGenerator/adanosGenerator.FILES_adanos.--Compile-on-blocks-edit.coffee',
    'adanosGenerator/adanosGenerator.--Add-adanos-to-list-of-packages.coffee',
    'adanosGenerator/adanosGenerator.--Generate-adanos-package.coffee',
  ]
});

Package.onUse(function(api) {
  var CLIENT = 'client',
      CLIENT_SERVER = [ 'client', 'server' ];

  api.versionsFrom('1.0');

  api.use('coffeescript', CLIENT_SERVER);

  api.addFiles('khorinisK/khorinisK.coffee', CLIENT_SERVER);
  api.addFiles('khorinisK/khorinisK.getDep.coffee', CLIENT_SERVER);
  api.addFiles('khorinisK/khorinisK.runFragment.coffee', CLIENT_SERVER);
  api.addFiles('khorinisK/khorinisK.runAllFragments.coffee', CLIENT_SERVER);
  api.addFiles('khorinisK/khorinisK.registerFragment.coffee', CLIENT_SERVER);
  api.addFiles('khorinisK/khorinisK.--Export-k.js', CLIENT_SERVER);

  api.export('k');
});
