# StopDurationValidator checks that at least stop or duration is provided

class StopDurationValidator < ActiveModel::Validator
  def validate(record)
    if !record.draft? && record.stop.nil? && record.duration.nil?
      record.errors.add(:stop, 'can\'t be blank when duration is also blank')
      record.errors.add(:duration, 'can\'t be blank when stop is also blank')
    end
  end
end