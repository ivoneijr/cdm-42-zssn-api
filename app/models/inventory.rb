# == Schema Information
#
# Table name: inventories
#
#  id          :integer          not null, primary key
#  quantity    :integer
#  item_id     :integer
#  survivor_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Inventory < ApplicationRecord
  belongs_to :item
  belongs_to :survivor

  def total_points
    quantity * item.points
  end
end
