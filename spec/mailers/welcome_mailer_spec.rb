require "rails_helper"

RSpec.describe WelcomeMailer, type: :mailer do
  describe 'instructions' do
    let(:user) { create(:user, :jane) }
    let(:mail) { described_class.welcome_email(user).deliver_now }

    it "renders the subject" do
      expect(mail.subject).to eq("Welcome to Sampers Social Media.")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(['afriendbook@gmail.com'])
    end

    it "contains the user's username" do
      expect(mail.body.encoded).to match(user.username)
    end

    it "contains a link to the home page" do
      expect(mail.body.encoded)
        .to match('https://friendbook.fly.dev/')
    end
  end
end