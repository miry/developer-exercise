module "initialize",
	setup: () ->
		@subject = $('.accordion-wrapper')

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
		
test 'should activate third item', ()->
	$('.accordion-wrapper').accordion({active: 2})
	equal $('.ui-active-state').parent().children().index($('.ui-active-state')), 2, "Should be third one"