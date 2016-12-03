require "rails_helper"

RSpec.describe GameNotificationMailer, type: :mailer do
  describe 'notication' do
    let(:inviter) { Player.make! }
    let(:invitee) { Player.make! }
    let(:game) { Game.make! }
    let(:mail) { described_class.game_notification_mailer(invitee, inviter, game).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq("#{invitee.playername} has accepted your game request!")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([inviter.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['games@localhost'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(inviter.playername)
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded)
        .to match("http://localhost:3000/games/#{game.id}")
    end
  end
end
