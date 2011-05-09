# == Schema Information
# Schema version: 20110509004009
#
# Table name: games
#
#  id          :integer         not null, primary key
#  game_string :string(255)
#  won         :boolean
#  lost        :boolean
#  guesses     :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Game < ActiveRecord::Base

  belongs_to :user

  validates :game_string, :presence => true

  validates :won, :inclusion => { :in => [true, false]}

  validates :lost, :inclusion => { :in => [true, false]}

end
