module "initialize",
  setup: () ->
    @subject = $('.accordion-wrapper')
  teardown: () ->
    $('.accordion-header').attr class: "accordion-header"
    $('.accordion-header div').show()
    

test "should added plugin to jQuery", () ->
  ok @subject.accordion(), "Plugin loaded"
  
test "should show only first section", () ->
  expect 4
  equal $(".accordion-header > *:visible").length, 10, "Show all sections by default"
  @subject.accordion()
  equal $(".accordion-header > *:visible").length, 6, "Show only headers and active body"
  equal $('.ui-active-state').length, 1, "Should have active item"
  equal $('.ui-active-state').parent().children().index($('.ui-active-state')), 0, "Should be first one"
  
test "should toggle active section", () ->
  expect 4
  @subject.accordion()
  equal $('.ui-active-state').parent().children().index($('.ui-active-state')), 0, "Should be first one"
  equal $(".accordion-header:first > div:visible").length, 1, "Content for first item should be hidden"
  $('.ui-default-state:first > *:first').click()
  equal $('.ui-active-state').parent().children().index($('.ui-active-state')), 1, "Should be second"
  equal $(".accordion-header:first > div:visible").length, 0, "Content for first item should be hidden"

module "options",
  teardown: () ->
    $('.accordion-header').attr class: "accordion-header"
    $('.accordion-header div').show()
    
test 'should activate third item', ()->
  $('.accordion-wrapper').accordion({active: 2})
  equal $('.ui-active-state').parent().children().index($('.ui-active-state')), 2, "Should be third one"
  
test 'should set class accordion active for current item', ()->
  $('.accordion-wrapper').accordion({classActiveItem: 'accordion-active'})
  equal $('.ui-active-state').length, 0, "Should not find any items with default class"
  equal $('.accordion-active').length, 1, "Should set a new class"

test 'should set class accordion default for other items', ()->
  $('.accordion-wrapper').accordion({classDefaultItem: 'accordion-default'})
  equal $('.ui-default-state').length, 0, "Should not find any items with default class"
  equal $('.accordion-default').length, 4, "Should set a new class"

