(function() {

  window.Menu = (function() {
    var init_items;

    init_items = function(self, items) {
      var subitems, subtitle, _i, _len, _results, _results1;
      switch (typeof items) {
        case "string":
          return [new Menu(void 0, items, self)];
        case "undefined":
          return [];
        default:
          if (items instanceof Array) {
            _results = [];
            for (_i = 0, _len = items.length; _i < _len; _i++) {
              subtitle = items[_i];
              _results.push(new Menu(void 0, subtitle, self));
            }
            return _results;
          } else {
            _results1 = [];
            for (subtitle in items) {
              subitems = items[subtitle];
              _results1.push(new Menu(subitems, subtitle, self));
            }
            return _results1;
          }
      }
    };

    function Menu(items, title, parent) {
      this.title = title || "";
      this.parent = parent;
      this.items = init_items(this, items);
    }

    Menu.prototype.size = function() {
      return this.items.length;
    };

    Menu.prototype.is_leaf = function() {
      return this.items.length === 0;
    };

    Menu.prototype.is_root = function() {
      return typeof this.parent === 'undefined';
    };

    Menu.prototype.draw = function(rel) {
      var result;
      result = $("<a class='menu' href='#'>" + this.title + "</a>");
      result.data("menu-item", rel || this);
      return result;
    };

    Menu.draw_list = function(scope, root) {
      var back_item, item, _i, _len, _ref;
      scope.html("");
      _ref = root.items;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        scope.append(item.draw());
      }
      if (!root.is_root()) {
        back_item = root.draw(root.parent);
        back_item.text("back");
        return scope.append(back_item);
      }
    };

    Menu.bindings = function() {
      return $("a.menu").live('click', function() {
        var $this;
        $this = $(this);
        if ($this.data("menu-item") && !$this.data("menu-item").is_leaf()) {
          return Menu.draw_list($(this).parent(), $this.data("menu-item"));
        }
      });
    };

    Menu.init_jquery_plugin = function(options) {
      var _this = this;
      Menu.bindings();
      return this.each(function() {
        return Menu.draw_list($(_this), new Menu(options));
      });
    };

    return Menu;

  })();

  jQuery(function() {
    return jQuery.fn.menu = Menu.init_jquery_plugin;
  });

}).call(this);
