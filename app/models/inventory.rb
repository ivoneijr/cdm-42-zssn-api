class Inventory < ApplicationRecord
  belongs_to :item
  belongs_to :survivor

  def total_points
    quantity * item.points
  end
end
