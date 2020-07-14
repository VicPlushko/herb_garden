class Herb < ActiveRecord::Base
  belongs_to :user
  validates :name, :latin_name, :family, :medicinal_parts, :taste, :energetics, :actions, :ideal_for, :applications, :dosage, :considerations, presence: true

  def self.search(search)
    where("name || taste || energetics || actions || ideal_for LIKE ?", "%#{search}%")
  end
end
