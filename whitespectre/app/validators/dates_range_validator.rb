# DatesRangeValidator checks that start and stop are in correct order

class DatesRangeValidator < ActiveModel::Validator
  def validate(record)
    if record.start && record.stop && record.start > record.stop
      record.errors.add(:start, 'Should be less or equal stop')
      record.errors.add(:stop, 'Should be greater or equal start')
    end
  end
end