(function() {

  window.Menu = (function() {

    function Menu(items, title, parent) {
      var $this, subitems, subtitle, _i, _len;
      this.title = title;
      this.parent = parent;
      $this = this;
      this.items = [];
      switch (typeof items) {
        case "string":
          this.items = [new Menu(void 0, items, $this)];
          break;
        case "undefined":
          [];
          break;
        default:
          if (items instanceof Array) {
            for (_i = 0, _len = items.length; _i < _len; _i++) {
              subtitle = items[_i];
              this.items.push(new Menu(void 0, subtitle, $this));
            }
          } else {
            this.items = (function() {
              var _results;
              _results = [];
              for (subtitle in items) {
                subitems = items[subtitle];
                _results.push(new Menu(subitems, subtitle, $this));
              }
              return _results;
            })();
          }
      }
    }

    Menu.prototype.size = function() {
      return this.items.length;
    };

    Menu.prototype.is_leaf = function() {
      return this.items.length === 0;
    };

    return Menu;

  })();

}).call(this);
