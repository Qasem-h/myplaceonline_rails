class AddIconToPassword < ActiveRecord::Migration
  def change
    set_icon("passwords", "famfamfam/textfield_key.png")
  end

  def set_icon(name, icon)
    c = Category.where(name: name).first
    c.icon = icon
    c.save!
  end
end
