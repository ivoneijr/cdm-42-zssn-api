# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  description :string
#  points      :integer
#

class Item < ApplicationRecord
    has_many :inventories
    has_many :survivor, :through => :inventories
end
