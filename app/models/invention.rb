class Invention < ApplicationRecord
  belongs_to :user, optional: true # user is not required
  has_and_belongs_to_many :bits
  has_and_belongs_to_many :materials

  attr_accessor :bits_list, :materials_list

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :bits, :length => { :minimum => 1 }

  # before_validation :testing
  before_validation :convert_bits_by_name, :convert_materials_by_name

  private

  # def testing
  #   binding.pry
  # end

  # helper method to convert strings to objects (there's probably a better way to organize this)
  def self.convert_list_by_name(cls, _val)
    # _val will be nil or a String (comma separated list of names)
    if _val.blank?
      return []
    end
    _val.split(/\s*,\s*/).map{ |x| cls.find_by_name(x) }.compact
  end

  def convert_bits_by_name
    # binding.pry
    self.bits = Invention.convert_list_by_name(Bit, bits_list) if bits_list # NOTE: bits_list not required on update
  end

  def convert_materials_by_name
    self.materials = Invention.convert_list_by_name(Material, materials_list) if materials_list
  end
end
