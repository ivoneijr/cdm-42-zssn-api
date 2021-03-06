# == Schema Information
#
# Table name: survivors
#
#  id             :integer          not null, primary key
#  name           :string
#  age            :integer
#  gender         :string(1)
#  last_latitude  :string
#  last_longitude :string
#  infected       :boolean          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Survivor < ApplicationRecord
  include Concerns::SurvivorItemSwapSupport

  has_many :reporter_from, class_name: 'InfectionReport', foreign_key: 'reporter_id'
  has_many :infected_from, class_name: 'InfectionReport', foreign_key: 'infected_id'
  has_many :inventories
  has_many :items, through: :inventories

  accepts_nested_attributes_for :inventories

  scope :infected, -> { where(infected: true) }
  scope :not_infected, -> { where(infected: false) }

  attr_accessor :swap_items
  attr_accessor :swap_items_new
  attr_accessor :swap_points

  validates :name, :age, :gender, :last_latitude, :last_longitude, presence: true, on: :create
  validates :last_latitude, :last_longitude, presence: true, on: :update

  def update_location(survivor_params)
    self.update!(last_latitude: survivor_params[:last_latitude], last_longitude: survivor_params[:last_longitude])
  end

  def report_infection(infected_survivor_id)
    if infected_survivor = Survivor.find_by_id(infected_survivor_id)
      InfectionReport.create!(reporter: self, infected: infected_survivor)
    else
      errors.add(:reported_survivor, "Reported survivor with id #{infected_survivor_id} was not found.")
      return false
    end
  end

  def total_points
    total = 0
    inventories.each { |i| total = total + i.total_points }
    total
  end

  #TODO: need refactor
  def remove_proposed_items
    swap_items.each do |si|
      inventories.each do |inventory|
        if inventory.item_id == si[:id].to_i
          actual_quantity = inventory.quantity
          new_quantity = si[:quantity].to_i

          inventory.update!(quantity: actual_quantity - new_quantity) if actual_quantity > new_quantity
          inventory.destroy! if actual_quantity == new_quantity
        end
      end
    end
  end

  #TODO: need refactor
  def add_or_update_new_items
    swap_items_new.each do |si|
      add = true
      inventories.each do |inventory|
        if inventory.item_id == si[:id].to_i
          add = false
          actual_quantity = inventory.quantity
          new_quantity = si[:quantity].to_i

          inventory.update!(quantity: actual_quantity + new_quantity) if actual_quantity < new_quantity
        end

      end
      Inventory.create(quantity: si[:quantity].to_i, item_id: si[:id].to_i, survivor: self) if add
    end
  end

end
