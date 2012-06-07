(function() {

  module("initialize", {
    setup: function() {
      return this.subject = $('.accordion-wrapper');
    },
    teardown: function() {
      $('.accordion-header').attr({
        "class": "accordion-header"
      });
      $('.accordion-header div').show();
      return $('.accordion-header div').attr({
        style: ""
      });
    }
  });

  test("should added plugin to jQuery", function() {
    return ok(this.subject.accordion(), "Plugin loaded");
  });

  test("should show only first section", function() {
    var state;
    expect(4);
    equal($(".accordion-header > *:visible").length, 10, "Show all sections by default");
    stop();
    this.subject.accordion();
    state = function() {
      start();
      equal($(".accordion-header > *:visible").length, 6, "Show only headers and active body");
      equal($('.ui-active-state').length, 1, "Should have active item");
      return equal($('.ui-active-state').parent().children().index($('.ui-active-state')), 0, "Should be first one");
    };
    return setTimeout(state, 500);
  });

  test("should toggle active section", function() {
    var state;
    expect(4);
    this.subject.accordion();
    equal($('.ui-active-state').parent().children().index($('.ui-active-state')), 0, "Should be first one");
    equal($(".accordion-header:first > div:visible").length, 1, "Content for first item should be hidden");
    stop();
    $('.ui-default-state:first > *:first').click();
    state = function() {
      start();
      equal($('.ui-active-state').parent().children().index($('.ui-active-state')), 1, "Should be second");
      return equal($(".accordion-header:first > div").css('overflow-y'), "hidden", "Content for first item should be hidden");
    };
    return setTimeout(state, 500);
  });

  test('should activate third item', function() {
    this.subject.accordion({
      active: 2
    });
    return equal($('.ui-active-state').parent().children().index($('.ui-active-state')), 2, "Should be third one");
  });

  test('should set class accordion active for current item', function() {
    this.subject.accordion({
      classActiveItem: 'accordion-active'
    });
    equal($('.ui-active-state').length, 0, "Should not find any items with default class");
    return equal($('.accordion-active').length, 1, "Should set a new class");
  });

  test('should set class accordion default for other items', function() {
    this.subject.accordion({
      classDefaultItem: 'accordion-default'
    });
    equal($('.ui-default-state').length, 0, "Should not find any items with default class");
    return equal($('.accordion-default').length, 4, "Should set a new class");
  });

}).call(this);
