class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    validates :name, :city, :country, presence: true
    validates :email, :contact_number, presence: true, uniqueness: true
    validate :validate_country
    before_save :check_state_present
    has_many :user_skills, dependent: :destroy
    has_many :skills, through: :user_skills

    def check_state_present
        self.state = self.country if state.nil?
    end

    def validate_country
        return if country.nil?

        unless User.country_code_list.include?(country)
            errors.add(:country, "is not valid")
        end
    end

    def self.country_code_list
        ISO3166::Country.all.map { |country| country.alpha2 }
    end
end
