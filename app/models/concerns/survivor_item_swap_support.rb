#
# Survivor Item Swap Support
#
# Uses a virtual properties #swap_items and #swap_points to Survivors instances,
# to make validation when two survivors wants make a item trade. (items_controller#trade)
#
module Concerns
  module SurvivorItemSwapSupport
    extend ActiveSupport::Concern

    included do
      has_many :inventories
      scope :infected, -> { where(infected: true) }

      attr_accessor :swap_items
      attr_accessor :swap_points
    end

    def can_trade?
      return true unless self.infected
      errors.add(:can_not_trade, "#{ name } can't make trades, survivor INFECTED.")
      false
    end

    def sum_points
      swap_items.each do |i|
        item = Item.find(i[:id])
        self.swap_points = 0 unless self.swap_points
        self.swap_points += (i[:quantity] * item.points)
      end
    end

    def have_all_swap_items?
      occurrences = []
      swap_items.each do |swap_item|
        have_item = false

        self.inventories.each do |inventory|
          have_item = true if inventory.item_id == swap_item[:id]
        end

        occurrences.push have_item
      end

      (occurrences.count == swap_items.count) ? true : false
    end

  end
end
