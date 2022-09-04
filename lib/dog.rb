require "pry"
require "active_record"

# Setup a database connection
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/dogs.sqlite"
)

# Create a dogs table
sql = <<-SQL
  CREATE TABLE IF NOT EXISTS dogs (
    id INTEGER PRIMARY KEY,
    name TEXT,
    breed TEXT
  )
SQL
ActiveRecord::Base.connection.execute(sql)

# Log SQL output to the terminal
ActiveRecord::Base.logger = Logger.new(STDOUT)

class Dog < ActiveRecord::Base
    attr_accessor  :name, :breed

    def create(attributes)
        attributes.each do |key, value|
            self.create("#{key}=", value)
        end
    end

    def update(name1, name2)
        dog = self.find_by(name: name1)
        dog.update(name: name2)
        
    end
end 
#binding.pry
#Dog.create(name: 'Teddy', breed: 'cockapoo' )

