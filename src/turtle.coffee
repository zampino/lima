class Lima.Turtle
  constructor: (processing, options) ->
    @p = processing
    @position = new Lima.Position
      p: @p
      x: options.x
      y: options.y
      angle: options.angle
    Lima.Position.step = options.step || 30
    @queue = []

  forward: ->
    trace = @position.trace()
    console.log("ffw", trace)
    @p.line.apply(@, trace)

  left: (angle)->
    console.log("left")
    @position.rotate(angle)

  right: (angle)->
    @position.rotate(-angle)

  push: ->
    markPos = new Lima.Position(@position)
    @queue.push(markPos)
    console.log("push", @queue)

  pop: ->
    oldPos = @queue.pop()
    console.log("pop", @position, oldPos)
    @position = oldPos


# Thanks to Micha (Phreax) T. for the Vector API

class Lima.Position
  constructor: ->
    _.extend @, @parseArgs(arguments[0])
    @step = 10

  parseArgs: (args)->
    args

  rotate: (angle) ->
    @angle += angle

  stepOn: (steps = 1)->
    @x += steps * @step * Math.cos(@p.radians(@angle))
    @y += steps * @step * Math.sin(@p.radians(@angle))
    @

  add: (args)->

  trace: ->
    x = @x
    y = @y
    @stepOn()
    [x, y, @x, @y]

