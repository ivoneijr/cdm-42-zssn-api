require 'rails_helper'

describe API::V1::ItemsController do

  describe 'GET index' do
    before { Item.create([
                             { description: 'water', points: 4 },
                             { description: 'medication', points: 2 },
                             { description: 'food', points: 3 },
                             { description: 'ammunition', points: 1 }
                         ]) }

    describe 'for items' do
      it 'should get all items' do
        post :index
        expect(response.status).to eq 200
        expect(response.body).to eq Item.all.to_json
      end
    end
  end

  describe 'POST trade' do
    let!(:water)      { Item.create({ points: 4, description: 'water' })}
    let!(:medication) { Item.create({ points: 2, description: 'medication' })}
    let!(:ammunition) { Item.create({ points: 1, description: 'ammunition' })}
    let!(:food)       { Item.create({ points: 3, description: 'food' })}
    let!(:ivo) { Survivor.create({ name: 'Ivo', age: 26, gender: 'M', last_latitude: '111111111', last_longitude: '4445454.332' }) }
    let!(:ari) { Survivor.create({ name: 'Ari', age: 26, gender: 'F', last_latitude: '111111111', last_longitude: '4445454.332' }) }
    before do
      Inventory.create([
                           { quantity: 3, item: water, survivor: ivo },
                           { quantity: 3, item: medication, survivor: ivo },
                           { quantity: 10, item: ammunition, survivor: ari }
                       ])
    end

    it 'should have a deal between 2 survivors and update their inventory' do
      deal = {
          dealer_1: { id: 1, swap_items: [ { id: 1, quantity: 2 }, { id: 2, quantity: 1 } ] },
          dealer_2: { id: 2, swap_items: [ { id: 3, quantity: 10 } ] }
      }

      post :trade, params: deal

      expect(response.status).to eq 200

      expect(ivo.inventories.count).to eq 3
      expect(ivo.inventories.joins(:item).where(quantity: 1, items: {description: 'water'}).count).to eq 1
      expect(ivo.inventories.joins(:item).where(quantity: 2, items: {description: 'medication'}).count).to eq 1
      expect(ivo.inventories.joins(:item).where(quantity: 10, items: {description: 'ammunition'}).count).to eq 1

      expect(ari.inventories.count).to eq 2
      expect(ari.inventories.joins(:item).where(quantity: 2, items: {description: 'water'}).count).to eq 1
      expect(ari.inventories.joins(:item).where(quantity: 1, items: {description: 'medication'}).count).to eq 1
    end

    it 'should not have a deal with 1 survivor infected' do
      Survivor.first.update(infected: true)
      deal = {
          dealer_1: { id: 1, swap_items: [ { id: 1, quantity: 2 }, { id: 2, quantity: 1 } ] },
          dealer_2: { id: 2, swap_items: [ { id: 3, quantity: 10 } ] }
      }

      post :trade, params: deal

      expect(response.status).to eq 422

      Survivor.first.update(infected: false)
    end

    it 'should not have an trade if any survivors dont have the correct number of items in your inventory' do
      deal = {
          dealer_1: { id: 1, swap_items: [ { id: 1, quantity: 22 }, { id: 2, quantity: 1 } ] },
          dealer_2: { id: 2, swap_items: [ { id: 3, quantity: 10 } ] }
      }

      post :trade, params: deal

      expect(response.status).to eq 422
    end

    it 'should not have an trade if the exchange points are not equal' do
      deal = {
          dealer_1: { id: 1, swap_items: [ { id: 1, quantity: 1 }, { id: 2, quantity: 1 } ] },
          dealer_2: { id: 2, swap_items: [ { id: 3, quantity: 10 } ] }
      }

      post :trade, params: deal

      expect(response.status).to eq 422
    end
  end
end
