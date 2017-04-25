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

require 'rails_helper'

describe Survivor do

  describe 'on create' do
    it 'validade presence name' do
      expect {
        Survivor.create!(age: 12, gender: 'M', last_latitude: '123123', last_longitude: '123123')
      }.to raise_error /Validation failed: Name can't be blank/i
    end

    it 'validade presence age' do
      expect {
        Survivor.create!(name: 'Harry Potter', gender: 'M', last_latitude: '123123', last_longitude: '123123')
      }.to raise_error /Validation failed: Age can't be blank/i
    end

    it 'validade presence gender' do
      expect {
        Survivor.create!(name: 'Harry Potter', age: 12, last_latitude: '123123', last_longitude: '123123')
      }.to raise_error /Validation failed: Gender can't be blank/i
    end

    it 'validade presence last_latitude' do
      expect {
        Survivor.create!(name: 'Harry Potter', gender: 'M', age: 12, last_longitude: '123123')
      }.to raise_error /Validation failed: Last latitude can't be blank/i
    end

    it 'validade presence last_longitude' do
      expect {
        Survivor.create!(name: 'Harry Potter', gender: 'M', age: 12, last_latitude: '123123')
      }.to raise_error /Validation failed: Last longitude can't be blank/i
    end
  end

  describe 'on update' do
    it 'validate presence last_latitude and last_longitude' do
      harry = Survivor.create!(name: 'Harry Potter', age: 12, gender: 'M', last_latitude: '123123', last_longitude: '123123')
      expect {
        harry.update!(name: 'Harry Porco', last_latitude: nil, last_longitude: nil)
      }.to raise_error /Validation failed: Last latitude can't be blank, Last longitude can't be blank/i
    end
  end

end