# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_sharengo_session'
# Rails.application.config.session_store :active_record_store, key: '_sharengoapi_session', :domain => :all

Rails.application.config.session_store :redis_session_store, {
    key: '_sharqiya_session',
    redis: {
        expire_after: 120.minutes,
        key_prefix: 'sharqiya:session:'
    }
}