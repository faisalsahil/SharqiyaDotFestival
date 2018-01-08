class Api::V1::UserSessionsController < ActionController::Base
  
  api :POST, '/v1/user_sessions/sign_in.json', "Admin and User Login"
  formats ['json', 'xml']
  example <<-EOS
        Request:
        {
          "user": {
            "email": "xx@xx.xx",
            "password": "xxxxxxxxx",
            "user_session_attributes": {
              "device_type": "ios/android",
              "device_uuid": "xxxxxxxxx",
              "device_token": "xxxxxxxxx"
            }
          }
        }

        Response:
        {
          "resp_status": 1,
          "message":"User Logged In successful.",
          "errors":"",
          "paging_data":null,
          "data":{
            "user":{
              "id": xxx,
              "email": "xx@xx.xxx",
              "username": "xxxxxx",
              "auth_token": "XXXXXXX"
            }
          }
        }
  EOS

  param :user, Hash, desc: 'Login credentials', required: true do
    param :email, String, desc: 'Email', required: true
    param :password, String, desc: 'Password', required: true
    param :user_session_attributes, Hash, desc: 'Session details' do
      param :device_type, String, desc: 'Device Type', required: false
      param :device_token, String, desc: 'Device Token for Push Notification', required: false
    end
  end

  def sign_in
    resp_data = User.sign_in(params)
    render json: resp_data
  end

  api :POST, '/v1/user_sessions/logout.json', "User Logout"
  formats ['json', 'xml']
  example <<-EOS
        Request:
        {
          "auth_token": "XXXXXXXXXXXXXXXXXXXXXXXXX"
        }

        Response:
        {
          "resp_status": 1,
          "message": "Logout successful.",
          "errors": "",
          "paging_data": null,
          "request_id": "",
          "data": ""
        }
  EOS

  param :auth_token, String, desc: 'Auth Token'

  def logout
  end


  private


  def user_sessions_params
    params.require(:user).permit(:email, :password, user_session_attributes: [:device_type, :device_token])
  end

end
