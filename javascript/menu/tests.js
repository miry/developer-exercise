(function() {

  module("initialize", {
    setup: function() {
      this.fixtures = {
        "study": {
          "reading_material": ["Orientation", "Math", "Verbal", "Writing"],
          "flashcards": "Flashcards",
          "bookmarks": "Bookmarks",
          "notes": "Notes"
        },
        "practice": {
          "flashcards": "Flashcards",
          "quizzes": "Quizzes",
          "performance": "Overall Performance"
        },
        "test": {
          "tests": "Tests",
          "reports": "Reports"
        }
      };
      return this.root_item = new Menu(this.fixtures);
    }
  });

  test("should load models", function() {
    return ok(this.root_item, "Plugin loaded");
  });

  test("should have 3 root items", function() {
    this.root_item = new Menu(this.fixtures);
    equal(this.root_item.size(), 3, "Init 3  menu items");
    equal(typeof this.root_item.title, "undefined", "Root item does not have title");
    return equal(typeof this.root_item.parent, "undefined", "Root item does not have parent");
  });

  test("shoud show sub items", function() {
    var sub_item;
    sub_item = this.root_item.items[0];
    equal(sub_item.title, "study", "Get access to sub item title");
    return equal(sub_item.items[0].title, "reading_material", "Should show title of sub sub item");
  });

  test("should init leaf", function() {
    var leaf;
    leaf = new Menu(void 0, "title", this.root_item);
    return ok(leaf.is_leaf(), "Get state of the menu item");
  });

  test("should create 3 sub items via array", function() {
    var item;
    item = new Menu(["Sub1", "Sub2", "Sub3"], "title", this.root_item);
    equal(item.size(), 3, "Should have 3 items");
    equal(item.items[0].parent, item, "Should have parent");
    equal(item.items[0].is_leaf(), true, "Should be leaf");
    return equal(item.items[0].title, "Sub1", "Should be have title Sub1");
  });

  test("should create item with title", function() {
    var item;
    item = new Menu("Sub1", "title", this.root_item);
    equal(item.size(), 1, "Should have 1 item");
    equal(item.items[0].parent, item, "Should have parent");
    equal(item.items[0].is_leaf(), true, "Should be leaf");
    return equal(item.items[0].title, "Sub1", "Should be have title Sub1");
  });

  test("should create only root with one item by string", function() {
    var item;
    item = new Menu("root1");
    return equal(item.items[0].title, "root1", "Should have title");
  });

  module("effects", {
    setup: function() {
      this.scope = $("#menu");
      this.fixtures = {
        "study": {
          "reading_material": ["Orientation", "Math", "Verbal", "Writing"],
          "flashcards": "Flashcards",
          "bookmarks": "Bookmarks",
          "notes": "Notes"
        },
        "practice": {
          "flashcards": "Flashcards",
          "quizzes": "Quizzes",
          "performance": "Overall Performance"
        },
        "test": {
          "tests": "Tests",
          "reports": "Reports"
        }
      };
      return this.root_item = new Menu(this.fixtures);
    },
    teardown: function() {
      return this.scope.html("");
    }
  });

  test("should show menu items on load", function() {
    equal(this.scope.text().trim(), "", "Should be empty");
    this.scope.menu();
    equal(this.scope.text().trim(), "", "Should be empty");
    this.scope.menu("root1");
    equal(this.scope.text().trim(), "root1", "Should not be empty after init menu");
    this.scope.menu(["root0", "root1"]);
    return equal(this.scope.find("a:first").text().trim(), "root0", "Should not be empty after init menu");
  });

}).call(this);
