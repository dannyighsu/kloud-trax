class User < ActiveRecord::Base

  has_many :account
  has_many :playlist

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["username"]
    end
  end

end
