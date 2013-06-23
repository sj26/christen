class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.references :domain, null: false, index: true
      t.string :name, null: false
      t.text :key_pem
      t.text :request_pem
      t.text :certificate_pem
      t.timestamps
    end

    add_column :domains, :certificates_count, :integer, null: false, default: 0
  end
end
