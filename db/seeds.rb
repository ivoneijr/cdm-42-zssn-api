# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

@water = Item.create({ description: 'water', points: 4 })
Item.create([
    { description: 'food', points: 3 }, 
    { description: 'medication', points: 2 }, 
    { description: 'ammunition', points: 1 }
])

@ivonei = Survivor.create({ name: "Ivonei", age: 26, gender: "M", last_latitude: "111111111", last_longitude: "4445454.332" })
Survivor.create([
    { name: "Arianne", age: 26, gender: "F", last_latitude: "222222", last_longitude: "4445454.332" },
    { name: "Peter Parker", age: 26, gender: "M", last_latitude: "333333", last_longitude: "4445454.332" },
    { name: "Bruce Bane", age: 26, gender: "M", last_latitude: "444444", last_longitude: "4445454.332" },
    { name: "Tony Stark", age: 26, gender: "M", last_latitude: "55555", last_longitude: "4445454.332" },
])
 
InfectionReport.create(reporter: @ivonei, infected: Survivor.last) 
Inventory.create(quantity: 3, item: @water, survivor: @ivonei)