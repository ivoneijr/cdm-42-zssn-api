module ItemMacros
  def create_items
    Item.create([
      { description: 'water', points: 4 },
      { description: 'medication', points: 2 },
      { description: 'food', points: 3 },
      { description: 'ammunition', points: 1 }
    ])
  end
end
