class Style < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  has_many :items
  belongs_to :type

  def min_price
    1
  end

end
