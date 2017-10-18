class Wiki < ApplicationRecord
  extend FriendlyId
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  friendly_id :title, use: :slugged
  
  private
    def should_generate_new_friendly_id?
      slug.blank? || title_changed?
    end
end
