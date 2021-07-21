class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
     all
     #all returns all instances of the classification class.
  end

  def self.longest
     Boat.longest.classifications
     #returns classifications with the longest boat
     #Calls the boat.longest method to return the longest boat.
     #calls classifications to return the classification instance records.
  end

end
