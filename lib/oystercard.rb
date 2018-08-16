class Oystercard
  attr_reader :history, :balance
  
  MAX_BALANCE = 90
  MIN_BALANCE = 2
  MIN_FARE = 2

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
    @history = []
  end

  def top_up(amount)
    raise("Limit of £#{MAX_BALANCE} exceeded") if over_max_balance?(amount)
    self.balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise("Minimum balance £#{MIN_BALANCE} required") if under_min_balance?
    self.in_journey = true
    self.entry_station = station
  end

  def touch_out(station)
    self.in_journey = false
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
