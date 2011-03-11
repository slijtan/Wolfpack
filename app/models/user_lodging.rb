class UserLodging < ActiveRecord::Base
  belongs_to :user
  belongs_to :lodging
end
