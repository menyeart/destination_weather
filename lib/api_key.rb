module ApiKey
  def self.generator
    SecureRandom.base58(24)
  end
end
