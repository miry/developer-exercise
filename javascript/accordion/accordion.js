(function() {
  var Accordion;

  Accordion = (function() {
    var plugin_constructor;

    function Accordion() {
      this.init_jquery_plugin();
    }

    Accordion.prototype.init_jquery_plugin = function() {
      jQuery.fn.accordion = plugin_constructor;
      return jQuery.fn.accordion.defaults = {
        active: 0,
        classActiveItem: "ui-active-state",
        classDefaultItem: "ui-default-state"
      };
    };

    plugin_constructor = function(options) {
      var activate_section, deactivate_section, manipulate_section, opts;
      opts = jQuery.extend({}, jQuery.fn.accordion.defaults, options);
      activate_section = function(section) {
        return manipulate_section(section, true);
      };
      deactivate_section = function(section) {
        return manipulate_section(section, false);
      };
      manipulate_section = function(section, expression) {
        section = $(section);
        return section.toggleClass(opts.classActiveItem, expression).toggleClass(opts.classDefaultItem, !expression).children(':odd').toggle(expression);
      };
      return this.each(function() {
        var $sections, $this;
        $this = $(this);
        $sections = $this.children();
        $sections.addClass(opts.classDefaultItem);
        deactivate_section($sections);
        $sections.children(":even").click(function() {
          var section;
          section = $(this).parent();
          if (!section.hasClass(opts.classActiveItem)) {
            deactivate_section(section.siblings());
            activate_section(section);
          }
          return false;
        });
        return activate_section($sections.get(opts.active));
      });
    };

    return Accordion;

  })();

  jQuery(function() {
    return new Accordion;
  });

}).call(this);
