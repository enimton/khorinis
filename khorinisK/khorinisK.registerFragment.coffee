blocks = khorinisK.blocks
addFragment = khorinisK.addFragment
runAllFragments = khorinisK.runAllFragments
FRAGMENT_DELIMITER = '.'

###*
 * @param {String} fragmentName
 * @param {String...} [deps...]
 * @param {Function} action
###
khorinisK.registerFragment = (fragmentName, deps..., action) ->
  if fragmentName is '__khorinis__'
    runAllFragments()

  blockName = fragmentName.split(FRAGMENT_DELIMITER)[0]

  addFragment
    name: fragmentName
    block: blocks[blockName] || (blocks[blockName] = {})
    deps: deps
    action: action
