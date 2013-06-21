class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.references :user, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :domains, :user_id
    add_index :domains, :name, unique: true
  end
end
