class User < ApplicationRecord
  rolify
  include ResponseBuilder
  
  
  has_many :user_sessions, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :email, presence: true
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def self.sign_up(data)
    data = HashWithIndifferentAccess.new(data)
    
    user            = User.new
    user.attributes = data[:user]
    status, message = validate_email_and_password(data)
    if !status.present?
      if user.save
        user.add_role(AppConstants::APP_USER)
        # User.send_email(member_profile.user.email)
        resp_data    = {}
        resp_status  = 1
        resp_message = 'You\'re successfully signed up.'
        resp_errors  = ''
      else
        resp_data    = {}
        resp_status  = 0
        resp_message = 'Errors'
        resp_errors  = error_messages(user)
      end
    else
      resp_data    = {}
      resp_status  = 0
      resp_message = 'error'
      resp_errors  = message
    end
    
    
    ResponseBuilder.json_builder(resp_data, resp_status, resp_message, errors: resp_errors)
  end
  
  def self.sign_in(data)
    data = HashWithIndifferentAccess.new(data)
    
    if data[:user][:email].present?
      user = User.find_by_email(data[:user][:email])
    end
    
    if user && user.valid_password?(data[:user][:password])
      if !user.is_deleted
        user_sessions = UserSession.where("device_uuid = ? AND user_id != ?", data[:user_session][:device_uuid], user.id)
        user_sessions.destroy_all if user_sessions.present?
        user_session                = user.user_sessions.where(device_uuid: data[:user_session][:device_uuid]).try(:first) || user.user_sessions.build(data[:user_session])
        user_session.auth_token     = SecureRandom.hex(100)
        user_session.session_status = 'open'
        user_session.save(validate: false)
        
        response    = user.as_json(
                     only:[:id, :username, :email]
        ).merge!(auth_token: user_session.auth_token).as_json

        resp_data    = {user: response}
        resp_status  = 1
        resp_message = 'User Logged In successful.'
        resp_errors  = ''
      else
        resp_data    = {}
        resp_status  = 1
        resp_message = 'Attention.'
        resp_errors  = 'Your account is blocked. Please contact with admin.'
      end
    else
      resp_data    = {}
      resp_status  = 0
      resp_message = 'Errors'
      resp_errors  = 'Either your email or password is incorrect'
    end
    
    ResponseBuilder.json_builder(resp_data, resp_status, resp_message, errors: resp_errors)
  end
  
  def self.validate_email_and_password(data)
    status  = false
    message = ''
    if data[:user][:password] != data[:user][:password_confirmation]
      message = "Password mismatch."
      status  = true
    end
    [status, message]
  end
  
  def self.error_messages(error_array)
    error_string = ''
    error_array.errors.full_messages.each do |message|
      error_string += message + ', '
    end
    error_string
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string(255)
#  last_name              :string(255)
#  phone                  :string(255)
#  parent_id              :integer
#  commission             :float(24)
#  limit_amount           :float(24)        default(0.0)
#  amount_used            :float(24)        default(0.0)
#
