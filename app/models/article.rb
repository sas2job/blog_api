# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  validates :title, :body, presence: true
  validates :title, length: { maximum: 100 }

  scope :sort_by_date, -> { order(created_at: :desc) }
end
