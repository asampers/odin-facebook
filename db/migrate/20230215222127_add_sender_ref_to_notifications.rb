class AddSenderRefToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_reference :notifications, :sender, references: :users
  end
end
