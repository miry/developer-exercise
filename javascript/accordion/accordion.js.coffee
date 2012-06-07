class Accordion
  constructor: () ->
    @init_jquery_plugin()
    
  init_jquery_plugin: () ->
    jQuery.fn.accordion = plugin_constructor
    jQuery.fn.accordion.defaults =
      active: 0,
      classActiveItem:  "ui-active-state",
      classDefaultItem: "ui-default-state"
    
  plugin_constructor= (options) ->
    opts = jQuery.extend {}, jQuery.fn.accordion.defaults, options

    activate_section = (section) ->
      manipulate_section section, true
  
    deactivate_section = (section) ->
      manipulate_section section, false
    
    manipulate_section = (section, expression) ->
      section = $ section
      section.toggleClass(opts.classActiveItem, expression).
              toggleClass(opts.classDefaultItem, !expression).
              children(':odd').
              toggle(expression)


    this.each () ->
      $this = $(@)
      $sections = $this.children()
      
      $sections.addClass opts.classDefaultItem
      deactivate_section $sections
      
      $sections.children(":even").click () ->
        section = $(@).parent()
        if(!section.hasClass(opts.classActiveItem))
          deactivate_section section.siblings()
          activate_section section
        false
      
      activate_section $sections.get(opts.active)

jQuery ->
  new Accordion
    
