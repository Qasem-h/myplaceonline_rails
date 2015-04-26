class AddIconToHealth < ActiveRecord::Migration
  def change
    set_icon("health", "famfamfam/heart.png")
  end

  def set_icon(name, icon)
    c = Category.where(name: name).first
    c.icon = icon
    c.save!
  end
end
