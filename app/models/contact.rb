class Contact < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true, if: :status_confirmed?

  has_many :actions, class_name: 'ContactAction', dependent: :destroy
  has_many :tasks
  belongs_to :contact_status
  belongs_to :event, class_name: 'ContactEvent', foreign_key: :contact_event_id
  belongs_to :user
  belongs_to :touched, class_name: 'User', foreign_key: :touched_id

  enum status: { pending: 'pending', confirmed: 'confirmed' }, _prefix: true

  def update_with_action(params)
    update(params)

    action_attributes = attributes
    ['id', 'created_at', 'updated_at'].map(&action_attributes.method(:delete))
    action_attributes['action_type'] = :updated

    actions.create!(action_attributes)
  end
end
