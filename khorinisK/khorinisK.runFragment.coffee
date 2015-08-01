getDep = khorinisK.getDep

###*
 * @param {Object} fragment
 *  @param {Object} fragment.block
 *  @param {String[]} fragment.deps
 *  @param {Function} fragment.action
 * @returns {Object}
###
khorinisK.runFragment = (fragment) ->
  depValues = []

  for dep in fragment.deps
    depValue = getDep(dep)
    if depValue?
      depValues.push(depValue)
    else
      return { success: false, dep: dep }

  fragment.action.apply(fragment.block, depValues)

  return { success: true }
