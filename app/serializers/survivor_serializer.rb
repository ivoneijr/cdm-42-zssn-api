class SurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :gender, :last_latitude, :last_longitude, :infected, :inventory_points
  has_many :inventories, unless: :infected?
  
  
  
  
  
  class InventorySerializer < ActiveModel::Serializer
    attributes :id, :quantity, :item
  end

  def infected?
    object.infected
  end

  def inventory_points
    total = 0
    object.inventories.each do |i|
      total = total + i.total_points
    end
    total
  end
end
