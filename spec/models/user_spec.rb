require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a first name, last name, email, and password' do
    user = User.new(
      first_name: 'Haku',
      last_name: 'Otter',
      email: 'haku@example.com',
      password: 'passpass'
    )
    expect(user).to be_valid  
  end


  it 'is invalid without a first name' do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid without a last name' do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it 'is invalid without an email address' 

  it 'is invalid with a duplicate email adress' do
    User.create(
      first_name: 'Haku',
      last_name: 'Otter',
      email: 'haku@example.com',
      password: 'passpass'
    )
    user = User.new(
      first_name: 'Yamato',
      last_name: 'Otter',
      email: 'haku@example.com',
      password: 'passpass'
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it 'returns a user\'s full name as a string' do
    user = User.new(
      first_name: 'Haku',
      last_name: 'Otter',
      email: 'haku@example.com'
    )
    expect(user.name).to eq 'Haku Otter'
  end
end