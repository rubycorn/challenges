require 'rails_helper'

shared_examples 'group event' do
  it 'updates attribute `deleted_at`' do
    expect do
      event.destroy
    end.to change{ event.deleted_at.class }.from(NilClass).to(ActiveSupport::TimeWithZone)
  end

  it 'should response `true` in #deleted? method' do
    expect do
      event.destroy
    end.to change{ event.deleted? }.from(false).to(true)
  end
end