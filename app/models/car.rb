class Car < ActiveRecord::Base

  validate :validate_registration_number
  validates :registration_number, uniqueness: true
  
  belongs_to :photo, class_name: 'Document', foreign_key: 'photo_id'
  belongs_to :user

  def as_json(options={})
    h = super(options)
    h[:photo] = self.photo
    h[:user] = self.user

    h
  end

  private 
  
  def validate_registration_number
    if not registration_number.present? or not /^[A-Za-z]{2} [0-9]{4}$/.match(registration_number)
       errors.add(:registration_number, " has incorrect format")
    end
  end

end
