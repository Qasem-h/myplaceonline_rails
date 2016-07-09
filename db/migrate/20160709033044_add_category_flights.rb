class AddCategoryFlights < ActiveRecord::Migration
  def change
    Category.create(name: "flights", link: "flights", position: 0, parent: Category.find_by_name("order"), icon: "FatCow_Icons16x16/plane.png")
  end
end
