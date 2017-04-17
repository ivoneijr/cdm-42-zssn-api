class Survivor < ApplicationRecord
  has_many :reporter_from, class_name: 'InfectionReport', foreign_key: 'reporter_id'
  has_many :infected_from, class_name: 'InfectionReport', foreign_key: 'infected_id'
  has_many :inventories

  def update_location(survivor_params)
    self.update(last_latitude: survivor_params[:last_latitude], last_longitude: survivor_params[:last_longitude])
  end

  def serialize
    return self if infected
    
    self.as_json({include:[inventories: { only: [:id, :quantity], include: [:item] }]})
  end
end
