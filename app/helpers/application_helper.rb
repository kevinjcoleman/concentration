module ApplicationHelper
  FLASH_TYPES = {:success => 'alert-success',
                 :error => 'alert-danger',
                 :alert => 'alert-warning',
                 :notice => 'alert-info'}

  def alert_class_for(flash_type)
    FLASH_TYPES[flash_type.to_sym] || "alert-#{flash_type.to_s}"
  end
end
