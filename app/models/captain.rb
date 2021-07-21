class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
    #returns captain records for the captains that operate catamerans.
    #includes(boats: :classifications)specifies the associations that will be loaded.
    #where(classifications: {name: "Catamaran"}) uses the where conditional to return classifications where the name = Catamaran
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
    #returns captain records for the captains that operate sailboats.
    #includes(boats: :classifications)specifies the associations that will be loaded.
    #where(classifications: {name: "Sailboat"}) uses the where conditional to return classifications where the name = Sailboat
    #distinct makes sure that only 1 record is returned with certain values
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
    #returns captain records for the captains that operate motorboats.
    #includes(boats: :classifications)specifies the associations that will be loaded.
    #where(classifications: {name: "Moterboat"}) uses the where conditional to return classifications where the name = Motorboat
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
    #uses the where conditional to return captain records for sailers and moterboat captains
    #id IN (?) will set up the conditional so we can return all the elements that match the criterea.
    #self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id) will replace the value in the question mark.  Here we specify by :id because there can only be one boat classification with a certain :id. 
    #notice that we are calling other methods to make this work.
    #pluck can be used to query single or multiple columns from the underlying table of a model. It accepts a list of column names as an argument and returns an array of values of the specified columns with the corresponding data type.
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
    #Conditional using where.not to to return the captain records that are not in sailboats
    #id IN (?) will set up the conditional so we can return all the elements that don't match the criterea.
    #self.sailer.pluck(:id) this will replace the value in the question mark.  Here we specify by :id because there can only be one boat classification with a certain :id
    #pluck can be used to query single or multiple columns from the underlying table of a model. It accepts a list of column names as an argument and returns an array of values of the specified columns with the corresponding data type.
  end

end
