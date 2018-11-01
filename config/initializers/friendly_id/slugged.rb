module FriendlyId
module Slugged
  def normalize_friendly_id(value)
    #Pinyin.t(value.to_s).parameterize
    value.to_s.to_slug.normalize.to_s
  end
end
end
