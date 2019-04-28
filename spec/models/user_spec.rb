require 'rails_helper'

RSpec.describe User, type: :model do
  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end
  
  it 'is valid with a first name, last name and email, and password' do
    user = User.new(
      first_name: 'Aaron',
      last_name:  'Sumner',
      email:      'tester@example.com',
      password:   'dottle-nouveau-pavilion-tights-furze',
    )
    expect(user).to be_valid
  end

  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it 'returns a user\'s full name as a string' do
    user = FactoryBot.build(:user, first_name: 'Yamato', last_name: 'Nutria')
    expect(user.name).to eq 'Yamato Nutria'
  end

  it "sends a welcome email on account creation" do
    allow(UserMailer).to \
      receive_message_chain(:welcome_email, :deliver_later)
    user = FactoryBot.create(:user)
    expect(UserMailer).to have_received(:welcome_email).with(user)
  end

  # it "performs geocoding", vcr: true do
  #   user = FactoryBot.create(:user, last_sign_in_ip: "161.185.207.20")
  #   expect {
  #     user.geocode
  #   }.to change(user, :location).
  #     from(nil).
  #     to("Brooklyn, New York, US")
  # end
end
