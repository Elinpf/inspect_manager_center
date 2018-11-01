class Rand
  Letter = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'

  class << self
    def base64
      (1...20).map { Letter[rand(Letter.size)] }.join
    end
  end
end

