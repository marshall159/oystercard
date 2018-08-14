class Oystercard
  attr_accessor :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise("Limit of £#{MAX_BALANCE} exceeded") if over_max_balance?(amount)
    self.balance += amount
  end

  def over_max_balance?(amount)
    amount + balance > MAX_BALANCE
  end

  def deduct(amount)
    self.balance -= amount
  end

end
