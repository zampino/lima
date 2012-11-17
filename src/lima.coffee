@Lima = {}

Lima.load = (options) ->
  # process options
  # Lima.Position.step = options.step || 20 

  lsys = new Lima.LSys(options)
  new Lima.ProcessingSetup(lsys)
