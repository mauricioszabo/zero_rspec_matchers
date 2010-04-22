class Person < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :age
  validates_format_of :id_card, :with => /^\d{6}$/
end

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

class CreatePerson < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :name
      t.string :address
      t.string :id_card
      t.integer :age
    end
  end
end

CreatePerson.up
