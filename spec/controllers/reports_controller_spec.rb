require 'rails_helper'

describe API::V1::ReportsController do
  describe 'GET index' do
    before do
      #TODO: create scenario
    end

    it 'should get all reports' do
      get :index

      expect(response.status).to eq 200
      expect(JSON.parse(response.body).count).to eq 5
    end

    it 'should get only infected report' do
      get :index, params: { types: 'infected'}

      expect(response.status).to eq 200
      expect(JSON.parse(response.body).count).to eq 1
      expect(JSON.parse(response.body).first['type']).to eq 'infected'
    end

    it 'should get infected  and not_infected reports' do
      get :index, params: { types: 'infected, not_infected'}

      expect(response.status).to eq 200
      expect(JSON.parse(response.body).count).to eq 2
      expect(JSON.parse(response.body).first['type']).to eq 'infected'
      expect(JSON.parse(response.body).last['type']).to eq 'not_infected'
    end
  end
end
