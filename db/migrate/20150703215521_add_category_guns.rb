class AddCategoryGuns < ActiveRecord::Migration
  def change
    Category.create(name: "guns", link: "guns", position: 0, parent: Category.find_by_name("order"), icon: "FatCow_Icons16x16/gun.png")
  end
end
