class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :domain, null: false
      t.string :name, null: false
      t.string :type, null: false
      t.integer :ttl, null: false, default: 3600
      t.integer :priority, null: false, default: 20
      t.string :content

      t.timestamps
    end

    add_index :records, [:domain_id, :name, :type, :priority]

    add_column :domains, :records_count, :integer, null: false, default: 0
  end
end
