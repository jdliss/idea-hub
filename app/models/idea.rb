require 'fotofetch'

class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  def image
    links = Fotofetch::Fetch.new.fetch_links(self.title)
    links.values.pop
  end
end
