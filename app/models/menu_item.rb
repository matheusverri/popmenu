class MenuItem < ApplicationRecord
  belongs_to :menu
	has_many :menu_menu_items, dependent: :destroy
  has_many :menus, through: :menu_menu_items

  validates :name, presence: true, uniqueness: { case_sensitive: false }	
end
