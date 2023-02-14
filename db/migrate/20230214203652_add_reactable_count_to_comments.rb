class AddReactableCountToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :reactions_count, :integer
  end
end
