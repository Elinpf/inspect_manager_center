class StoreFile < ApplicationRecord
  belongs_to :user

  validates :client,       presence: true
  validates :path,         presence: true
  validates :locate,       presence: true
  validates :inspect_time, presence: true
end
