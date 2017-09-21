class Googlesheet < ActiveRecord::Base
    validates :sport, presence: true, length: { is: 3 }, uniqueness: { case_sensitive: false }
    validates :status, presence: true
end
