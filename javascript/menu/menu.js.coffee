class window.Menu

  init_items = (self, items) ->
    switch typeof(items)
      when "string" then [new Menu(undefined, items, self)]
      when "undefined" then []
      else
        if(items instanceof Array)
          new Menu(undefined, subtitle, self) for subtitle in items
        else
          for subtitle, subitems of items
            new Menu(subitems, subtitle, self)
  
  constructor: (items, title, parent) ->
    @title = title
    @parent = parent
    @items = init_items @, items
    
  size: ()->
    @items.length
    
  is_leaf: ()->
    @items.length == 0

  draw: ()->
    result = $("<a class='menu_item' href='#'>#{@title}</a>")
    result.data("menu-item", @)
    result
      
  @draw_list = (scope, root)->
    scope.html("")
    for item in root.items
      scope.append item.draw()
  
  @bindings = ()->
    $("#menu .menu_item").live 'click', ()->
      @draw_list []
      
  @init_jquery_plugin = (options)->
    console.log new Menu(options)
    @.each () => 
      Menu.draw_list $(@), new Menu(options)
    
jQuery ->
  jQuery.fn.menu = Menu.init_jquery_plugin
    