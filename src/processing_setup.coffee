class Lima.ProcessingSetup
  constructor: (lsys) ->
    console.log("boot")
    @lsys = lsys
    @frames = 100
    @bColor = 200

  iterate: (times) ->
    @iterations = times
    return @

  run: (canvasId, options)->
    @w = options.width
    @h = options.height
    @iterations ||= 10
    @procInstance = new Processing(canvasId, @processingSetup())
    @

  processingSetup: ->
    @lsys.iterate(@iterations)
    console.log(@lsys)
    @cursor = 0
    return (p) =>
      @t = new Lima.Turtle p, x: @w/2, y: @h/2, angle: 90
      p.setup = => @setup.call(@, p)
      p.draw = => @draw.call(@, p)
      return null

  draw: (p) ->
    return if @cursor > @lsys.length-1
    # p.fill(@cursor, 255, 0)
    # p.rect(0, 0, @cursor, @cursor)
    # console.log(t, @cursor, typeof(p.radians))
    # @t.forward()
    # @t.right(10)
    console.log(@t)
    @lsys.draw(@cursor, @t)
    @cursor++

            
  setup: (p) ->
    p.size(@w, @h)
    p.frameRate(@frames)
    p.background(@bColor)
