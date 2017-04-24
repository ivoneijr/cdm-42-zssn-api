require 'rails_helper'

describe API::V1::SurvivorsController do

  describe 'GET index' do
    let!(:survivor) { Survivor.create({ name: 'Ivonei', age: 26, gender: 'M', last_latitude: '111111111', last_longitude: '4445454.332' }) }

    it 'should have only created survivor' do
      get :index
      parsed_body = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(parsed_body.length).to eq 1

      expect(parsed_body.first['id']).to eq survivor.id
      expect(parsed_body.first['name']).to eq survivor.name
      expect(parsed_body.first['age']).to eq survivor.age
      expect(parsed_body.first['gender']).to eq survivor.gender
      expect(parsed_body.first['last_latitude']).to eq survivor.last_latitude
      expect(parsed_body.first['last_longitude']).to eq survivor.last_longitude
    end
  end

  describe 'GET show' do
    let!(:survivor) { Survivor.create({ name: 'Batman', age: 26, gender: 'M', last_latitude: '111111111', last_longitude: '4445454.332' }) }

    it 'should have only created survivor' do
      get :show, id: survivor.id
      parsed_body = JSON.parse(response.body)

      expect(response.status).to eq 200

      expect(parsed_body['id']).to eq survivor.id
      expect(parsed_body['name']).to eq survivor.name
      expect(parsed_body['age']).to eq survivor.age
      expect(parsed_body['gender']).to eq survivor.gender
      expect(parsed_body['last_latitude']).to eq survivor.last_latitude
      expect(parsed_body['last_longitude']).to eq survivor.last_longitude
    end
  end

  describe 'POST create' do
    let!(:water) { Item.create({ description: 'water', points: 4 }) }
    let!(:jessica) {
      {
        survivor: {
            name: 'Jessica Jone',
            age: 32,
            gender: 'F',
            last_latitude: '66666',
            last_longitude: '66666',
            inventories_attributes: [
                {
                    quantity: 33,
                    item_id: water.id
                }
            ]
        }
      }
    }

    it 'should have create survivor' do
      post :create, params: jessica
      parsed_body = JSON.parse(response.body)
      jessica_inventory = Inventory.first
      expect(response.status).to eq 201

      expect(parsed_body['id']).to eq 1
      expect(parsed_body['name']).to eq jessica[:survivor][:name]
      expect(parsed_body['age']).to eq jessica[:survivor][:age]
      expect(parsed_body['gender']).to eq jessica[:survivor][:gender]
      expect(parsed_body['last_latitude']).to eq jessica[:survivor][:last_latitude]
      expect(parsed_body['last_longitude']).to eq jessica[:survivor][:last_longitude]
      expect(parsed_body['infected']).to eq false
      expect(parsed_body['inventory_points']).to eq jessica_inventory.total_points #132
      expect(parsed_body['inventories'].first['quantity']).to eq jessica_inventory.quantity
      expect(parsed_body['inventories'].first['item']).to eq water.as_json
    end
  end

  describe 'PATCH update' do
    let!(:water) { Item.create({ description: 'water', points: 4 }) }
    let!(:bruce) { Survivor.create({ name: 'Bruce Banner', age: 26, gender: 'M', last_latitude: '444444', last_longitude: '4445454.332' }) }

    it 'should have update only location' do
      post :update, params: { id: 1, survivor: { name: 'HULK SMASH', last_latitude: '9999', last_longitude: '9999' } }
      parsed_body = JSON.parse(response.body)

      expect(response.status).to eq 200

      expect(parsed_body['name']).to eq 'Bruce Banner'
      expect(parsed_body['last_latitude']).to eq '9999'
      expect(parsed_body['last_longitude']).to eq '9999'
    end
  end

  describe 'POST report_infection' do
    let!(:bruce) { Survivor.create({ name: 'Bruce Banner', age: 42, gender: 'M', last_latitude: '444444', last_longitude: '4445454.332' }) }
    let!(:peter) { Survivor.create({ name: 'Peter Parker', age: 22, gender: 'M', last_latitude: '444444', last_longitude: '4445454.332' }) }

    it 'should have report peter as infected and get success message' do
      post :report_infection, params: { id: 1, infected_id: '2' }
      parsed_body = JSON.parse(response.body)

      expect(response.status).to eq 201
      expect(parsed_body['message']).to eq 'Your report has been registered.'
    end

    it 'should have not report with invalid survivor_id param' do
      post :report_infection, params: { id: 1, infected_id: '999' }
      expect(response.status).to eq 422
    end
  end
end
