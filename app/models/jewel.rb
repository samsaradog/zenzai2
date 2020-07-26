class Jewel < ApplicationRecord
  validates_presence_of :source, :citation, :quote, :comment
end
