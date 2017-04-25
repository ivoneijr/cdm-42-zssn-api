# == Schema Information
#
# Table name: infection_reports
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  reporter_id :integer
#  infected_id :integer
#
require 'rails_helper'

describe Survivor do
  describe 'on create' do

    let!(:bruce) { Survivor.create({ name: "Bruce Banner", age: 26, gender: "M", last_latitude: "444444", last_longitude: "4445454.332" }) }
    let!(:tony) { Survivor.create({ name: "Tony Stark", age: 26, gender: "M", last_latitude: "55555", last_longitude: "4445454.332" }) }

    it 'should be change infected flag in survivor on 3th report' do
      InfectionReport.create(reporter: bruce, infected: tony)
      expect(tony.reload.infected).to be_falsey

      InfectionReport.create(reporter: bruce, infected: tony)
      expect(tony.reload.infected).to be_falsey

      InfectionReport.create(reporter: bruce, infected: tony)
      expect(tony.reload.infected).to be_truthy
    end
  end
end