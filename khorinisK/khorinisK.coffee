fragments = []

@khorinisK =
  blocks: {}

  addFragment: (fragment) ->
    fragments.push(fragment)

  getFragments: ->
    return fragments
