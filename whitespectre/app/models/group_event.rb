class GroupEvent < ApplicationRecord
  include SafeDestroy

  validates :name, :description, :start, presence: true, unless: :draft?

  validates :duration, numericality: { greater_than: 0, only_integer: true, allow_nil: true }, if: :draft?
  validates :duration, numericality: { greater_than: 0, only_integer: true }, if: :validate_duration?

  validates :latitude, numericality: { allow_nil: true },
    inclusion: { in: -90..90, allow_nil: true }, if: :draft?
  validates :latitude, numericality: true, inclusion: { in: -90..90 }, unless: :draft?

  validates :longitude, numericality: { allow_nil: true },
    inclusion: { in: -180..180, allow_nil: true }, if: :draft?
  validates :longitude, numericality: true, inclusion: { in: -180..180 }, unless: :draft?

  validates_with DatesRangeValidator
  validates_with StopDurationValidator

  before_save :calculate

  private

  def calculate
    if start && stop
      self.duration = (self.stop - self.start).to_i + 1
    elsif start && duration
      self.stop = (self.duration - 1).days.since(self.start)
    end
  end

  def validate_duration?
    !draft? && stop.nil?
  end
end
