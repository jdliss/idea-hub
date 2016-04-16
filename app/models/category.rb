class Category < ActiveRecord::Base
  has_many :ideas

  validates_presence_of :name
end
