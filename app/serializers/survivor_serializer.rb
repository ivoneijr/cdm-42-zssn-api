class SurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :gender, :last_latitude, :last_longitude, :infected, :total_points
  has_many :inventories, unless: :infected?
  
  
  
  
  
  class InventorySerializer < ActiveModel::Serializer
    attributes :id, :quantity, :item
  end

  def infected?
    object.infected
  end

  def total_points
    #TODO: 
  end
end
