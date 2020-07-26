class Delivery < ApplicationRecord
  validates_presence_of :date, :jewel_id

  belongs_to :jewel
end
