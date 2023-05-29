class Performance < ApplicationRecord
  belongs_to :player
  belongs_to :match
end