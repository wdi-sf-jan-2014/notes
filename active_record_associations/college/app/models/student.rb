class Student < ActiveRecord::Base
  has_one :account
  belongs_to :mentor
  has_many :enrollments
  has_many :courses, through: :enrollments
end
