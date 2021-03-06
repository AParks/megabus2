class User < ActiveRecord::Base
has_many :authorizations
has_many :trips
validates :name, :email, :presence => true
attr_accessible :name, :email

#def add_provider(auth_hash)
  # Check if the provider already exists, so we don't add it twice
#  unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
 #   Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
#  end
#end

 def self.create_with_omniauth(auth)
   create! do |user|
     user.provider = auth["provider"]
     user.uid = auth["uid"]
     user.name = auth["user_info"]["name"]
   end
 end

end
