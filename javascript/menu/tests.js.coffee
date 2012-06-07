module "initialize",
  setup: () ->
    @fixtures ={"study":{"reading_material":["Orientation","Math","Verbal","Writing"],"flashcards":"Flashcards","bookmarks":"Bookmarks","notes":"Notes"},"practice":{"flashcards":"Flashcards","quizzes":"Quizzes","performance":"Overall Performance"},"test":{"tests":"Tests","reports":"Reports"}}
    @root_item = new Menu(@fixtures)

  teardown: () ->
    console.log "teardown"

test "should load models", () ->
  ok @root_item, "Plugin loaded"

test "should have 3 root items", () ->
  @root_item = new Menu(@fixtures)
  equal @root_item.size(), 3, "Init 3  menu items"
  equal typeof(@root_item.title), "undefined", "Root item does not have title"
  equal typeof(@root_item.parent), "undefined", "Root item does not have parent"
  
test "shoud show sub items", () ->
  sub_item = @root_item.items[0]
  equal sub_item.title, "study", "Get access to sub item title"
  equal sub_item.items[0].title, "reading_material", "Should show title of sub sub item"
  
test "should init leaf", () ->
  leaf = new Menu(undefined, "title", @root_item)
  ok leaf.is_leaf(), "Get state of the menu item"
  
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
