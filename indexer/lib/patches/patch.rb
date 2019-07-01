class Patch
  def initialize(cards, sets)
    @cards = cards
    @sets = sets
  end

  def each_card(&block)
    @cards.each(&block)
  end

  def each_printing(&block)
    @cards.each do |name, printings|
      printings.each(&block)
    end
  end

  def each_set(&block)
    @sets.each(&block)
  end

  def cards_by_set
    @cards_by_set ||= @cards.values.flatten.group_by{|c| c["set_code"]}
  end

  def rename(from, to)
    raise unless @cards[from]
    @cards[from].each do |c|
      raise unless c["name"] == from
      c["name"] = to
    end

    if @cards[to]
      # Merging isn't that complicated
      binding.pry
    else
      @cards[to] = @cards.delete(from)
    end
  end

  def delete_printing_if(&block)
    @cards.each do |name, printings|
      printings.delete_if(&block)
    end
    @cards.delete_if do |name, printings|
      printings.empty?
    end
  end
end
