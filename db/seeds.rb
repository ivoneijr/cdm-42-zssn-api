# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

Item.create([
    { description: 'Water', points: 4 }, 
    { description: 'Food', points: 3 }, 
    { description: 'Medication', points: 2 }, 
    { description: 'Ammunition', points: 1 }
])

Survivor.create([
    { name: "Ivonei", age: 26, gender: "M", last_latitude: "123123123", last_longitude: "4445454.332" },
    { name: "Arianne", age: 26, gender: "F", last_latitude: "123123123", last_longitude: "4445454.332" },
    { name: "Peter Parker", age: 26, gender: "M", last_latitude: "123123123", last_longitude: "4445454.332" },
    { name: "Bruce Bane", age: 26, gender: "M", last_latitude: "123123123", last_longitude: "4445454.332" },
    { name: "Tony Stark", age: 26, gender: "M", last_latitude: "123123123", last_longitude: "4445454.332" },
])

@ivonei = Survivor.first
@tony = Survivor.last
@water = Item.first

InfectionReport.create(reporter: @ivonei, infected: @tony) 
Inventory.create(quantity: 3, item: @water, survivor: @ivonei)