class AddLastNameToCustomers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    add_column :customers, :last_name, :citext
  end
end
