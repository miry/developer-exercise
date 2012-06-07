class window.Menu
  constructor: (items, title, parent) ->
    @title = title
    @parent = parent
    $this = @
    @items = []
    
    switch typeof(items)
      when "string" then @items = [new Menu(undefined, items, $this)]
      when "undefined" then []
      else
        if(items instanceof Array)
          @items.push(new Menu(undefined, subtitle, $this)) for subtitle in items
        else
          @items = for subtitle, subitems of items
            new Menu(subitems, subtitle, $this)
    
  size: ()->
    @items.length
    
  is_leaf: ()->
    @items.length == 0
