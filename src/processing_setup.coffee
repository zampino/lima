class Lima.ProcessingSetup
  constructor: (lsys) ->
    console.log("boot")
    @lsys = lsys
    @frames = 100
    @bColor = 200

  iterate: (times) ->
    @iterations = times || -1
    @

  run: (canvasId, options)->
    @w = options.width || $(document).width()
    @h = options.height || $(document).height()
    @iterations ||= 10
    @canvas = $(canvasId)[0]
    return if @iterations == -1
    @procInstance = new Processing(canvasId, @processingSetup())
    @

  clear: ->
    @procInstance.exit()
    ctx = @canvas.getContext("2d")
    ctx.clearRect(0, 0, @canvas.width, @canvas.height)
    console.log "clear rect"
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
    # console.log(@t)
    @lsys.draw(@cursor, @t)
    @cursor++

            
  setup: (p) ->
    p.size(@w, @h)
    p.frameRate(@frames)
    p.background(0, 0, 1, .5)
