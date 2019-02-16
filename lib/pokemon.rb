require "pry"
class Pokemon
    attr_accessor :id, :name, :type, :db, :hp
    def initialize(id:, name:, type:, db:, hp: hp)
        @id = id
        @name = name
        @type = type
        @db = db
        @hp = hp
    end

    def alter_hp(new_hp, db)
        @hp = new_hp
        db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", new_hp, @id)
    end

    def self.save(name, type, db)
        db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    end

    def self.find(given_id, given_db)
        new_info = given_db.execute("SELECT * FROM pokemon WHERE id = ?", given_id)
        #binding.pry
        Pokemon.new(name: new_info[0][1], type: new_info[0][2], id: new_info[0][0], hp: new_info[0][3], db: given_db)
    end

end
