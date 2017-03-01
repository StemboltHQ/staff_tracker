OmniAuth.config.test_mode = true
omniauth_hash = {
  provider: 'google_oauth2',
  uid: '108095625339013556718',
  info: {
    name: 'Buzz Lightyear'
  },
  extra: {
    raw_info: {
      given_name: 'Buzz',
      family_name: 'Lightyear',
      email: 'Buzz@stembolt.com'
    }
  },
  credentials: {
    expires_at: Time.now.to_i
  }
}
OmniAuth.config.add_mock(:google, omniauth_hash)
