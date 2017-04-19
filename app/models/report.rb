class Report
  def self.main
    total = Survivor.count.to_f

    infecteds = Survivor.where(infected: true).count.to_f
    not_infecteds = Survivor.where(infected: false).count.to_f

    {
        survivors: total,
        infecteds: {
            total: infecteds,
            percentage: (infecteds / total * 100).round(2)
        },
        not_infecteds: {
            total: not_infecteds,
            percentage: (not_infecteds / total * 100).round(2)
        }
    }
  end
end
