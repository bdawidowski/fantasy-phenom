{"changed":true,"filter":false,"title":"registrations_controller.rb","tooltip":"/app/controllers/registration/registrations_controller.rb","value":"class Registration::RegistrationsController < Devise::RegistrationsController\n  # before_action :configure_sign_up_params, only: [:create]\n  # before_action :configure_account_update_params, only: [:update]\n\n  # GET /resource/sign_up\n  def new\n    super\n  end\n\n  # POST /resource\n  def create\n    super\n  end\n\n  # GET /resource/edit\n  def edit\n    super\n  end\n\n  # PUT /resource\n  def update\n    super\n  end\n\n  # DELETE /resource\n  def destroy\n    super\n  end\n\n  # GET /resource/cancel\n  # Forces the session data which is usually expired after sign\n  # in to be expired now. This is useful if the user wants to\n  # cancel oauth signing in/up in the middle of the process,\n  # removing all OAuth session data.\n  def cancel\n    super\n  end\n\n  # protected\n\n  # If you have extra params to permit, append them to the sanitizer.\n  def configure_sign_up_params\n    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])\n  end\n\n  # If you have extra params to permit, append them to the sanitizer.\n  def configure_account_update_params\n    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])\n  end\n\n  # The path used after sign up.\n  def after_sign_up_path_for(resource)\n    super(resource)\n  end\n\n  # The path used after sign up for inactive accounts.\n  def after_inactive_sign_up_path_for(resource)\n    super(resource)\n  end\nend\n","undoManager":{"mark":-2,"position":9,"stack":[[{"start":{"row":5,"column":2},"end":{"row":5,"column":4},"action":"remove","lines":["# "],"id":2},{"start":{"row":6,"column":2},"end":{"row":6,"column":4},"action":"remove","lines":["# "]},{"start":{"row":7,"column":2},"end":{"row":7,"column":4},"action":"remove","lines":["# "]}],[{"start":{"row":10,"column":2},"end":{"row":10,"column":4},"action":"remove","lines":["# "],"id":3},{"start":{"row":11,"column":2},"end":{"row":11,"column":4},"action":"remove","lines":["# "]},{"start":{"row":12,"column":2},"end":{"row":12,"column":4},"action":"remove","lines":["# "]}],[{"start":{"row":15,"column":2},"end":{"row":15,"column":4},"action":"remove","lines":["# "],"id":4},{"start":{"row":16,"column":2},"end":{"row":16,"column":4},"action":"remove","lines":["# "]},{"start":{"row":17,"column":2},"end":{"row":17,"column":4},"action":"remove","lines":["# "]}],[{"start":{"row":20,"column":2},"end":{"row":20,"column":4},"action":"remove","lines":["# "],"id":5},{"start":{"row":21,"column":2},"end":{"row":21,"column":4},"action":"remove","lines":["# "]},{"start":{"row":22,"column":2},"end":{"row":22,"column":4},"action":"remove","lines":["# "]}],[{"start":{"row":25,"column":2},"end":{"row":25,"column":4},"action":"remove","lines":["# "],"id":6},{"start":{"row":26,"column":2},"end":{"row":26,"column":4},"action":"remove","lines":["# "]},{"start":{"row":27,"column":2},"end":{"row":27,"column":4},"action":"remove","lines":["# "]}],[{"start":{"row":34,"column":2},"end":{"row":34,"column":4},"action":"remove","lines":["# "],"id":7},{"start":{"row":35,"column":2},"end":{"row":35,"column":4},"action":"remove","lines":["# "]},{"start":{"row":36,"column":2},"end":{"row":36,"column":4},"action":"remove","lines":["# "]}],[{"start":{"row":41,"column":2},"end":{"row":41,"column":4},"action":"remove","lines":["# "],"id":8},{"start":{"row":42,"column":2},"end":{"row":42,"column":4},"action":"remove","lines":["# "]},{"start":{"row":43,"column":2},"end":{"row":43,"column":4},"action":"remove","lines":["# "]}],[{"start":{"row":46,"column":2},"end":{"row":46,"column":4},"action":"remove","lines":["# "],"id":9},{"start":{"row":47,"column":2},"end":{"row":47,"column":4},"action":"remove","lines":["# "]},{"start":{"row":48,"column":2},"end":{"row":48,"column":4},"action":"remove","lines":["# "]}],[{"start":{"row":51,"column":2},"end":{"row":51,"column":4},"action":"remove","lines":["# "],"id":10},{"start":{"row":52,"column":2},"end":{"row":52,"column":4},"action":"remove","lines":["# "]},{"start":{"row":53,"column":2},"end":{"row":53,"column":4},"action":"remove","lines":["# "]}],[{"start":{"row":56,"column":2},"end":{"row":56,"column":4},"action":"remove","lines":["# "],"id":11},{"start":{"row":57,"column":2},"end":{"row":57,"column":4},"action":"remove","lines":["# "]},{"start":{"row":58,"column":2},"end":{"row":58,"column":4},"action":"remove","lines":["# "]}]]},"ace":{"folds":[],"scrolltop":418.5,"scrollleft":0,"selection":{"start":{"row":54,"column":0},"end":{"row":54,"column":0},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":25,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1501293583214}