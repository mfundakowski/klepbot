# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validate attributes' do
    context 'when status pending' do
      it 'is valid' do
        user            = FactoryBot.create(:user)
        contact_status  = FactoryBot.create(:contact_status)
        contact_event   = FactoryBot.create(:contact_event)
        contact         = described_class.new(status: 'pending',
                                              user: user,
                                              contact_status: contact_status,
                                              event: contact_event,
                                              touched: user)

        expect(contact.valid?).to be(true)
      end
    end

    context 'when status confirmed' do
      it 'is valid' do
        user            = FactoryBot.create(:user)
        contact_status  = FactoryBot.create(:contact_status)
        contact_event   = FactoryBot.create(:contact_event)
        contact         = described_class.new(first_name: 'first_name',
                                              last_name: 'last_name',
                                              email: 'email',
                                              status: 'confirmed',
                                              user: user,
                                              contact_status: contact_status,
                                              event: contact_event,
                                              touched: user)

        expect(contact.valid?).to be(true)
      end

      it 'is not valid' do
        user            = FactoryBot.create(:user)
        contact_status  = FactoryBot.create(:contact_status)
        contact_event   = FactoryBot.create(:contact_event)
        contact         = described_class.new(status: 'confirmed',
                                              user: user,
                                              contact_status: contact_status,
                                              event: contact_event,
                                              touched: user)

        expect(contact.valid?).to be(false)
      end
    end
  end
end
