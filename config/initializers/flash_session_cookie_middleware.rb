require 'rack/utils'
 
class FlashSessionCookieMiddleware
  def initialize(app, session_key = '_session_id')
    @app = app
    @session_key = session_key
  end
 
  def call(env)
    if env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/
      req = Rack::Request.new(env)
      env['HTTP_COOKIE'] = decode req.params["session_encoded"] unless req.params["session_encoded"].nil?
    end
 
    @app.call(env)
  end
  
  def decode(s)
    if s.gsub('@', '').match(/[a-zA-Z\_]+/).nil?
      s.split("@").map { |c| c.to_i.chr }.join
    else
      s.split("@").join
    end
  end
end

Rails.configuration.middleware.insert_before(
  ActionDispatch::Session::CookieStore, 
  FlashSessionCookieMiddleware, 
  Rails.configuration.secret_token
)