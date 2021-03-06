# frozen_string_literal: true

class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :attended_event, foreign_key: { to_table: :events }
      t.references :event_attendee, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
