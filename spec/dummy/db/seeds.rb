Rails.application.eager_load!

def eval_curupira_action(controller, action)
  case action.to_s
  when "index", "show", "search"
    feature_desc = I18n.t("curupira.features.#{controller}.show")
  when "create", "new"
    feature_desc = I18n.t("curupira.features.#{controller}.create")
  when "edit", "update"
    feature_desc = I18n.t("curupira.features.#{controller}.edit")
  when "delete", "destroy"
    feature_desc = I18n.t("curupira.features.#{controller}.delete")
  else
    feature_desc = "Other: " << action.to_s
  end
  return feature_desc
end

Curupira::AuthorizedController.subclasses.each do |controller|
  p clazz = controller.to_s.underscore.gsub("_controller", "")

  feature = Feature.create name: I18n.t("curupira.features.#{clazz}.manage"), controller: clazz
  feature.action_labels << ActionLabel.create(name: "manage")

  controller.action_methods.each do |action|
    feature_description = eval_curupira_action(clazz, action)

    feature = Feature.find_by(name: feature_description)

    if feature.present?
      feature.action_labels << ActionLabel.create(name: action)
    else
      feature = Feature.create name: feature_description, controller: clazz
      feature.action_labels << ActionLabel.create(name: action)
    end
  end
end
