#
# In a Glasshouse, I did grow. 
#

class @GlassHouse
  constructor: (options)->

    # render jsonform
    $("#" + options.formId).jsonForm
      form: @form
      schema: @schema  

  @loadAxioms: (name) =>
    $.ajax
      url: "glasshouse/plants/" + name + ".json"
      dataType: "text"
    .done (code)->
      aceId = $("#form .ace_editor").attr("id")
      editor = ace.edit(aceId)
      editor.getSession().setValue(GlassHouse.render(code))

  @render: (code) ->
    "Lima.load(" + code + ")\n" +
      ".iterate(3)\n" +
      ".run('canvas',\n  {step: 10,\n" +
      "                origin: function(w,h) {\n" +
      "                  return {x: w/2, y:h/2, angle: 90};\n" +
      "               }});"


  run: ->

  form: [{
    key: "axioms"
    notitle: true
    titleMap:
      basic: "spinning ivy"
      dragon: "the classical dragon fractal"
    htmlClass: "trywith"
    onChange: (e) =>
      selected = $(e.target).val()
      @loadAxioms(selected)
    }, {
    key: "console"
    type: "ace"
    width: "100%"
    height: window.innerHeight + 'px'
    notitle: true
    onChange: ->
      @run()
  }]
 
  schema:
    axioms:
      title: "axioms to load"
      type: "string"
      enum: [
        "dragon"
        "basic"
      ],
      default: "basic"
    console:
      title: "load or edit axioms"
      type: "string"
