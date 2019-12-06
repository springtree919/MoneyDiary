class Outgo < ApplicationRecord
  belongs_to :user
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :categories, presence: true
  
  def self.search_by_day(search)
      if search
        Outgo.where(date: search.in_time_zone.all_day)
      else
        Outgo.all
      end
  end
  
  def self.search_by_month(search)
      if search
        Outgo.where(date: search.in_time_zone.all_month)
      else
        Outgo.all
      end
  end
end
