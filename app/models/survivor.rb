class Survivor < ApplicationRecord
  has_many :reporter_from, class_name: 'InfectionReport', foreign_key: 'reporter_id'
  has_many :infected_from, class_name: 'InfectionReport', foreign_key: 'infected_id'
  has_many :inventories

  alias_attribute :inventory, :inventories

  def update_location(survivor_params)
    self.update(last_latitude: survivor_params[:last_latitude], last_longitude: survivor_params[:last_longitude])
  end
  
  def report_infection(infected_survivor_id)
    if infected_survivor = Survivor.find_by_id(infected_survivor_id)
      InfectionReport.create(reporter: self, infected: infected_survivor) 
    else
      errors.add(:reported_survivor, "Reported survivor with id #{infected_survivor_id} was not found.")
      return false
    end
  end
end
