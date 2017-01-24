class AddNameToMerchants < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'
    
    add_column :merchants, :name, :citext
  end
end
