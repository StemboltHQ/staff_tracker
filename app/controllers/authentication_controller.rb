class AuthenticationController < ApplicationController
  def google
    auth = env['omniauth.auth']
    person = Person.where(
      provider: auth.provider,
      uid: auth.uid
    ).first_or_create do |new_person|
      new_person.attributes = google_params(auth)
    end
    session[:person_id] = person.id
    redirect_to root_path
  end

  private

  def google_params(auth)
    random_password = SecureRandom.hex(10)
    {
      first_name: auth.extra.raw_info.given_name,
      last_name: auth.extra.raw_info.last_name,
      email: auth.extra.raw_info.email,
      provider: auth.provider,
      uid: auth.uid,
      oauth_token: auth.info.name,
      oauth_expires_at: Time.zone.at(auth.credentials.expires_at),
      password: random_password,
      password_confirmation: random_password
    }
  end
end
