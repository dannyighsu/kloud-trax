class Directory < ActiveRecord::Base

    belongs_to :account
    has_many :track

end
