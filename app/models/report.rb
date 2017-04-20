class Report

  def self.build(types)
    report = []
    types = ReportsHelper.all_types unless types

    types.each do |type|
      report.push(get_report_for(type)) if types.include?(type)
    end

    report
  end

  def self.get_report_for(symbol)
    case symbol
      when :total_survivors
        {
            type: symbol.to_s,
            total: Survivor.count.to_f
        }

      when :infected
        {
            type: symbol.to_s,
            data: {
                total: Survivor.infected.count.to_f,
                percentage: ReportsHelper.get_percentage(Survivor.infected),
                survivors: Survivor.infected.as_json(only: [:id, :name])
            }
        }
      when :not_infected
        {
            type: symbol.to_s,
            data: {
                total: Survivor.not_infected.count.to_f,
                percentage: ReportsHelper.get_percentage(Survivor.not_infected),
                survivors: Survivor.not_infected.as_json(only: [:id, :name])
            }
        }
      when :items_average_by_survivor
        {
            type: symbol.to_s,
            data: {
                water: average_for(:water),
                food: average_for(:food),
                medication: average_for(:medication),
                ammunition: average_for(:ammunition)
            }
        }
      when :lost_points
        {
            type: symbol.to_s,
            data: {
                by_infected_survivors: ReportsHelper.sum_points(Survivor.infected)
            }
        }

    end
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
