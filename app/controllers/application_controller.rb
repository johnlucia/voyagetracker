class ApplicationController < ActionController::Base
  def after_sign_up_path_for(resource)
    if resource.is_a?(User)
      "boats/2/edit"
    else
      super
    end
  end
end
