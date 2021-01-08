class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags

  SELECTS = Arel.sql(
    <<~SQL.squish
      posts.*,
      CASE posts.order
      WHEN 1 THEN 1
      ELSE 1000
      END as sort_index
    SQL
  )

  ORDER = Arel.sql('sort_index')
end
