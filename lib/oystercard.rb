class Oystercard
  attr_reader :history, :balance

  MAX_BALANCE = 90
  MIN_BALANCE = 2
  MIN_FARE = 2

  def initialize(journey_class = Journey)
    @balance = 0
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @history = []
    @journey_class = journey_class
  

  end

  def top_up(amount)
    raise("Limit of £#{MAX_BALANCE} exceeded") if over_max_balance?(amount)
    self.balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def new_journey
    journey_class.new(@entry_station, @exit_station)
  end 


  def touch_in(station)

    # edge case 1 (creating previous journey record)
    #Journey.new(@entry_station, @exit_station) if in_journey?
    #continuing....

    raise("Minimum balance £#{MIN_BALANCE} required") if under_min_balance?
    self.in_journey = true
    self.entry_station = station
  end

  def touch_out(station)
    
    # edge case 2
    #Journey.new(@entry_station, station) if in_journey? == false
    
    self.in_journey = false
    
    #Journey.new(@entry_station, station)


    deduct(MIN_FARE)
    store_journey(station)
    self.entry_station = nil
  end

  private
  attr_accessor :in_journey, :entry_station
  attr_writer :balance

  def store_journey(exit)
    @history << {entry_station: @entry_station, exit_station: exit}
  end


  def deduct(amount)
    self.balance -= amount
  end

  def over_max_balance?(amount)
    amount + balance > MAX_BALANCE
  end

  def under_min_balance?
    balance < MIN_BALANCE
  end
end
