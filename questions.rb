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

class Question
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * from questions")
        data.map {|row| Question.new(row)}
    end

    def self.find_by_id(id)
        id = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL
        return nil unless id.length > 0

        Question.new(id.first)
    end 

    def self.find_by_title(title)
        title = QuestionsDatabase.instance.execute(<<-SQL, title)
            SELECT
                *
            FROM
                questions
            WHERE
                title = ?
        SQL
        return nil unless title.length > 0

        Question.new(title.first)
    end

    def self.find_by_body(search_phrase)
        search_phrase = "%#{search_phrase}%"
        body = QuestionsDatabase.instance.execute(<<-SQL, search_phrase)
            SELECT
                *
            FROM
                questions
            WHERE
                body LIKE ?
        SQL
        return nil unless body.length > 0
        Question.new(body.first)
    end
    attr_accessor :id, :title, :body, :author_id
    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id'] 
        
    end

end

class QuestionFollows 

    def self.all 
        data =QuestionsDatabase.instance.execute("SELECT * from question_follows")
        data.map {|row| QuestionFollows.new(row)}
    end

    def self.find_by_id(id)
        id = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?
        SQL
        return nil unless id.length > 0

        QuestionFollows.new(id.first)
    end

    attr_accessor :id, :user_id, :question_id
    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end

end

class Reply
    def self.all 
        data =QuestionsDatabase.instance.execute("SELECT * from replies")
        data.map {|row| Reply.new(row)}
    end

    def self.find_by_id(id)
        id = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
        SQL
        return nil unless id.length > 0

        Reply.new(id.first)
    end
    attr_accessor :id, :question_id, :parent_reply_id, :author_id,:body
    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @author_id = options['author_id']
        @body = options['body']
    end
end 

class QuestionLikes
    def self.all 
        data =QuestionsDatabase.instance.execute("SELECT * from question_likes")
        data.map {|row| QuestionLikes.new(row)}
    end

    def self.find_by_id(id)
        id = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_likes
            WHERE
                id = ?
        SQL
        return nil unless id.length > 0

        QuestionLikes.new(id.first)
    end

    attr_accessor :id, :question_id, :user_id
    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end 

class Tag

    def self.all 
        data = QuestionsDatabase.instance.execute("SELECT * FROM tags")
        data.map {|row| Tag.new(row)}
    end

    def self.find_by_id(id)
        id =  QuestionsDatabase.instance.execute(<<-SQL,id)
            SELECT 
                *
            FROM
                tags 
            WHERE
                id = ? 
        SQL
        return nil unless id.length > 0 
        Tag.new(id.first)
    end

    attr_accessor :id, :question_id, :tag_id
    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @tag_id = options['tag_id']
    end

end