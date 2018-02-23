# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  year        :integer
#  duration    :integer
#  description :text
#  image_url   :string
#  director_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Movie < ApplicationRecord
    validates :title, :presence => true, :uniqueness => {:scope => [:year]}
    validates :director_id, {:presence => true}
    validates :year, numericality: {:only_integer => true, :greater_than => 1870, :less_than => 2050}
    validates :duration, numericality: {:allow_blank => true, :less_than => 2764800}
end
