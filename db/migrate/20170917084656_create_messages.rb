class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.datetime :date
      t.string :email
      t.string :message_type
      t.string :message_subtype
      t.string :info
      t.string :source

      t.timestamps
    end
  end
end
