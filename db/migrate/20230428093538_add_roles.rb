class AddRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.string :role
    end

  Role.create(role: "admin")
  Role.create(role: "employee")
  Role.create(role: "visitor")
  end
end
