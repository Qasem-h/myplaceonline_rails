class AddCategoryPasswords < ActiveRecord::Migration
  def change
    passwords = Category.create(name: "passwords", link: "passwords", position: 0, parent: Category.find_by_name("order"))
  end
end
