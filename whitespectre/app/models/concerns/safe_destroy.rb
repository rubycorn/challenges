# SafeDestroy provides necesseary methods for implementation protected destroy

module SafeDestroy
  extend ActiveSupport::Concern

  # comment this block if items marked as deleted
  # shouldn't be available for reading by default
  included do
    if table_exists?
      default_scope { where(self.table_name.to_sym => { deleted_at: nil }) }
    end
  end

  def destroy
    if persisted?
      update_column(:deleted_at, Time.zone.now)
      reload
    else
      self.deleted_at = Time.zone.now
      super
    end
  end

  def deleted?
    !deleted_at.nil?
  end
end
