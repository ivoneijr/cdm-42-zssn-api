module ReportsHelper

  #Used in ReportsController
  def build_params(types)
    if types
      strip(types)
      strings_to_symbols(types)
    end
  end

  def strip(string)
    if string.include?(' ')
      string.gsub! ' ', ''
    else
      string
    end
  end

  def strings_to_symbols(types)
    types.split(',').map { |x| x.to_sym }
  end

  #Used in Report class
  def self.all_types
    [:total_survivors, :infected, :not_infected, :items_average_by_survivor, :lost_points]
  end

  def self.get_percentage(collection)
    (collection.count.to_f / Survivor.count.to_f * 100).round(2)
  end

  def self.sum_points(survivors)
    total = 0
    survivors.each { |survivor| total = total + survivor.total_points }
    total
  end
end
