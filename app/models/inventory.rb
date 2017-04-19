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

  belongs_to :survivor, optional: true
  belongs_to :item, optional: true

  accepts_nested_attributes_for :item

  def total_points
    return 0 unless item
    quantity * item.points
  end
end
