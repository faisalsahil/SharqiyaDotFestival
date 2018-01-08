class Api::V1::ApiPublicController < Api::V1::ApiProtectedController
  
  resource_description do
    api_version "Public - V 1.0"
    app_info ''
  end
  
  skip_before_action :api_restrict_access
end
