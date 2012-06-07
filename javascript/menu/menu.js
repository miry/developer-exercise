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
      this.title = title;
      this.parent = parent;
      this.items = init_items(this, items);
    }

    Menu.prototype.size = function() {
      return this.items.length;
    };

    Menu.prototype.is_leaf = function() {
      return this.items.length === 0;
    };

    Menu.prototype.draw = function() {
      var result;
      result = $("<a class='menu_item' href='#'>" + this.title + "</a>");
      result.data("menu-item", this);
      return result;
    };

    Menu.draw_list = function(scope, root) {
      var item, _i, _len, _ref, _results;
      scope.html("");
      _ref = root.items;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        _results.push(scope.append(item.draw()));
      }
      return _results;
    };

    Menu.bindings = function() {
      return $("#menu .menu_item").live('click', function() {
        return this.draw_list([]);
      });
    };

    Menu.init_jquery_plugin = function(options) {
      var _this = this;
      console.log(new Menu(options));
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
