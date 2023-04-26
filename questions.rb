require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end 

class User 
    attr_accessor :id, :fname, :lname
    
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * from users")
        data.map {|row| User.new(row)}
    end
    
    def self.find_by_id(id)
        id = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
        SQL
        return nil unless id.length > 0

        User.new(id.first)
    end 

    def self.find_by_name(fname, lname)
        person = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ? and lname = ?
        SQL
        return nil unless person.length > 0

        User.new(person.first)        
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end 
end 