require 'cuba'
require 'cuba/safe'
require 'mustache'
require 'omniauth-twitter'

# Automatically require everything in the `views/' folder
Dir.glob('views/*.rb').each do |file|
  require_relative file
end

Dir.glob('lib/*.rb').each do |file|
  require_relative file
end

Cuba.plugin Cuba::Safe

Cuba.use Rack::Session::Cookie, secret: SecureRandom.hex(64)

Cuba.use OmniAuth::Builder do
  provider :twitter, 'd2iNeWeDYeYiNCp427hTG2SRu', 'V7PBdM3PZ0bDtJwykEQoaz2YLYZT4zB2oF0h8VlQRpgieWBMlS'
end

DB = Sequel.sqlite('notecache.db')

Cuba.define do
  on get do
    on root do
      res.write Index.new('Hey there!').render
    end
=begin
    # Most of the following lines form the OAuth component.
    on 'login' do
      res.redirect '/auth/twitter'
    end

    on 'logout' do
      if self[:logged_in]
        self[:logged_in] = nil
        res.write 'You have been successfully logged out.'
      else
        res.write 'Failure logging out: never logged in'
      end
    end

    on 'status' do
      if self[:logged_in]
        res.write 'Logged in.'
      else
        res.write 'Logged out.'
      end
    end

    on 'auth/twitter/callback' do
      self[:logged_in] = true
      res.write "You are now logged in: #{env['omniauth.auth']}"
    end

    on 'auth/failure' do
      res.write "Something went wrong with your authentication: #{request.params[:message]}"
    end
=end
    on default do
      res.status = 404
      res.write "404 Not Found"
    end
  end
end
