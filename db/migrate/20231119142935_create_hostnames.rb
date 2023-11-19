class CreateHostnames < ActiveRecord::Migration[6.1]
  def change
    create_table :hostnames do |t|
      t.string :hostname
      t.references :dns_record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
