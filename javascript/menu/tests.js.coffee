module "initialize",
  setup: () ->
    @fixtures ={"study":{"reading_material":["Orientation","Math","Verbal","Writing"],"flashcards":"Flashcards","bookmarks":"Bookmarks","notes":"Notes"},"practice":{"flashcards":"Flashcards","quizzes":"Quizzes","performance":"Overall Performance"},"test":{"tests":"Tests","reports":"Reports"}}
    @root_item = new Menu(@fixtures)

test "should load models", () ->
  ok @root_item, "Plugin loaded"

test "should have 3 root items", () ->
  @root_item = new Menu(@fixtures)
  equal @root_item.size(), 3, "Init 3  menu items"
  equal typeof(@root_item.parent), "undefined", "Root item does not have parent"
  
test "shoud show sub items", () ->
  sub_item = @root_item.items[0]
  equal sub_item.title, "study", "Get access to sub item title"
  equal sub_item.items[0].title, "reading_material", "Should show title of sub sub item"
  
test "should init leaf", () ->
  leaf = new Menu(undefined, "title", @root_item)
  ok leaf.is_leaf(), "Get state of the menu item"

test "should init root", () ->
  ok !@root_item.is_leaf(), "Should be root"
  ok @root_item.is_root(), "Should be root"
  
test "should create 3 sub items via array", () ->
  item = new Menu(["Sub1", "Sub2", "Sub3"], "title", @root_item)
  equal item.size(), 3, "Should have 3 items"
  equal item.items[0].parent, item, "Should have parent"
  equal item.items[0].is_leaf(), true, "Should be leaf"
  equal item.items[0].title, "Sub1", "Should be have title Sub1"
  
test "should create item with title", () ->
  item = new Menu("Sub1", "title", @root_item)
  equal item.size(), 1, "Should have 1 item"
  equal item.items[0].parent, item, "Should have parent"
  equal item.items[0].is_leaf(), true, "Should be leaf"
  equal item.items[0].title, "Sub1", "Should be have title Sub1"

test "should create only root with one item by string", () ->
  item = new Menu("root1")
  equal item.items[0].title, "root1", "Should have title"
  ok item.draw(), "Should draw own self"
  
module "effects",
  setup: () ->
    @scope = $("#menu")
    @fixtures ={"study":{"reading_material":["Orientation","Math","Verbal","Writing"],"flashcards":"Flashcards","bookmarks":"Bookmarks","notes":"Notes"},"practice":{"flashcards":"Flashcards","quizzes":"Quizzes","performance":"Overall Performance"},"test":{"tests":"Tests","reports":"Reports"}}

  teardown: () ->
    @scope.html("")
    
test "should show menu items on load", ()->
  equal @scope.text().trim(), "", "Should be empty"
  @scope.menu()
  equal @scope.text().trim(), "", "Should be empty"
  @scope.menu("root1")
  equal @scope.text().trim(), "root1", "Should not be empty after init menu"
  @scope.menu(["root0", "root1"])
  equal @scope.find("a:first").text().trim(), "root0", "Should not be empty after init menu"
  equal @scope.find("a:last").text().trim(), "root1", "Should not be empty after init menu"
  @scope.menu(@fixtures)
  equal @scope.find("a:first").text().trim(), "study", "Should not be empty after init menu"
  equal @scope.find("a:last").text().trim(), "test", "Should not be empty after init menu"
  
test "should show submenu items", ()->
  @scope.menu(@fixtures)
  @scope.find("a:first").click()
  equal @scope.find("a:first").text().trim(), "reading_material", "Should show submenu item of study"

test "should show back link", ()->
  @scope.menu(@fixtures)
  @scope.find("a:first").click()
  equal @scope.find("a:last").text().trim(), "back", "Should show back item"
  