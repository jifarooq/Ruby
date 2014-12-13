def stock_picker(prices)
  max_profit = 0
  indices = []
  
  (0...prices.length - 1).each do |i|
    ((i + 1)...prices.length).each do |j|
      if prices[j] - prices[i] > max_profit
        max_profit = prices[j] - prices[i]
        indices = [i, j]
      end
    end
  end
  
  if indices.empty? then "No profit." else indices end
  # indices.empty? ? "No profit." : indices
end

rand_prices = Array.new(10) { (1..10).to_a.sample }
p rand_prices
p stock_picker(rand_prices)

