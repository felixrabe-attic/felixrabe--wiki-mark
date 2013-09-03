module.exports =
  (options = {}) ->
    base = options.base ? ''

    buildLink = (title, target) ->
      "<a href=\"#{base}#{target}\">#{title}</a>"

    compile: (str) ->
      # match: [[Title|Target]]
      str = str.replace /(\\)?\[\[[ \t]*([^\]]+?)[ \t]*\|[ \t]*(.+?)[ \t]*\]\]/g, ($0, backslash, title, target) ->
        return $0 if backslash
        buildLink title, target

      # match: [[Title And Target]]
      str = str.replace /(\\)?\[\[[ \t]*(.+?)[ \t]*\]\]/g, ($0, backslash, titleAndTarget) ->
        return $0.substr(1) if backslash
        buildLink titleAndTarget, titleAndTarget

      return str
