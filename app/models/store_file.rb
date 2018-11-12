class StoreFile < ApplicationRecord
  after_create :set_last_recently_false
  belongs_to :user
  belongs_to :client

  validates :client,       presence: true
  validates :path,         presence: true
  validates :inspect_time, presence: true

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  
  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end

  def slug_candidates
    [
      [client.name, client.city.name, :inspect_time],
      [client.name, client.city.name, :inspect_time, :version]
    ]
  end

  # 将上个最新设置为false
  def set_last_recently_false
    lr = get_last_recently.first
    return if lr.nil?

    lr.update_attribute(:recently, false)
  end

  # 获取上一个最新
  def get_last_recently
    StoreFile.where('client_id = :client_id AND inspect_time = :inspect_time AND recently = :recently AND id != :id',
                    client_id:    client.id,
                    inspect_time: inspect_time,
                    recently:     true,
                    id:           id
                   )
  end

  # 返回所有同地市和巡检时间的历史版本
  def history
    StoreFile.where('client_id = :client_id AND inspect_time = :inspect_time',
                    client_id:       client_id,
                    inspect_time: inspect_time,
                   )
  end

  class << self

    # 返回所有客户和地市
    def client_and_location_group
      StoreFile.select(:client, :locate).distinct
    end

  end

end
