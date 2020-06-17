class Sessionsier < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # TODO: ユーザーページへリダイレクトさせる
    else
      flash.now[:danger] = 'メールアドレスかパスワードが正しくありません'
      render 'new'
    end
  end
  
  def destroy
    # TODO: ログアウトする
  end
end
