class Report

  def self.build
    infecteds = Survivor.where(infected: true)
    not_infecteds = Survivor.where(infected: false)

    {
        total_survivors: Survivor.count.to_f,
        infecteds: {
            total: infecteds.count.to_f,
            percentage: get_percentage(infecteds),
            survivors: infecteds.as_json(only: [:id, :name])
        },
        not_infecteds: {
            total: not_infecteds.count.to_f,
            percentage: get_percentage(not_infecteds),
            survivors: not_infecteds.as_json(only: [:id, :name])
        },
        items_average_by_survivor: {
          water: average_for(:water),
          food:  average_for(:food),
          medication:  average_for(:medication),
          ammunition:  average_for(:ammunition)
        }
    }
  end

  def self.get_percentage(collection)
    (collection.count.to_f / Survivor.count.to_f * 100).round(2)
  end

  def self.average_for(symbol)
    map = []

    case symbol
      when :water
        map = Inventory.where(item_id: 1).map(&:quantity)

      when :food
        map = Inventory.where(item_id: 2).map(&:quantity)

      when :medication
        map = Inventory.where(item_id: 3).map(&:quantity)

      when :ammunition
        map = Inventory.where(item_id: 4).map(&:quantity)
    end

    map.empty? ? 0 : map.sum / map.length
  end
end
