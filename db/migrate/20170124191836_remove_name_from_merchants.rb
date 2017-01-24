class RemoveNameFromMerchants < ActiveRecord::Migration[5.0]
  def change
    remove_column :merchants, :name, :string
  end
end
