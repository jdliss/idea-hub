require 'fotofetch'

class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates_presence_of :title
  after_initialize :init

  def init
    self.image ||= Fotofetch::Fetch.new.fetch_links(self.title).values.pop
  end
end
