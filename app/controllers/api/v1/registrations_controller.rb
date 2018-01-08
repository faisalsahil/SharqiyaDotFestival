class Api::V1::RegistrationsController < ActionController::Base
  
  api :POST, '/v1/registrations/sign_up.json', "User SignUp"
  formats ['json', 'xml']
  example <<-EOS
        Request:
        {
              user: {
               email: "XXXXXX@XXXXX.XXXX",
               username: 'XXXXXXXX',
               phone:    "XXXXXXXX",
               password: "XXXXXXXX",
               password_confirmation: "XXXXXXX"
            }
        }

        Response:
        {
          "resp_status": 1,
          "data": {},
          "message": "You're successfully signed up.",
          "errors": "",
          "paging_data": null
        }
  EOS

  param :user, Hash, desc: 'Registration', required: true do
    param :email, String, desc: 'Email', required: true
    param :username, String, desc: 'Username', required: true
    param :phone, String, desc: 'Phone', required: false
    param :password, String, desc: 'Password', required: true
    param :password_confirmation, String, desc: 'Password Confirmation', required: true
  end

  def sign_up
    resp_data = User.sign_up(params)
    render json: resp_data
  end
end
