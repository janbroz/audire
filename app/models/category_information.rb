class CategoryInformation
  include Mongoid::Document

  field :name, type: String
  field :url, type: String

  validates :name, :url, presence: true
end
