class ApiV1::AuthController < ApiController

  # required user login for logout action
  before_action :authenticate_user!, :except => [:login]

  def login
    user = User.find_by_email( params[:email] )

    if user && user.valid_password?( params[:password] )
      render :json => {
        "message" => "Ok",
        "auth_token" => user.authentication_token,
        "user_id" => user.id
      }
    else
      render :json => {
        "message" => "Your email or password is wrong"
      }, :status => 401
    end

  end

  def logout
    current_user.generate_authentication_token
    current_user.save!

    render :json => { :message => "Ok"}
  end

end
