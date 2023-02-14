class PopulateCommentReactableCount < ActiveRecord::Migration[7.0]
  def up
    Comment.find_each do |comment|
      Comment.reset_counters(comment.id, :reactions)
    end
  end
end
