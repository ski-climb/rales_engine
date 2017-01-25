class AddFirstNameToCustomers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    add_column :customers, :first_name, :citext
  end
end
