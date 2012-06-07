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
    @title = title || ""
    @parent = parent
    @items = init_items @, items
    
  size: ()->
    @items.length
    
  is_leaf: ()->
    @items.length == 0
    
  is_root: ()->
    typeof(@parent) == 'undefined'

  draw: (rel)->
    result = $("<a class='menu' href='#'>#{@title}</a>")
    result.data("menu-item", rel || @)
    result
    
  @draw_list = (scope, root)->
    scope.html("")
    for item in root.items
      scope.append item.draw()
    
    if(!root.is_root())
      back_item = root.draw(root.parent)
      back_item.text("back")
      scope.append back_item
  
  @bindings = ()->
    $("a.menu").live 'click', ()->
      $this = $(@)
      if($this.data("menu-item") && !$this.data("menu-item").is_leaf())
        Menu.draw_list $(@).parent(), $this.data("menu-item")
      
  @init_jquery_plugin = (options)->
    Menu.bindings()
    @.each () => 
      Menu.draw_list $(@), new Menu(options)
    
jQuery ->
  jQuery.fn.menu = Menu.init_jquery_plugin
    