class GameNotificationMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper
  default from: "games@#{ApplicationMailer.default_url_options[:host]}"

  def game_notification_mailer(invitee, inviter, game)
    @inviter = inviter
    @invitee = invitee
    @game = game
    mail(to: @inviter.email, subject: "#{@invitee.playername.titlecase} has accepted your game request!")
  end
end
