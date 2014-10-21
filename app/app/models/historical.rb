class Historical < ActiveRecord::Base
  self.abstract_class = true
  establish_connection ('historical')
  self.table_name = 'historical'

  has_many :queries

end
