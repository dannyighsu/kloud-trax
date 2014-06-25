class Track < ActiveRecord::Base

  belongs_to :account
  belongs_to :directory
  has_and_belongs_to_many :playlist

end
