# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Unit Tests:' do
    it 'Creates a regular User' do
      user = build(:user, name: 'User', password: 'rootroot', password_confirmation: 'rootroot')
      expect(user).to be_valid
    end

    it 'Needs a username' do
      user = build(:user, name: nil, password: 'password123', password_confirmation: 'password123')
      expect(user).to_not be_valid
    end

    it 'Needs a password' do
      user = build(:user, name: 'User', password: nil, password_confirmation: nil)
      expect(user).to_not be_valid
    end

    it 'Needs to have the same password and password confirmation' do
      user = build(:user, name: 'User', password: 'rootroot', password_confirmation: 'password123')
      expect(user).to_not be_valid
    end

    it 'Needs to have a password longer than 6 characters' do
      user = build(:user, name: 'User', password: '123', password_confirmation: '123')
      expect(user).to_not be_valid
    end

    it 'Needs to have a unique username' do
      create(:user, name: 'User', password: 'rootroot', password_confirmation: 'rootroot')
      user2 = build(:user, name: 'User', password: 'rootroot', password_confirmation: 'rootroot')
      expect(user2).to_not be_valid
    end
  end

  context 'Events Relationships' do
    it 'Can have multiple events' do
      user = create(:user)
      create(:event, title: 'First Event', description: 'Event Description', creator_id: user.id)
      event2 = build(:event, title: 'Second Event', description: 'Event Description', creator_id: user.id)
      expect(event2).to be_valid
    end
  end
end
