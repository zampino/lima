class Lima.LSys
  constructor: (options) ->
    _.extend(@, options)
    @sentence = @axiom

  iterate: (times) ->
    @buildSentence(times)
    @length = @sentence.length
    console.log(@sentence)

  draw: (index, turtle) ->
    sym = @sentence[index]
    actions = @actions[sym] || []
    for a in actions
      [method, arg] = a.split("-")
      angle = if arg then parseInt(arg) else 0 
      turtle[method].call(turtle, angle) 

  buildSentence: (times)->
    for i in [1..times]
      @expand()

  expand: ->
    @sentence = ( @map(letter) for letter in @sentence ).join("")      

  map: (letter) ->
    return letter unless exp = @rules[letter]
    exp
