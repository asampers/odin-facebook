module OrderableByPopularity
  extend ActiveSupport::Concern

  included do
    scope :popular, -> { where.not(reactions_count: nil).order(reactions_count: :desc).limit(5)}
  end
end