module ItemsHelper

  def get_dealers(params)
    dealers = []

    dealer_1 = get_dealer(params[:dealer_1])
    dealer_2 = get_dealer(params[:dealer_2])

    if dealer_1
      dealers.push(dealer_1)
      dealer_1.swap_items_new = params[:dealer_2][:swap_items]
    end

    if dealer_2
      dealers.push(dealer_2)
      dealer_2.swap_items_new = params[:dealer_1][:swap_items]
    end

    dealers
  end

  def get_dealer(dealer_params)
    if survivor = Survivor.find_by_id(dealer_params[:id])
      survivor.swap_items = dealer_params[:swap_items]
    else
      @trade_errors.push({ can_not_find_dealer: "Couldn't find Survivor with 'id'=#{dealer_params[:id]}"})
    end
    survivor
  end

  def can_trade?
    @dealers.each { |dealer| @trade_errors.push dealer.errors unless dealer.can_trade? }
    @trade_errors.empty? ? true : false
  end

  def equal_points?
    @dealers.each { |dealer| dealer.sum_points }

    is_equal = have_equal_points?(@dealers)
    @trade_errors.push({ points: 'The points quantity between two dealers must be equal.' }) unless is_equal
    is_equal
  end

  def have_equal_points?(dealers)
    dealers.first.swap_points == dealers.last.swap_points
  end

  def can_swap?
    they_can = have_all_swap_items?(@dealers)
    @trade_errors.push({ have_all_swap_items: 'The dealers should have all items they intend to make swap.'}) unless they_can
    they_can
  end

  def have_all_swap_items?(dealers)
    have_all = true
    dealers.each { |dealer| have_all = false unless dealer.have_all_swap_items? }
    have_all
  end

end
