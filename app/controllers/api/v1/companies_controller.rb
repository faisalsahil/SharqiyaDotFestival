class Api::V1::CompaniesController < ActionController::Base
  
  api :GET, '/v1/companies.json', "Company List"
  formats ['json', 'xml']
  example <<-EOS
        Request:
        {
          "auth_token": "XXXXXXXX",
          "page": 1,
          "per_page": 20 
        }

        Response:
        {
          "resp_status":1,
          "message":"Companies List",
          "errors":"",
          "paging_data":{
            "page":1,
            "per_page":1,
            "total_records":2,
            "total_pages":2,
            "next_page_exist": true/false,
            "previous_page_exist": true/false
          },
          "data":{
            "companies":[
              {
                "id": xx,
                "company_name":"XXX",
                "company_logo":{
                  "url": "URL"
                },
                "short_description":"XXXXx",
                "is_seen": true/false
              }
            ]
          }
        }
  EOS
  
  param :auth_token, String, desc: 'Auth Token', required: true
  param :page, Integer, desc: 'Page', required: false
  param :per_page, Integer, desc: 'Per Page', required: false
  
  def index
    user_session = UserSession.find_by_auth_token(params[:auth_token])
    if user_session.present?
      resp_data = Company.api_company_listing(params)
      render json: resp_data
    else
      resp_data = { resp_status: 0, message: 'Invalid Token', error: '', data: {} }
      return render json: resp_data
    end
  end
  
  api :GET, '/v1/companies/{ID}.json', "Company Details"
  formats ['json', 'xml']
  example <<-EOS
        Request:
        {
          "auth_token": "XXXXXXXX",
          "id": 1 
        }

        Response:
        {
          "resp_status":1,
          "message":"Companies Details",
          "errors":"",
          "paging_data":null,
          "data":{
            "companies":[
              {
                "id":1,
                "company_name": "XXX",
                "company_logo":{
                  "url": "URL"
                },
                "short_description": "XXX",
                "is_seen": true/false,
                "company_addresses":[
                  {
                    "id": xx,
                    "street": "XXX",
                    "state": "XXX",
                    "zip": "XXx"
                  }
                ]
              }
            ]
          }
        }
  EOS
  
  param :auth_token, String, desc: 'Auth Token', required: true
  param :id, String, desc: 'Company Id', required: true
  
  def show
    user_session = UserSession.find_by_auth_token(params[:auth_token])
    if user_session.present?
      resp_data = Company.api_company_details(params)
      render json: resp_data
    else
      resp_data = { resp_status: 0, message: 'Invalid Token', error: '', data: {} }
      return render json: resp_data
    end
  end
  
end
