# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  actor_id   :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Character < ApplicationRecord
  validates :movie_id, :presence => true
  validates :actor_id, :presence => true
  belongs_to :movie, :class_name => "Movie", :foreign_key => "movie_id"
  belongs_to :actor, :class_name => "Actor", :foreign_key => "actor_id"
end
