class Category < ActiveRecord::Base
  has_many :ideas
  validates_presence_of :name

  after_initialize :init

  def init
    self.image ||= Fotofetch::Fetch.new.fetch_links(self.name).values.pop
  end
end
