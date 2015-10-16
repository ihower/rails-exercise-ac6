class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_comment.subject
  #
  def notify_event(attendee, user)
    @attendee = attendee
    @event = attendee.event
    @user = user

    mail( to: @user.email, subject: "#{@event.name} 有新報名!!" )
  end

end
