#
# In a Glasshouse, I did grow. 
#

@GlassHouse =
  load: (options)->
    #processing
    @procInstance = options.processingInstance
    # render jsonform
    @formEl = $("#" + options.formId)
    @formEl.jsonForm
      form: @form
      schema: @schema
    @

    # GlassHouse.loadAxioms $("select[name=axioms]").val() 
  loadAxioms: (name) =>
    $.ajax
      url: "glasshouse/plants/" + name + ".json"
      dataType: "text"
    .done (code)->
      aceId = $("#form .ace_editor").attr("id")
      editor = ace.edit(aceId)
      editor.getSession().setValue(GlassHouse.render(code))

  render: (code) ->
    console.log code[code.length-1]
    "Lima.load(" + code + ")" +
      ".iterate(3)\n" +
      ".run('canvas',\n" +
      "     {step: 10,\n" +
      "      origin: function(w,h) {\n" +
      "        return {x: w/2,\n" +
      "                y: h/2,\n" +
      "                angle: 90};\n" +
      "        }\n" +
      "      });"
  
  run: ->
    code = @formEl.jsonFormValue().console
    eval "this.lima =" + code

  form: [{
    key: "axioms"
    notitle: true
    titleMap:
      basic: "spinning ivy"
      dragon: "the classical dragon fractal"
    htmlClass: "trywith"
    onChange: (e) =>
      selected = $(e.target).val()
      GlassHouse.loadAxioms selected
    }, {
    key: "console"
    type: "ace"
    width: "100%"
    theme: "foo"
    height: window.innerHeight + 'px'
    notitle: true
    onChange: (e) ->
      GlassHouse.run()
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
