(function() {

  module("initialize", {
    setup: function() {
      return this.subject = $('.accordion-wrapper');
    }
  });

  test("should added plugin to jQuery", function() {
    return ok(this.subject.accordion(), "Plugin loaded");
  });

  test("should show only first section", function() {
    expect(4);
    equal($(".accordion-header > *:visible").length, 10, "Show all sections by default");
    this.subject.accordion();
    equal($(".accordion-header > *:visible").length, 6, "Show only headers and active body");
    equal($('.ui-active-state').length, 1, "Should have active item");
    return equal($('.ui-active-state').parent().children().index($('.ui-active-state')), 0, "Should be first one");
  });

  test("should toggle active section", function() {
    expect(4);
    this.subject.accordion();
    equal($('.ui-active-state').parent().children().index($('.ui-active-state')), 0, "Should be first one");
    equal($(".accordion-header:first > div:visible").length, 1, "Content for first item should be hidden");
    $('.ui-default-state:first > *:first').click();
    equal($('.ui-active-state').parent().children().index($('.ui-active-state')), 1, "Should be second");
    return equal($(".accordion-header:first > div:visible").length, 0, "Content for first item should be hidden");
  });

  module("options", test('should activate third item', function() {
    $('.accordion-wrapper').accordion({
      active: 2
    });
    return equal($('.ui-active-state').parent().children().index($('.ui-active-state')), 2, "Should be third one");
  }));

}).call(this);
