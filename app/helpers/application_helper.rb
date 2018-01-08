module ApplicationHelper

  def on_controller?(controller_name)
    controller.controller_name == controller_name
  end

  def on_action?(action_name)
    controller.action_name == action_name
  end

end
