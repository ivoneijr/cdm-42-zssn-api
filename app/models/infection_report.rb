class InfectionReport < ApplicationRecord
  belongs_to :reporter, class_name: "Survivor", foreign_key: 'reporter_id'
  belongs_to :infected, class_name: "Survivor", foreign_key: 'infected_id'

  before_create :verify_infectation

  def verify_infectation
    survivor = Survivor.find(self.infected_id)
    survivor.update!(infected: true) if InfectionReport.where(infected_id: survivor.id).count == 3 
  end

end
