class MakeSenderReferenceNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:notifications, :sender_id, false)
  end
end
