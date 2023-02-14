class PopulatePostReactionsCount < ActiveRecord::Migration[7.0]
  def up
    Post.find_each do |post|
      Post.reset_counters(post.id, :reactions)
    end
  end
end
