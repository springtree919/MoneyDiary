json.array!(@outgos) do |date, amount|
  json.title amount
  json.date date
  json.name "outgo"
end

json.array!(@incomes) do |date, amount|
  json.title amount
  json.date date
  json.name "income"
end


