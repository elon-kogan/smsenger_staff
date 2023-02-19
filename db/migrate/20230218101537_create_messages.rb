class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :phone, null: false
      t.string :text, null: false
      t.boolean :sent, null: false, default: false
      t.timestamps
    end
  end
end
