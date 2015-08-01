blocks = khorinisK.blocks
cachedDeps = {}

###*
 * 'collections.Posts' -> blocks.collections.Posts (or null)
 * 'helpers.is-available' -> blocks.helpers['is-available'] (or null)
 * '' -> blocks
 * @param {String} dep
 * @returns {Anything}
###
khorinisK.getDep = (dep) ->
  if dep is ''
    return blocks

  if dep in cachedDeps
    return cachedDeps[dep]

  value = blocks
  for part in dep.split('.')
    value = value[part]
    if not value?
      return null

  cachedDeps[dep] = value

  return value
