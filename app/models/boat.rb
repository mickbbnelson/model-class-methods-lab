class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
     limit(5)  
     #Uses the limit method to return the first 5 boat instance records.
  end

  def self.dinghy
    where("length < 20")  
    #Conditional using where to set the conditional of the length attribute to return all boat instance records that are less than 20 feet.
  end

  def self.ship
     where("length >= 20")  
     #Conditional using where to set the conditional of the length attribute to return all boat instance records that are equal or greater than 20 feet.
  end

  def self.last_three_alphabetically
     all.order(name: :desc).limit(3) 
     #Retreives the first three boat instance records in descending alphabetical order. order organizes the boats in alphabetical order based on name. (name: desc) has the records return in descending order. limit(3) calls for the first 3 results. 
  end

  def self.without_a_captain
     where(captain_id: nil)  
    #Conditional using where to set the conditional of the captain_id attribute to return the boats that are not linked to a captain.
    end

  def self.sailboats
     includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
    # This is really complex! It's not common to write code like this
    # regularly. Just know that we can get this out of the database in
    # milliseconds whereas it would take whole seconds for Ruby to do the same.
    #
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*") 
    #Returns the boat instance records that have three classifications
    #joins(:classification) returns the boat objects that contain classifications.
    #group("boats.id").having('COUNT(*) = 3') Sets group up to return boat.  having('COUNT(*) 3') set the conditions of the group.
    #select("boats.*") selects the boat attribute to return the specific boat records that meet the conditions.
  end

  def self.non_sailboats
    where("id NOT IN (?)", self.sailboats.pluck(:id))
    #Conditional using where to to return the boat records that are not in sailboats
    #id NOT IN (?) will set up the conditional so we can return all the elements that doesn't match the criterea.
    #self.sailboats.pluck(:id) this will replace the value in the question mark.  Here we specify by :id because there can only be one boat classification with a certain :id
    #pluck can be used to query single or multiple columns from the underlying table of a model. It accepts a list of column names as an argument and returns an array of values of the specified columns with the corresponding data type.
  end

  def self.longest
    order('length DESC').first
    #orders all boats based on length in decending order and returns the first record.
  end
end
