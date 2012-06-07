class Accordion
  constructor: () ->
    @init_jquery_plugin()
    
  init_jquery_plugin: () ->
    jQuery.fn.accordion = plugin_constructor
    jQuery.fn.accordion.defaults =
      active: 0
    
  plugin_constructor= (options) ->
    opts = jQuery.extend {}, jQuery.fn.accordion.defaults, options
    this.each () ->
      $this = $(@)
      $sections = $this.children()
      
      $sections.addClass "ui-default-state"
      deactivate_section $sections
      
      $sections.children(":even").click () ->
        section = $(@).parent()
        deactivate_section section.siblings()
        activate_section section
        false
      
      activate_section $sections.get(opts.active)

  activate_section = (section) ->
    manipulate_section section, true
  
  deactivate_section = (section) ->
    manipulate_section section, false
    
  manipulate_section = (section, expression) ->
    section = $ section
    section.toggleClass("ui-active-state", expression).
            toggleClass("ui-default-state", !expression).
            children(':odd').
            toggle(expression)
    

jQuery ->
  new Accordion
    
