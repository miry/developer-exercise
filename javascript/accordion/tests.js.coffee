module "initialize",
  setup: () ->
    @subject = $('.accordion-wrapper')
  teardown: () ->
    $('.accordion-header').attr class: "accordion-header"
    $('.accordion-header div').show()
    $('.accordion-header div').attr style: ""
    

test "should added plugin to jQuery", () ->
  ok @subject.accordion(), "Plugin loaded"
  
test "should show only first section", () ->
  expect 4
  equal $(".accordion-header > *:visible").length, 10, "Show all sections by default"

  stop()
  @subject.accordion()
  
  state = ->
    start()
    equal $(".accordion-header > *:visible").length, 6, "Show only headers and active body"
    equal $('.ui-active-state').length, 1, "Should have active item"
    equal $('.ui-active-state').parent().children().index($('.ui-active-state')), 0, "Should be first one"
    
  setTimeout state, 500    
  
test "should toggle active section", () ->
  expect 4
  @subject.accordion()
  equal $('.ui-active-state').parent().children().index($('.ui-active-state')), 0, "Should be first one"
  equal $(".accordion-header:first > div:visible").length, 1, "Content for first item should be hidden"
  stop()
  $('.ui-default-state:first > *:first').click()
  state = ->
    start()
    equal $('.ui-active-state').parent().children().index($('.ui-active-state')), 1, "Should be second"
    equal $(".accordion-header:first > div").css('overflow-y'), "hidden", "Content for first item should be hidden"
    
  setTimeout state, 500

test 'should activate third item', ()->
  @subject.accordion({active: 2})
  equal $('.ui-active-state').parent().children().index($('.ui-active-state')), 2, "Should be third one"
  
test 'should set class accordion active for current item', ()->
  @subject.accordion({classActiveItem: 'accordion-active'})
  equal $('.ui-active-state').length, 0, "Should not find any items with default class"
  equal $('.accordion-active').length, 1, "Should set a new class"

test 'should set class accordion default for other items', ()->
  @subject.accordion({classDefaultItem: 'accordion-default'})
  equal $('.ui-default-state').length, 0, "Should not find any items with default class"
  equal $('.accordion-default').length, 4, "Should set a new class"

