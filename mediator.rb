class StockOffer
  attr_accessor :stock_shares, :stock_symbol, :colleague_code

  def initialize(stock_shares, stock_symbol, colleague_code)
    @stock_shares   = stock_shares
    @stock_symbol   = stock_symbol
    @colleague_code = colleague_code
  end
end

class Colleague
  attr_accessor :colleague_code

  def initialize(mediator)
    @mediator = mediator

    @mediator.add_colleague(self)
  end

  def sale_offer(stock, shares)
    @mediator.offer_send(stock, shares, @colleague_code, :sale)
  end

  def buy_offer(stock, shares)
    @mediator.offer_send(stock, shares, @colleague_code, :buy)
  end
end

class GormanSlacks < Colleague
  def initialize(mediator)
    super(mediator)

    puts "Gorman Slacks signed up with the stockexchange\n"
  end
end

class JTPoorman < Colleague
  def initialize(mediator)
    super(mediator)

    puts "JT Poorman signed up with the stockexchange\n"
  end
end

class StockMediator
  attr_accessor :colleagues, :stock_buy_offers, :stock_sale_offers, :colleague_codes

  def initialize
    @colleague_codes = 0

    @colleagues        = []
    @stock_buy_offers  = []
    @stock_sale_offers = []
  end

  def add_colleague(colleague)
    colleagues << colleague

    @colleague_codes += 1

    colleague.colleague_code = colleague_codes
  end

  def offer_send(stock, shares, colleague_code, transaction_type)
    stock_status = false
    stock_offers = transaction_type == :buy ? stock_sale_offers : stock_buy_offers

    stock_offers.each do |offer|
      if offer.stock_symbol == stock && offer.stock_shares == shares
        puts "#{shares} shares of #{stock} maked by operation #{transaction_type}, colleague code #{offer.colleague_code}"

        stock_offers.delete(offer)
        stock_status = true
      end

      break if stock_status
    end

    if !stock_status
      puts "#{shares} shares of #{stock} added to inventory"

      new_offering = StockOffer.new(shares, stock, colleague_code)

      send("stock_#{transaction_type}_offers") << new_offering
    end
  end

  def get_stock_offerings
    puts "\n Stocks for Sale"

    stock_sale_offers.each { |offer| puts "#{offer.stock_shares} of #{offer.stock_symbol}" }

    puts "\n Stock buy Offers"

    stock_buy_offers.each { |offer| puts "#{offer.stock_shares} of #{offer.stock_symbol}" }
  end
end

class StockOffer
  attr_accessor :stock_shares, :stock_symbol, :colleague_code

  def initialize(stock_shares, stock_symbol, colleague_code)
    @stock_shares   = stock_shares
    @stock_symbol   = stock_symbol
    @colleague_code = colleague_code
  end
end

# Stock exchange
nyse = StockMediator.new

# Stock Exchange Brokers
gorman_slack_broker = GormanSlacks.new(nyse)
jt_poorman_broker   = JTPoorman.new(nyse)

# Transactions
gorman_slack_broker.buy_offer('NRG', 10)
jt_poorman_broker.sale_offer('NRG', 10)
gorman_slack_broker.buy_offer('GOOG', 100)
jt_poorman_broker.sale_offer('APPL', 50)

nyse.get_stock_offerings
