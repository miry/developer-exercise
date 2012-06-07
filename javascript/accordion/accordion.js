(function() {
  var Accordion;

  Accordion = (function() {
    var activate_section, deactivate_section, manipulate_section, plugin_constructor;

    function Accordion() {
      this.init_jquery_plugin();
    }

    Accordion.prototype.init_jquery_plugin = function() {
      jQuery.fn.accordion = plugin_constructor;
      return jQuery.fn.accordion.defaults = {
        active: 0
      };
    };

    plugin_constructor = function(options) {
      var opts;
      opts = jQuery.extend({}, jQuery.fn.accordion.defaults, options);
      return this.each(function() {
        var $sections, $this;
        $this = $(this);
        $sections = $this.children();
        $sections.addClass("ui-default-state");
        deactivate_section($sections);
        $sections.children(":even").click(function() {
          var section;
          section = $(this).parent();
          deactivate_section(section.siblings());
          activate_section(section);
          return false;
        });
        return activate_section($sections.get(opts.active));
      });
    };

    activate_section = function(section) {
      return manipulate_section(section, true);
    };

    deactivate_section = function(section) {
      return manipulate_section(section, false);
    };

    manipulate_section = function(section, expression) {
      section = $(section);
      return section.toggleClass("ui-active-state", expression).toggleClass("ui-default-state", !expression).children(':odd').toggle(expression);
    };

    return Accordion;

  })();

  jQuery(function() {
    return new Accordion;
  });

}).call(this);
