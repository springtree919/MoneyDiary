class Outgo < ApplicationRecord
  belongs_to :user
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :categories, presence: true
  
  def self.search_by_day(search)
    if !search.empty?
      Outgo.where(date: search.in_time_zone.all_day)
    else       
      Outgo.all
    end
  end
  
  def self.search_by_month(search)
    if !search.empty?
      Outgo.where(date: search.in_time_zone.all_month)
    else
      Outgo.all
    end
  end
  
  def self.search_by_year(search)
    if !search.empty?
      Outgo.where(date: search.in_time_zone.all_year)
    else
      Outgo.all
    end
  end
  
  def self.month_category(search)
    Outgo.search_by_month(search).group(:categories).sum(:amount)
  end
  
  def self.year(search)
    Outgo.search_by_year(search).group_by_month(:date).sum(:amount)
  end

end
