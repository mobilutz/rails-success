class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags

  # NOTE: The sort_index is depended and the data from USER not POST!!!
  SELECTS = Arel.sql(
    <<~SQL.squish
      posts.*,
      CASE users.order
      WHEN 5 THEN 0
      WHEN 4 THEN 1
      WHEN 3 THEN 2
      WHEN 2 THEN 3
      WHEN 1 THEN 4
      WHEN 0 THEN 5
      ELSE 1000
      END as sort_index
    SQL
  )

  ORDER = Arel.sql('sort_index')
end
