getFragments = khorinisK.getFragments
runFragment = khorinisK.runFragment

khorinisK.runAllFragments = ->
  brokenFragment = null
  fragments = getFragments()

  while fragments.length > 0
    fragment = fragments.shift()
    result = runFragment(fragment)

    if not result.success
      if brokenFragment
        if brokenFragment is fragment
          console.error "Can't resolve dependency `#{result.dep}` for fragment `#{fragment.name}`"

          return
      else
        brokenFragment = fragment

      fragments.push(fragment)
    else
      brokenFragment = null

