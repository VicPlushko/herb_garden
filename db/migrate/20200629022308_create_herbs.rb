class CreateHerbs < ActiveRecord::Migration
  def change
    create_table :herbs do |h|
      h.string :name
      h.string :latin_name
      h.string :family
      h.string :medicinal_parts
      h.string :taste
      h.string :energetics
      h.text :actions
      h.text :ideal_for
      h.text :applications
      h.text :dosage
      h.text :considerations
      h.integer :user_id
    end 
  end
end
