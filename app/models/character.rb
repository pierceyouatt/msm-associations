# == Schema Information
#
# Table name: characters
#
#  id          :integer          not null, primary key
#  movie_id    :integer
#  actor_id    :integer
#  name_string :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Character < ApplicationRecord
  validates :movie_id, :presence => true
  validates :actor_id, :presence => true
end
