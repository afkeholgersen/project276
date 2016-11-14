user1 = User.new(username: "dave", email: "dave@example.com")
user1.build_preference
user1.save!

recipe1 = user1.recipes.build(recipe_id: "../recipes/001")
recipe1.save!


user2 = User.new(username: "johnny", email: "john@example.com")
user2.build_preference
user2.save!

recipe2 = user2.recipes.build(recipe_id: "../recipes/002")
recipe2.save!