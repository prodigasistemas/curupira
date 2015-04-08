namespace :curupira do
  namespace :db do
    desc "Generate the records of the features"
    task :generate_features => :environment do
      Rails.application.eager_load!

      def eval_curupira_action(controller, action)
        feature_desc = case action.to_s
        when "index", "show", "search"
          I18n.t("curupira.features.#{controller}.show")
        when "create", "new"
          I18n.t("curupira.features.#{controller}.create")
        when "edit", "update"
          I18n.t("curupira.features.#{controller}.edit")
        when "delete", "destroy"
          I18n.t("curupira.features.#{controller}.delete")
        else
          "Other: " << action.to_s
        end
      end

      Curupira::AuthorizedController.subclasses.each do |controller|
        clazz = controller.to_s.underscore.gsub("_controller", "")

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
    end
  end
end
